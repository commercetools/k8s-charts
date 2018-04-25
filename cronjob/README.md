# Cronjob Helm Chart

Helm chart for deploying an instance of a cronjob on a K8s cluster.

## Pre Requisites:

* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* Implement a customizable cronjob using Kubernetes

### Installing the Chart

To install the chart with the release name `my-cronjob` using a dedicated namespace(recommended):

```
$ helm install --name my-cronjob --namespace cronjob .
```

The chart can be customized using the following configurable parameters:

| Parameter                       | Description                                                     | Default                      |
| ------------------------------- | ----------------------------------------------------------------| -----------------------------|
| `image.name`                    | docker image name                                  | `` |
| `image.repository`              | docker image repository                            | `` |
| `image.tag`                     | docker image tag                                   | ``            |
| `image.pullPolicy`              | docker image pull policy                           | `IfNotPresent`                     |
| `resources`                     | resource requests and limits                       | `{}`                         |
| `schedule`                      | schedule of the cronjob                            | `*/1 * * * *`                     |
| `nonSensitiveEnvs`              | non sensitive environment variables                |             |
| `sensitiveEnvs`                 | sensitive environment variables                    |                          |

Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm install --name my-cronjob -f values.yaml .
```

