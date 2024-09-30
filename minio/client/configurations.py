from pydantic import HttpUrl
from pydantic_settings import BaseSettings


class MinIoSettings(BaseSettings):
    """MinIO settings."""

    endpoint: HttpUrl
    api_key: str
    secret_key: str
    request_timeout: int = 60
