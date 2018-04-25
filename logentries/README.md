# logentries Helm Chart


## Pre Requisites:

* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* Deploy an instance of logentries as a DaemonSet on all nodes of a K8s cluster.

### Installing the Chart

To install the chart with the release name `my-logentries` using a dedicated namespace(recommended):

```
$ helm install --name my-logentries--namespace logentries .
```

The chart can be customized using the following configurable parameters:

| Parameter                       | Description                                                                                                                                        | Default                          |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------| ---------------------------------|
| `image.name`                    | docker image name                                                                                                                                  | `logentries`                     |
| `image.repository`              | docker image repository                                                                                                                            | `logentries/docker-logentries`   |
| `image.tag`                     | docker image tag                                                                                                                                   | `0.2.0`                          |
| `image.pullPolicy`              | docker image pull policy                                                                                                                           | `IfNotPresent`                   |
| `logentriesToken`               | token needed for the logentries set                                                                                                                | ``                               |
| `args`                          | [arguments](https://docs.logentries.com/docs/docker-logentries-container/#section-configuration) for running logentries.                           | `-j --no-stats --no-dockerEvents`|


Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm install --name my-logentries -f values.yaml .
```

