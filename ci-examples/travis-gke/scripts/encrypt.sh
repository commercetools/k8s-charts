#!/bin/bash
set -e
. "$(dirname "$0")/common.sh"

printf "\n- Verifying mandatory envs: [GCLOUD_KEYRING_PREFIX, ENVIRONMENT_NAME, PROJECT_NAME, GCLOUD_PROJECT_ID, HELM_VALUES_DIR]..\n"
verifyMandatoryValues GCLOUD_KEYRING_PREFIX ENVIRONMENT_NAME PROJECT_NAME GCLOUD_PROJECT_ID HELM_VALUES_DIR

KEYRING="${GCLOUD_KEYRING_PREFIX}-keyring-${ENVIRONMENT_NAME}"
KEY="${PROJECT_NAME}-key-${ENVIRONMENT_NAME}"

ENC_EXT=".enc"
SECRETS_NAME="secrets.yaml"
DECRYPTED_FILE="${HELM_VALUES_DIR}/${ENVIRONMENT_NAME}/${SECRETS_NAME}"

printf "\n- DECRYPTED_FILE file secrets ${DECRYPTED_FILE}\n"
printf "\n- ENCRYPTED_FILE file secrets ${ENCRYPTED_FILE}\n"

printf "\n- Encrypting secrets\n"

if [ ! -f ${DECRYPTED_FILE} ]; then
    printf "Secret file not found!\n"
    return 1
fi

gcloud kms encrypt \
    --project="${GCLOUD_PROJECT_ID}"\
    --location="global" \
    --keyring="$KEYRING" \
    --key="$KEY" \
    --plaintext-file="${DECRYPTED_FILE}" \
    --ciphertext-file="${DECRYPTED_FILE}${ENC_EXT}"

printf "\n- Secrets successfully decrypted\n"
# Workaround for return. Returns function parameter by reference
eval "$1='${DECRYPTED_FILE}${ENC_EXT}'"