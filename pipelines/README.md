# Auto ML Pipeline

This pipeline is used to train a model using AutoML.

## Quick Start

Initialize the pipeline with the following code:

```python
# Set up training parameters (read it from args list)
ENV_TYPE = EnvType.Prod
ROW_IDS_RANGE = RowIdsRange(from_=0, to=int(1e6))

# Initialize components
config = ConfigFactory.from_yaml(ENV_TYPE)
logger = LoggerFactory.from_config(config.logger_settings)

# Data access layer
minio_client = MinioClient(config.sinks["minio"], logger)

rawdata_repo = TrxLogRepository(config.datasets["historical_trx"], minio_client, logger)
features_repo = TrxFeaturesRepository(config.datasets["trx_features"], minio_client, logger)
model_repo = FraudModelRepository(config.datasets["models"], minio_client, logger)
```

Launch the AutoML Experiment (full pipeline):

```python
# Initialize experiment
experiment = Experiment(
    config.experiment_settings, 
    rawdata_repo, 
    features_repo,
    model_repo,
    logger
)

try:
    run = experiment.run(
        ROW_ID_RANGE,
        only_stages=[ExperimentStage.Train, ExperimentStage.Evaluate],
    )
except ExperimentException:
    logger.error("Experiment failed", exc_info=True)
    raise

logger.info(f"Experiment finished: {run.id} with status {run.status}")

```

Launch the AutoML Experiment per stage:

```python
data_ingestion_stage = PipelineStage(
    settings=config.stages["data_ingestion"],  # get stage settings by label
    in=rawdata_repo,  # input data repository
    out=rawdata_repo,  # output data repository
    logger
)

feature_engineering_stage = PipelineStage(
    settings=config.stages["feature_engineering"],
    in=features_repo,
    out=features_repo,
    logger
)

training_stage = PipelineStage(
    settings=config.stages["model_training"],
    in=features_repo,
    splitter=splitter,
    out=model_repo,
    logger
)

evaluation_stage = PipelineStage(
    settings=config.stages["model_evaluation"],
    in=features_repo,
    splitter=splitter2,
    out=model_repo,
    logger
)
```