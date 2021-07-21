# Cronjob Helm Chart

Helm chart for deploying an instance of a cronjob on a K8s cluster.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prerequisites](#prerequisites)
- [Chart Details](#chart-details)
  - [Verification](#verification)
  - [Installation](#installation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Prerequisites

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

To install the chart with the release name `my-cronjob` using a dedicated namespace (recommended):

```
$ helm upgrade --install my-cronjob --namespace cronjobs .
```

The chart can be customized using the following configurable parameters:

| Parameter | Description | Default |
| --- | ---| ---|
| `image.repository` | docker image repository | `MUST_BE_OVERRIDDEN` |
| `image.tag` | docker image tag | `MUST_BE_OVERRIDDEN` |
| `image.pullPolicy` | docker image pull policy | `IfNotPresent` |
| `image.command` | docker Entrypoint command array. The docker image's `ENTRYPOINT` is used if this is not provided.| `[]` |
| `image.args` | docker Entrypoint command arguments array. The docker image's `CMD` is used if this is not provided. | `[]` |
| `resources` | resource requests and limits | `{}` |
| `schedule` | schedule of the cronjob | `*/1 * * * *` |
| `runOnDemandOnly` | If set to `true` cron job will be created as suspended which ensures that it will not schedule any jobs but on the other hand would allow to trigger jobs manually based on cron job specification - for example through Kubernetes API | `false` |
| `suspend` | should suspend cronjob at start | `false` |
| `startingDeadlineSeconds` | By default if cron job fails to trigger 100 times it's scheduled job (due to jobs's unexpectedly long run or temporal network error) then cron job gets stuck and do not schedule new jobs anymore. This setting ensures that failed job executions are only counted within last 600 seconds and thus not reaching the limit. For cron schedules below 1 minutes one should consider to override default with lower value. More info: https://github.com/kubernetes/kubernetes/pull/39608 | 600 |
| `nonSensitiveEnvs` | non sensitive environment variables | |
| `sensitiveEnvs` | sensitive environment variables | |
| `concurrency` | specifies how to treat concurrent executions of a job created by this cron job | `Forbid` |
| `successfulJobsHistoryLimit` | Cron job successfulJobsHistoryLimit | 5 |
| `failedJobsHistoryLimit` | Cron job failedJobsHistoryLimit | 5 |
| `externalConfig.enabled` | Enable supplying external configuration file to the cronjob | false |
| `externalConfig.path` | Path to the external directory which contains a configuration file. This file can be supplied to the cronjob. | /app/config |
| `externalConfig.configFileName` | Name of the external config file, which can be supplied to the cronjob | config.json |
| `externalConfig.content` | Any file content that will be supplied to the cronjob | { "your": "content" } |
| `activeDeadlineSeconds` | Set an active deadline for a pod in a job. See [k8s docs](https://kubernetes.io/docs/concepts/workloads/controllers/job/#job-termination-and-cleanup) for more info. | |
| `backoffLimit` | By default, a job runs uninterrupted unless there is a failure, at which point the job defers to the `backoffLimit`. The `backoffLimit` field specifies the number of retries before marking the job as failed. | 6 |

Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm upgrade --install my-cronjob --namespace cronjobs -f values.yaml .
```
