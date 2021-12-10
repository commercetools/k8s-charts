# Sftp Helm Chart

Helm Chart for setting up a sftp server

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

* deploying an instance of a sftp-server on a K8s cluster.

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

|          Parameter                 |                Description                 |                   Default                   |
| -----------------------------------| ------------------------------------------ | ------------------------------------------- |
| `userData`                         | Content of the file 'users.conf'           | ``                                          |
| `sshConfig.ssh_host_ed25519_key`   |  private ed25519-key                       | ``                                          | 
| `sshConfig.ssh_host_ed25519_key_pub`| public ed25519-key                        | ``                                          | 
| `sshConfig.ssh_host_rsa_key`       | private rsa-key                            | ``                                          | 
| `sshConfig.ssh_host_rsa_key_pub`   | public rsa-key                             | ``                                          | 
| `service.port`                     | Port to expose Service                     | `22`                                        |
| `service.nodePort`                 | nodePort of the  Service                   | `31000`                                     |
| `persistentVolume.enabled`         | If true, use persistent volume             | `true`                                      |
| `persistentVolume.annotations`     | annotations put on the volume              | `{}`                                        |
| `persistentVolume.accessModes`     | access modes for volume                    | `[ReadWriteOnce]`                           |
| `persistentVolume.existingClaim`   | If set, use existing PVC                   | `""`                                        |
| `persistentVolume.size`            | Size of volume                             | `20Gi`                                      |
| `persistentVolume.storageClass`    | StorageClass to be used in PVC             | not set                                     |
| `persistentVolume.subPath`         | Use subPath of existing volume             | `""`                                        |

Specify parameters using `--set key=value[,key=value]` argument to `helm upgrade --install`

Alternatively a YAML file that specifies the values for the parameters can be provided like this:

```bash
$ helm upgrade --install --namespace my-shop-namespace my-service -f values.yaml .
```

### Example

Given that you are in the current kubernetes configuration directory 
(where [Chart.yaml](Chart.yaml) and [templates/](templates/) are located).
Commands are relative to this directory. 

Install service using custom values and secrets:

```bash
$ helm upgrade --install \
    --namespace my-shop-namespace \
    my-sftp-custom-release-name \
    -f /path/to/shop/values/my-shop-staging/values.yaml \
    -f /path/to/shop/values/my-shop-staging/sftp-secret.yaml 
    . 
```

## Assigning a external IP to the SFTP

To assign a static ip to the SFTP, please execute the following command:

```bash
 kubectl expose deployment <service- name> --type=LoadBalancer --name=<loadbalancer nmae -n <namespace> --load-balancer-ip='<static ip>'
```