#!/bin/sh
set -e

: ${1?"Usage: <breed> [name]"}

echo "Vamp Host: $VAMP_HOST"
echo "Vamp Namespace: $VAMP_NAMESPACE"

export GHA_SHA=$GITHUB_SHA
export GHA_SHA_SHORT=$(echo $GITHUB_SHA | head -c7)
export GHA_REF_TYPE=$(echo $GITHUB_REF | cut -d'/' -f2)
export GHA_REF_BRANCH=$(echo $GITHUB_REF | cut -d'/' -f3- | tr '/' '-')
if [ "$GHA_REF_TYPE" = "tags" ]; then
    export GHA_REF_TAG=$(echo $GITHUB_REF | cut -d'/' -f3- | tr '/' '-')
fi

if [ -n "$GITHUB_EVENT_PATH" ]; then
    GITHUB_EVENT_PAYLOAD=$(cat $GITHUB_EVENT_PATH)
fi
export GHA_PR_NUMBER=$(echo $GITHUB_EVENT_PAYLOAD | jq -r '.pull_request.number // empty')

# Breed is mandatory
WORKFLOW_BREED=$1

# Compose Workflow Name
WORKFLOW_NAME=$2
if [ -z "$WORKFLOW_NAME" ]; then
    WORKFLOW_NAME=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)
    WORKFLOW_NAME=$WORKFLOW_NAME-$GHA_REF_BRANCH-$GHA_SHA_SHORT
fi

ENVS=$(export | grep -o 'GHA_.*' |  cut -c5-)
for i in ${ENVS}
do
    KEY=$(echo $i | cut -d'=' -f1)
    VALUE=$(echo $i | cut -d'=' -f2- | tr -d '"' | tr -d "'" | sed -e 's/\\/-/g; s/\//-/g; s/&/\\\&/g')
    WORKFLOW_NAME=$(echo $WORKFLOW_NAME | sed "s/%$KEY%/$VALUE/g")
done

PAYLOAD=$(echo '{"kind":"workflows","schedule":"daemon",,"environment_variables":{}}' | jq --arg breed "$WORKFLOW_BREED" --arg name "$WORKFLOW_NAME" '.name = $name | .breed = $breed')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_REF" '.environment_variables.GITHUB_REF = $value')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_SHA" '.environment_variables.GITHUB_SHA = $value')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_ACTOR" '.environment_variables.GITHUB_ACTOR = $value')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_ACTION" '.environment_variables.GITHUB_ACTION = $value')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_WORKFLOW" '.environment_variables.GITHUB_WORKFLOW = $value')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_TOKEN" '.environment_variables.GITHUB_TOKEN = $value')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_EVENT_NAME" '.environment_variables.GITHUB_EVENT_NAME = $value')
PAYLOAD=$(echo $PAYLOAD | jq --arg value "$GITHUB_EVENT_PAYLOAD" '.environment_variables.GITHUB_EVENT_PAYLOAD = $value')

WORKFLOW_ENVS=$(export | grep WF_ | cut -c11-)
for i in ${WORKFLOW_ENVS}
do
    KEY=$(echo $i | cut -d'=' -f1)
    VALUE=$(echo $i | cut -d'=' -f2- | tr -d '"' | tr -d "'")
    PAYLOAD=$(echo $PAYLOAD | jq --arg value "$VALUE" --arg key "$KEY" '.environment_variables[$key] = $value')
done

echo $PAYLOAD > ./payload.json
vamp create workflow -f ./payload.json