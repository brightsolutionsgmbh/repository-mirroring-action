#!/usr/bin/env sh
set -eu

if [ ! -z "$INPUT_SSH_PRIVATE_KEY" ]; then
  /setup-ssh.sh
  export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l $INPUT_SSH_USERNAME"
fi

if [ ! -z  "$INPUT_PERSONAL_ACCESS_TOKEN" ]; then
  git config user.name "$INPUT_USERNAME"
  git config user.password "$INPUT_PERSONAL_ACCESS_TOKEN"
fi

git remote add mirror "$INPUT_TARGET_REPO_URL"
git lfs fetch --all
git push --tags --force --prune -v mirror "refs/remotes/origin/*:refs/heads/*"
