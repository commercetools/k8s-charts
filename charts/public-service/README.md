# Publicly available Service Helm Chart

Helm Chart for services which must be public available, like shops, payment integrations etc.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prerequisites](#prerequisites)
- [Chart Details](#chart-details)
  - [Verification](#verification)
  - [Installation](#installation)
  - [Service specific mandatory environment variables](#service-specific-mandatory-environment-variables)
  - [Example](#example)
  - [Known issues](#known-issues)
    - [1. After service upgrade install `ImagePullBackOff` error is reported](#1-after-service-upgrade-install-imagepullbackoff-error-is-reported)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Prerequisites

* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* deploying an instance of a publicly available service on a K8s cluster (via HTTP from outside the cluster).

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

To install the chart with the release name `my-service` using a dedicated namespace(recommended):

```
$ helm upgrade --install --namespace my-shop-namespace my-service -f values.yaml .
```

The chart can be customized using the following configurable parameters:

| Parameter | Description | Default |
| --- | --- | --- |
| `image.repository` | docker image repository | `MUST_BE_OVERRIDDEN` |
| `image.tag` | docker image tag | `MUST_BE_OVERRIDDEN` |
| `image.pullPolicy` | docker image pull policy | `IfNotPresent` |
| `replicaCount` | number of desired pods | `1` |
| `service.type` | type of the service. | `ClusterIP` |
| `service.port` | port to access the service. | `80` |
| `containerPort` | port to access the application within the container. | `8080` |
| `updateStrategy.type` | strategy used to replace old Pods by new ones. | `RollingUpdate` |
| `updateStrategy.rollingUpdate.maxSurge` | maximum number of Pods that can be created over the desired number of Pods. | `1` |
| `updateStrategy.rollingUpdate.maxUnavailable` | maximum number of Pods that can be unavailable during the update process. | `0` |
| `minReadySeconds` | minimum number of seconds for which a newly created Pod should be ready without any of its containers crashing, for it to be considered available. | `5` |
| `resources` | resource requests and limits | `{}` |
| `nonSensitiveEnvs` | non sensitive environment variables | `{}` |
| `sensitiveEnvs` | sensitive environment variables | `{}` |
| `ingress.path` | enables Ingress | `false` |
| `ingress.annotations` | ingress path | `/` |
| `ingress.annotations` | ingress annotations | `{}` |
| `ingress.hosts` | ingress accepted hostnames | `['service-name.local']` |
| `ingress.tls` | ingress TLS configuration | `[]` |
| `livenessProbe.httpGet.path` | path to access on the HTTP server. | `/health` |
| `livenessProbe.httpGet.port` | name or number of the port to access on the container. Number must be in the range 1 to 65535. | `container-port` |
| `livenessProbe.initialDelaySeconds` | delay before liveness probe is initiated. | `15` |
| `livenessProbe.periodSeconds` | how often to perform the probe. | `10` |
| `livenessProbe.timeoutSeconds` | when the probe times out. | `5` |
| `livenessProbe.successThreshold` | minimum consecutive successes for the probe to be considered successful after having failed. | `1` |
| `livenessProbe.failureThreshold` | minimum consecutive failures for the probe to be considered failed after having succeeded. | `5` |
| `readinessProbe.httpGet.path` | path to access on the HTTP server. | `/health` |
| `readinessProbe.httpGet.port` | name or number of the port to access on the container. Number must be in the range 1 to 65535. | `container-port` |
| `readinessProbe.initialDelaySeconds`| delay before readiness probe is initiated. | `5` |
| `readinessProbe.periodSeconds` | how often to perform the probe. | `10` |
| `readinessProbe.timeoutSeconds` | when the probe times out. | `5` |
| `readinessProbe.successThreshold` | minimum consecutive successes for the probe to be considered successful after having failed. | `1` |
| `readinessProbe.failureThreshold` | minimum consecutive failures for the probe to be considered failed after having succeeded. | `5` |

Specify parameters using `--set key=value[,key=value]` argument to `helm upgrade --install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm upgrade --install --namespace my-shop-namespace my-service -f values.yaml .
```

### Service specific mandatory environment variables

1. Use values from [values/](values/) directory as templates, copy-pasting them to you project,
and later supplying them to `helm upgrade --install` command as file references.

2. To make staging configuration accessible (testable) from outer world 
[_Ingress_](https://kubernetes.io/docs/concepts/services-networking/ingress/) configuration is applied,
thus [values/staging/values.yaml](values/staging/values.yaml) contains _ingress_ configuration, 
which is different from production, exposing the service to URL requests.

### Example

Given that you are in the current kubernetes configuration directory 
(where [Chart.yaml](Chart.yaml) and [templates/](templates/) are located).
Commands are relative to this directory. 

Install service using custom values and secrets:

```bash
$ helm upgrade --install \
    --namespace my-shop-namespace \
    my-service-custom-release-name \
    -f /path/to/shop/values/my-shop-staging/values.yaml \
    -f /path/to/shop/values/my-shop-staging/secrets.yaml 
    . 
```

### Known issues

#### After service upgrade install `ImagePullBackOff` error is reported

  If `kubectl get pods` reports `ImagePullBackOff` this means `image.repository:image.tag` values
  are specified incorrectly. Verify resulting `spec.template.spec.containers[].image` in `deployment.yaml`
  using `--dry-run --debug`