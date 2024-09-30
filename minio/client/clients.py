from io import BytesIO
from logging import Logger

import pandas as pd
import polars as pl

from minio import Minio, S3Error
from minio.commonconfig import Tags
from minio.helpers import ObjectWriteResult

from .configurations import MinIoSettings
from .primitives import ObjectMetadata


class MinIoClient:
    """MinIO client.

    Responsibilities:
    * Get object from bucket
    * Put polaris or pandas dataframe to bucket
    """

    def __init__(
        self,
        settings: MinIoSettings,
        logger: Logger,
    ) -> None:
        """Initialize the MinIo client."""
        self._settings = settings
        self._logger = logger
        self._client = Minio(
            f"{settings.endpoint.host}:{settings.endpoint.port}",
            access_key=settings.api_key,
            secret_key=settings.secret_key,
            secure=settings.endpoint.scheme == "https",
        )

    def get(self, meta: ObjectMetadata, as_polars: bool = False) -> pd.DataFrame | pl.DataFrame:
        """Get object from bucket and return Pandas or Polars DataFrame."""
        try:
            obj = self._client.get_object(meta.bucket_name, meta.object_name)
        except S3Error:
            self._logger.exception("Can't get object %s from %s", meta.object_name, meta.bucket_name)
            raise

        data = BytesIO(obj.read())
        return pl.read_parquet(data) if as_polars else pd.read_parquet(data)

    def put(self, meta: ObjectMetadata, data: pd.DataFrame | pl.DataFrame) -> ObjectWriteResult | None:
        """Put object to bucket."""
        tags = Tags()
        for key, value in meta.tags.items():
            tags[key] = value

        try:
            buffer = MinIoClient._dataframe_to_parquet(data)
            result = self._client.put_object(
                meta.bucket_name,
                meta.object_name,
                buffer,
                length=buffer.getbuffer().nbytes,
                content_type="application/octet-stream",
                tags=tags,
            )
            self._logger.debug("Successfully uploaded object %s to bucket %s", meta.object_name, meta.bucket_name)
        except S3Error:
            self._logger.exception("Error occurred while putting object")
            raise

        return result

    @staticmethod
    def _dataframe_to_parquet(data: pl.DataFrame | pd.DataFrame) -> BytesIO:
        """Serialize DataFrame (pandas or polars) to parquet format and return as BytesIO."""
        buffer = BytesIO()

        match data:
            case pd.DataFrame():
                data.to_parquet(buffer)
            case pl.DataFrame():
                data.write_parquet(buffer)

        buffer.seek(0)
        return buffer

    def create_bucket(self, bucket_name: str, ignore_if_exists: bool = True) -> None:
        """Create bucket if it does not exist.

        :param bucket_name: Name of the bucket to create
        :param ignore_if_exists: If True, do not raise an exception if the bucket already exists
        :raises ValueError: If the bucket already exists and ignore_if_exists is False
        :raises S3Error: If an error occurs while creating the bucket
        """
        is_bucket_exists = self._client.bucket_exists(bucket_name)

        if is_bucket_exists:
            if ignore_if_exists:
                self._logger.debug("Bucket already exists: %s", bucket_name)
            else:
                raise ValueError(f"Bucket {bucket_name} already exists")
        else:
            try:
                self._client.make_bucket(bucket_name)
                self._logger.debug("Created bucket: %s", bucket_name)
            except S3Error:
                self._logger.exception("Failed to create bucket: %s", bucket_name)
                raise

    def delete_bucket(self, bucket_name: str) -> None:
        """Delete a bucket in MinIO.

        :param bucket_name: Name of the bucket to delete
        :raises ValueError: If the bucket does not exist
        :raises S3Error: If an error occurs while deleting the bucket
        """
        if not self._client.bucket_exists(bucket_name):
            raise ValueError(f"Bucket {bucket_name} does not exist")
        try:
            self._client.remove_bucket(bucket_name)
            self._logger.debug("Deleted bucket: %s", bucket_name)
        except S3Error:
            self._logger.exception("Failed to delete bucket: %s", bucket_name)
            raise
