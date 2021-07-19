#!/usr/bin/env bash

# PARAMETERS

# Base directory, where script create folder to repositories
BASE_DIR=/home/tester

# Directory name to store all repositories
REPOS_DIR=repositories

# Current supporting only cloning with SSH type
# If you want cloning from different accounts, need declare repository list for each account
declare -a myAccount1=("repo1" "repo2")
declare -a corpAccount2=("repo1")

# Set all accounts
declare -a accountList=("myAccount1" "corpAccount2")

# SCRIPT

if [ ! -d "$BASE_DIR" ]; then
  echo -e "Can't find base path [$BASE_DIR]"
  exit 1
fi

cd $BASE_DIR

if [ ! -d "$REPOS_DIR" ]; then
  echo -e "Directory [$REPOS_DIR] not exists, creating..."
  mkdir $REPOS_DIR
else
  echo -e "Directory [$REPOS_DIR] already exists, skipping..."
fi

cd $REPOS_DIR

for account in "${accountList[@]}"; do
  declare -n repos="$account"
  echo -e "\nStarting checking profile [${account}] with repositories [${repos[@]}]"
  for repo in "${repos[@]}"; do
    if [ ! -d "$repo" ]; then
      echo -e "\nRepository [$repo] not cloning, lets try..."
      GIT_URL="git@github.com:$account/$repo.git"
      git clone "$GIT_URL"
      echo -e "Successful cloning repository [$repo]"
    else
      echo -e "\nRepository [$repo] already cloning, skipping..."
    fi
  done
done

echo -e "\nAll done!"
