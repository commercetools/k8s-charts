<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  

- [Payment Integration Service Helm Chart](#payment-integration-service-helm-chart)
  - [Chart Details](#chart-details)
    - [Verification](#verification)
    - [Installation](#installation)
    - [Service specific mandatory environment variables](#service-specific-mandatory-environment-variables)
    - [Example](#example)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Payment Integration Service Helm Chart

This is the Helm Chart for:
  - [_commercetools Payone Integration Service_](https://github.com/commercetools/commercetools-payone-integration)
  - [_commercetools PayPal Plus Integration Service_](https://github.com/commercetools/commercetools-paypal-plus-integration) 
service applications


* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* Deploy an instance of the service (_Payone_ or _Paypal_) as on all nodes of a K8s cluster.

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

To install the chart with the release name `my-payment-integration` using a dedicated namespace(recommended):

```
$ helm upgrade --install --namespace my-shop-namespace my-payment-integration -f values.yaml .
```

The chart can be customized using the following configurable parameters:

| Parameter                       | Description                         | Default                             |
| ------------------------------- | ------------------------------------|-------------------------------------|
| `image.repository`              | docker image repository             | ***mandatory***                     |
| `image.tag`                     | docker image tag                    | ***mandatory***                     |
| `image.pullPolicy`              | docker image pull policy            | `IfNotPresent`                      |
| `nonSensitiveEnvs`              | non sensitive environment variables |                                     |
| `sensitiveEnvs`                 | sensitive environment variables     |                                     |

Specify parameters using `--set key=value[,key=value]` argument to `helm upgrade --install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm upgrade --install --namespace my-shop-namespace my-payment-integration -f values.yaml .
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
    my-payent-integration-custom-release-name \
    -f /path/to/shop/values/my-shop-staging/values.yaml \
    -f /path/to/shop/values/my-shop-staging/secrets.yaml \
    --set 'image.tag=v999.999.999' \
    . 
```