from pydantic import BaseModel


class ObjectMetadata(BaseModel):
    """MinIO object metadata.

    Responsibilities:
    * Encapsulate MinIO object metadata
    """

    bucket_name: str
    object_name: str
    version: str
    tags: dict
    is_data_frame: bool = True
