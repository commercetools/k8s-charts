# logentries Helm Chart


## Pre Requisites:

* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* Implement a dynamically scalable logentries cluster using Kubernetes

### Installing the Chart

To install the chart with the release name `my-logentries` using a dedicated namespace(recommended):

```
$ helm install --name my-logentries--namespace logentries .
```

The chart can be customized using the following configurable parameters:

| Parameter                       | Description                                                     | Default                      |
| ------------------------------- | ----------------------------------------------------------------| -----------------------------|
| `image.repository`              | docker image name                                  | `logentries/docker-logentries` |
| `image.tag`                     | docker image tag                                   | `1.0.0`                   |
| `image.pullPolicy`              | docker image pull policy                                 | `IfNotPresent`                     |

Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm install --name my-logentries -f values.yaml .
```

