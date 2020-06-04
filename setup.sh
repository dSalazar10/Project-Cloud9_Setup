#!/bin/bash

# SSH Key Generation
echo "Creating an RSA Key."
ssh-keygen -t rsa
echo "Add the following SSH Key to https://github.com/settings/keys"
cat /home/ec2-user/.ssh/id_rsa.pub
echo "Press Enter to continue"
read wait_input
echo "\n"

# Setup GitHub
echo "Enter repo name"
read repo_name
echo "Enter the github SSH link:"
read ssh_link
echo "Cloning repo:\n"
git clone ${ssh_link}

# Setup Scafolding
cd ${repo_name}
touch Makefile
touch requirements.txt
touch Dockerfile
mkdir .circleci
cd .circleci
touch config.yml

# Commit changes to GitHub
git add -A
git commit -m "Initial Commit"
git push origin master
echo "Enter your username:"
read user_name
git config --global user.name ${user_name}
echo "Enter your email:"
read user_email
git config --global user.email ${user_email}
git commit --amend --reset-author

# Setup Python Virtual Environment
python3 -m venv ~/.${repo_name}
source ~/.${repo_name}/bin/activate
