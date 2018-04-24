# commercetools-email-retry-processor Helm Chart

This is an implementation of commercetools-email-retry-processor found here:

 * https://github.com/commercetools/commercetools-email-retry-processor

## Pre Requisites:

* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* Implement a dynamically scalable commercetools-email-retry-processor cluster using Kubernetes

### Installing the Chart

To install the chart with the release name `my-email-processor` using a dedicated namespace(recommended):

```
$ helm install --name my-email-processor --namespace commercetools-email-retry-processor .
```

The chart can be customized using the following configurable parameters:

| Parameter                       | Description                                                     | Default                      |
| ------------------------------- | ----------------------------------------------------------------| -----------------------------|
| `image.repository`              | docker image name                                  | `commercetools/commercetools-email-retry-processor` |
| `image.tag`                     | docker image tag                                   | `1.0.0`                   |
| `image.pullPolicy`              | docker image pull policy                                 | `IfNotPresent`                     |
| `resources`                     | resource requests and limits                                    | `{}`                         |
| `schedule`                     | schedule of the cronjob                                    | `*/1 * * * *`                         |

Specify parameters using `--set key=value[,key=value]` argument to `helm install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm install --name my-email-processor -f values.yaml .
```

