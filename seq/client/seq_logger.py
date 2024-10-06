"""Abstract factories and builders."""

# %% Imports dependencies ----
import os
import platform
import threading
from importlib import import_module

from logging import Formatter, Handler, Logger, StreamHandler, getLogger
from logging.handlers import TimedRotatingFileHandler
from typing import Any, Final

from pydantic_settings import BaseSettings

import seqlog.structured_logging
from seqlog.structured_logging import SeqLogHandler


# %% Logger settings ----
class LoggerSettings(BaseSettings):
    """Logging settings for the application."""

    level: str
    message_format: str
    handlers: dict[str, dict[str, Any]]


# %% Logger Factory ----
class LoggerFactory:
    """Factory to create and configure loggers."""

    LogInterval: Final[int] = 1
    LogBackup: Final[int] = 30


    @staticmethod
    def create_logger(service_name: str, settings: LoggerSettings, **env_vars: Any) -> Logger:
        """Create and configure a logger based on settings and environment variables."""
        if all(handler not in settings.handlers for handler in ["console", "file", "seq"]):
            raise ValueError("At least one of handler must be specified in settings")

        logger = getLogger(service_name)
        logger.setLevel(settings.level)

        handlers: list[Handler] = []
        if settings.handlers.get("console"):
            handlers.append(LoggerFactory._configure_stream_handler(settings.handlers["console"]))
        if settings.handlers.get("file"):
            handlers.append(LoggerFactory._configure_file_handler(logger, settings.handlers["file"]))
        if settings.handlers.get("seq"):
            gunicorn_error_logger = getLogger("gunicorn.error")
            uvicorn_access_logger = getLogger("uvicorn.access")
            uvicorn_access_logger.handlers = gunicorn_error_logger.handlers

            logger.handlers = gunicorn_error_logger.handlers

            seqlog.structured_logging.set_global_log_properties(
                Application=service_name,
                ApiVersion=env_vars["api_version"],
                Environment=env_vars["env_type"].value,
                MachineName=platform.node(),
                ProcessID=os.getpid(),
                ThreadID=threading.get_ident(),
            )
            handlers.append(LoggerFactory._configure_seq_handler(settings.handlers["seq"]))

            for handler in handlers:
                log_format = Formatter(
                    settings.message_format,
                    defaults={"service_name": service_name, "env_type": env_vars["env_type"].value},
                )
                handler.setFormatter(log_format)
                logger.addHandler(handler)

        return logger

    @staticmethod
    def _configure_stream_handler(settings: dict[str, Any]) -> Handler:
        """Configure the stream handler for logger."""
        stream = getattr(import_module("sys"), settings.get("stream_type", "stdout"))
        handler = StreamHandler(stream=stream)

        level = settings.get("level")
        if level:
            handler.setLevel(level)

        return handler

    @staticmethod
    def _configure_file_handler(logger: Logger, settings: dict[str, Any]) -> Handler:
        """Configure the file handler for logger."""
        handler = TimedRotatingFileHandler(
            filename=settings.get("filename", f"{settings.get("log_dir")}/{logger.name}.log"),
            when=settings.get("when", "midnight"),
            interval=settings.get("interval", LoggerFactory.LogInterval),
            backupCount=settings.get("backup_count", LoggerFactory.LogBackup),
            utc=True,
        )

        level = settings.get("level")
        if level:
            handler.setLevel(level)

        return handler

    @staticmethod
    def _configure_seq_handler(settings: dict[str, Any]) -> Handler:
        handler = SeqLogHandler(
            server_url=settings.get("server_url"),
            api_key=settings.get("api_key"),
            batch_size=settings.get("batch_size"),
            auto_flush_timeout=settings.get("auto_flush_timeout"),
            json_encoder_class=settings.get("json_encoder_class"),
        )

        level = settings.get("level")
        if level:
            handler.setLevel(level)

        return handler
