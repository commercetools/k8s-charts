# Sftp Helm Chart

Helm Chart for setting up an sftp server

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Sftp Helm Chart](#sftp-helm-chart)
  - [Prerequisites](#prerequisites)
  - [Chart Details](#chart-details)
    - [Verification](#verification)
    - [Installation](#installation)
    - [Example](#example)
  - [Assigning a external IP to the SFTP](#assigning-a-external-ip-to-the-sftp)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->
## Prerequisites

* Kubernetes 1.8+ with beta APIs enabled

## Chart Details

This chart will do the following:

* Deploying an instance of a sftp-server on a K8s cluster.Hereby the deployment uses the image: [atmoz/sftp:latest](https://github.com/atmoz/sftp)

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

|          Parameter                 |                Description                 |   Default   |required|
| -----------------------------------| ------------------------------------------ | ----------- |--------|
| `userData`                         | Content of the file 'users.conf'           | ``|true|
| `sshConfig.ssh_host_ed25519_key`   |  private ed25519-key                       | ``|true| 
| `sshConfig.ssh_host_ed25519_key_pub`| public ed25519-key                        | ``|true| 
| `sshConfig.ssh_host_rsa_key`       | private rsa-key                            | ``|true| 
| `sshConfig.ssh_host_rsa_key_pub`   | public rsa-key                             | ``|true| 
| `service.port`                     | Port to expose Service                     | `22` |false| 
| `service.nodePort`                 | nodePort of the  Service                   | `31000`  |false| 
| `persistentVolume.enabled`         | If true, use persistent volume             | `true` |false| 
| `persistentVolume.annotations`     | annotations put on the volume              | `{}` |false| 
| `persistentVolume.accessModes`     | access modes for volume                    | `[ReadWriteOnce]` |false| 
| `persistentVolume.existingClaim`   | If not set, a new persistence volume claim(PVC) is created while deployment                | `""` |false| 
| `persistentVolume.size`            | Size of volume                             | `20Gi` |false| 
| `persistentVolume.storageClass`    | StorageClass to be used in PVC             | not set  |false| 
| `persistentVolume.subPath`         | Use subPath of existing volume             | `""`    |false|  

Specify parameters using `--set key=value[,key=value]` argument to `helm upgrade --install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm upgrade --install --namespace my-shop-namespace my-service -f values.yaml .
```

### Example

Given that you are in the current kubernetes configuration directory 
(where [Chart.yaml](Chart.yaml) and [templates/](templates/) are located).
Note that, following commands are relative to the working directory:

Execute following helm command to create SFTP service:

```bash
$ helm upgrade --install \
    --namespace my-shop-namespace \
    my-sftp-custom-release-name \
    -f /path/to/shop/values/my-shop-staging/values.yaml \
    -f /path/to/shop/values/my-shop-staging/sftp-secret.yaml 
    . 
```

## Assigning an external IP to the SFTP

To assign a static ip to the SFTP, please execute the following command:

```bash
 kubectl expose deployment <service-name> --type=LoadBalancer --name=<loadbalancer-name> -n <namespace> --load-balancer-ip='<static ip>'
```