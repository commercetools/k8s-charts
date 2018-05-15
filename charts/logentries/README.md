# logentries Helm Chart

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

* Deploy an instance of logentries as a DaemonSet on all nodes of a K8s cluster.

### Verification

Lint the chart

```
$ helm lint
```

To test the generated k8s resources from the helm chart

```
$ helm upgrade --install --dry-run --debug my-new-chart  .
```

### Installation

To install the chart with the release name `my-logentries` using a dedicated namespace (recommended):

```
$ helm install --name my-logentries --namespace logentries .
```

The chart can be customized using the following configurable parameters:

| Parameter | Description | Default |
| --- | ---| --- |
| `image.name` | docker image name | `logentries` |
| `image.repository` | docker image repository | `logentries/docker-logentries` |
| `image.tag` | docker image tag | `0.2.1` |
| `image.pullPolicy` | docker image pull policy | `IfNotPresent` |
| `logentriesToken` | token needed for the logentries set | `` |
| `resources` | resource requests and limits | `{}` |
| `args` | [arguments](https://docs.logentries.com/docs/docker-logentries-container/#section-configuration) for running logentries. | `-j --no-stats --no-dockerEvents`|


Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm upgrade --install my-logentries --namespace logentries -f values.yaml .
```

