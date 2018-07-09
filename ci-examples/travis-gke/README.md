# Travis scripts examples for GKE

Travis scripts examples for building and deploying an application in GKE (Google Kubernetes Engine) 
  

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prerequisites](#prerequisites)
- [Scripts](#scripts)
  - [How to use the scripts](#how-to-use-the-scripts)
  - [gcloud-install-sdk.sh](#gcloud-install-sdksh)
  - [gcloud-login.sh](#gcloud-loginsh)
  - [k8s-charts-clone.sh](#k8s-charts-clonesh)
  - [decrypt.sh](#decryptsh)
  - [encrypt.sh](#encryptsh)
  - [gcloud-push-image.sh](#gcloud-push-imagesh)
  - [gcloud-deploy.sh](#gcloud-deploysh)
  - [helm-upgrade.sh](#helm-upgradesh)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Prerequisites
* Travis
* Google Cloud Platform account
  

## Scripts

 - common.sh: common functions that are used by other scripts
 - gcloud-install-sdk.sh: installs [Google Cloud SDK](https://cloud.google.com/sdk) and [Helm](https://helm.sh)
 - gcloud-login.sh: script for logging in Google Cloud Platform
 - k8s-charts-clone.sh: pulls the charts from the [k8s-charts project](https://github.com/commercetools/k8s-charts) 
 - decrypt.sh: decrypts the secrets.yaml.enc file that includes all sensitive variables
 - encrypt.sh: encrypts the secrets.yaml file that includes all sensitive variables to secrets.yaml.enc file
 - gcloud-push-image.sh: pushes the Docker image in defined the Google Cloud container registry
 - gcloud-deploy.sh: deploys the application in the Google Cloud cluster
 - helm-upgrade.sh upgrades the Helm chart template  

### How to use the scripts
You can find an example of how to use them in [.travis.yml](https://github.com/commercetools/k8s-charts/tree/master/ci-examples/travis-gke) example file

However, you can also manually run the scripts one by one by setting the correct environment variables necessary for each script

### gcloud-install-sdk.sh
This script installs the Google Cloud SDK and Helm. 

It needs the following environment variables to be set: 

GCLOUD_HOME: path to the directory where the Google Cloud SDK will be installed 
HELM_VERSION: helm version that we want to be installed
HELM_HOME: path to the directory where Helm will be installed 
```
$ export GCLOUD_HOME=/gcloud
$ export HELM_VERSION=2.8.2
$ export HELM_HOME=/helm
$ ./gcloud-install-sdk.sh
```

### gcloud-login.sh
This script logs your terminal in Google Cloud. 

It needs the following environment variables to be set: 

GCLOUD_KEY: JSON with your Google Cloud service account 
GCLOUD_PROJECT_ID: your Google Cloud project ID
GCLOUD_ZONE: your Google Cloud zone
```
$ export GCLOUD_KEY={"type":"service_account","project_id":"dummy-project-id","private_key_id":"dummy-project-key"...}
$ export GCLOUD_PROJECT_ID=dummy-project-id
$ export GCLOUD_ZONE=europe-west3-a
$ ./gcloud-login.sh
```

### k8s-charts-clone.sh
Clones the charts from the [k8s-charts project](https://github.com/commercetools/k8s-charts) 

It needs the following environment variables to be set: 

HELM_CHARTS_REPO: Git repo to k8s-charts project
HELM_CHARTS_VERSION: version that we want to clone
CHARTS_DIR: path to the directory where the charts will be installed
```
$ export HELM_CHARTS_REPO=https://github.com/commercetools/k8s-charts.git
$ export HELM_CHARTS_VERSION=1.6.0
$ export CHARTS_DIR=/charts
$ ./k8s-charts-clone.sh
```

### decrypt.sh
This script decrypts the secrets.yaml.enc values file that includes all sensitive variables. The secrets.yaml.enc should be set in the following path HELM_VALUES_DIR/ENVIRONMENT_NAME/secrets.yaml.enc 

It uses Google Cloud Key Management Service (KMS), and it's based on the following conventions:

 - key ring naming convention:
   GCLOUD_KEYRING_PREFIX-keyring-ENVIRONMENT_NAME.  i.e
   myproject-keyring-staging 
   
 - key naming convention: PROJECT_NAME-key-ENVIRONMENT_NAME. i.e myproject-key-staging

It needs the following environment variables to be set: 

GCLOUD_KEYRING_PREFIX: prefix of your Google key ring
ENVIRONMENT_NAME: environment you want to decrypt its variables
PROJECT_NAME:  your project name
GCLOUD_PROJECT_ID: your Google Cloud project ID
HELM_VALUES_DIR: directory with your Helm values files

```
$ export GCLOUD_KEYRING_PREFIX=dummy-project
$ export ENVIRONMENT_NAME=production
$ export PROJECT_NAME=dummy-project-name
$ export GCLOUD_PROJECT_ID=dummy-project-id
$ export HELM_VALUES_DIR=/k8s
$ ./decrypt.sh
```

### encrypt.sh
This script encrypts the secrets.yaml file that includes all sensitive variables to secrets.yaml.enc file. The secrets.yaml should be set in the following path HELM_VALUES_DIR/ENVIRONMENT_NAME/secrets.yaml

It uses Google Cloud Key Management Service (KMS), and it's based on the following conventions:

 - key ring naming convention:
   GCLOUD_KEYRING_PREFIX-keyring-ENVIRONMENT_NAME.  i.e
   myproject-keyring-staging 
   
 - key naming convention: PROJECT_NAME-key-ENVIRONMENT_NAME. i.e myproject-key-staging

It needs the following environment variables to be set: 

GCLOUD_KEYRING_PREFIX: prefix of your Google key ring
ENVIRONMENT_NAME: environment you want to encrypt its variables
PROJECT_NAME:  your project name
GCLOUD_PROJECT_ID: your Google Cloud project ID
HELM_VALUES_DIR: directory with your Helm values files

```
$ export GCLOUD_KEYRING_PREFIX=dummy-project
$ export ENVIRONMENT_NAME=production
$ export PROJECT_NAME=dummy-project-name
$ export GCLOUD_PROJECT_ID=dummy-project-id
$ export HELM_VALUES_DIR=/k8s
$ ./encrypt.sh
```

### gcloud-push-image.sh
This script pushes the Docker image in the defined Google Cloud container registry. 

It needs the following environment variables to be set: 

GCLOUD_PROJECT_ID: your Google Cloud project ID
PROJECT_NAME: your project name
REGISTRY_NAME: your container registry name
DOCKER_TAG: the tag you want for your Docker image 
```
$ export GCLOUD_PROJECT_ID=dummy-project-id
$ export PROJECT_NAME=dummy-project-name
$ export REGISTRY_NAME=eu.gcr.io
$ export DOCKER_TAG=v1.0
$ ./gcloud-push-image.sh
```

### gcloud-deploy.sh
This script deploys the application in the Google Cloud cluster

It's based on the following convention:

 - cluster naming: GCLOUD_CLUSTER_NAME_PREFIX-ENVIRONMENT_NAME

It needs the following environment variables to be set: 

GCLOUD_ZONE: your Google Cloud zone
GCLOUD_CLUSTER_NAME_PREFIX:  your cluster name prefix
PROJECT_NAME: your project name
ENVIRONMENT_NAME: your cluster environment
HELM_CHART_TEMPLATE_NAME: the base chart template according to the available [templates](https://github.com/commercetools/k8s-charts/tree/master/charts)
HELM_VALUES_DIR: directory with your Helm values files
DOCKER_TAG: the docker image tag you want to deploy

```
$ export GCLOUD_ZONE=europe-west3-a
$ export GCLOUD_CLUSTER_NAME_PREFIX=mycluster
$ export PROJECT_NAME=dummy-project-name
$ export ENVIRONMENT_NAME=production
$ export HELM_CHART_TEMPLATE_NAME=cronjob
$ export HELM_VALUES_DIR=/k8s
$ export DOCKER_TAG=v1.0
$ ./gcloud-deploy.sh
```

### helm-upgrade.sh
This script upgrades the Helm chart template . 

It needs the following environment variables to be set: 

APPLICATION_NAME: the name of your application
ENVIRONMENT_NAME: the selected environment
HELM_CHART_TEMPLATE_NAME:  the base chart template according to the available [templates](https://github.com/commercetools/k8s-charts/tree/master/charts)
HELM_VALUES_DIR: directory with your Helm values files
IMAGE_TAG: the docker image tag
```
$ export APPLICATION_NAME=dummy-application
$ export ENVIRONMENT_NAME=production
$ export HELM_CHART_TEMPLATE_NAME=cronjob
$ export HELM_VALUES_DIR=/k8s
$ export IMAGE_TAG=v1.0
$ ./helm-upgrade.sh
```