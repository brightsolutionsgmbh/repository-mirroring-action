#!/usr/bin/env sh
set -eu

if [ ! -z "$INPUT_SSH_PRIVATE_KEY" ]; then
  /setup-ssh.sh
  export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l $INPUT_SSH_USERNAME"
  git remote add mirror "$INPUT_TARGET_REPO_URL"
fi

if [ ! -z  "$INPUT_PERSONAL_ACCESS_TOKEN" ]; then
  MIRROR_URL=$(echo "$INPUT_TARGET_REPO_URL" | sed -e "s/^https:\/\///")
  git remote add mirror "https://$INPUT_USERNAME:$INPUT_PERSONAL_ACCESS_TOKEN@$MIRROR_URL"
fi

git push --tags --force --prune -v mirror "refs/remotes/origin/*:refs/heads/*"
