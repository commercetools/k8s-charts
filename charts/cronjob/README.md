# Cronjob Helm Chart

Helm chart for deploying an instance of a cronjob on a K8s cluster.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Pre Requisites](#pre-requisites)
- [Chart Details](#chart-details)
  - [Verification](#verification)
  - [Installation](#installation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Pre Requisites

* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* Implement a customizable cronjob using Kubernetes:


### Verification

Lint the chart

```
$ helm lint
```

To test the generated k8s resources from the helm chart:

```
$ helm upgrade --install --dry-run --debug my-new-chart  .
```

### Installation

To install the chart with the release name `my-cronjob` using a dedicated namespace(recommended):

```
$ helm upgrade --install my-cronjob --namespace cronjobs .
```

The chart can be customized using the following configurable parameters:

| Parameter | Description | Default |
| --- | ---| ---|
| `image.repository` | docker image repository | `commercetools/commercetools-email-retry-processor` |
| `image.tag` | docker image tag | `1.0.0` |
| `image.pullPolicy` | docker image pull policy | `IfNotPresent` |
| `resources` | resource requests and limits | `{}` |
| `schedule` | schedule of the cronjob | `*/1 * * * *` |
| `nonSensitiveEnvs` | non sensitive environment variables | |
| `sensitiveEnvs` | sensitive environment variables | |
| `concurrency` | specifies how to treat concurrent executions of a job created by this cron job | `Forbid` |
| `successfulJobsHistoryLimit` | Cron job successfulJobsHistoryLimit | 5 |
| `failedJobsHistoryLimit` | Cron job failedJobsHistoryLimit | 5 |


Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm upgrade --install my-cronjob --namespace cronjobs -f values.yaml .
```

