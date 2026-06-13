#!/bin/bash

echo "========================================"
echo "Git Push Automation Script"
echo "========================================"

echo
echo ">> Starting SSH agent..."
eval "$(ssh-agent -s)"

echo
echo ">> Adding SSH key:"
echo "ssh-add ~/.ssh/GitAuthentication/Dotfiles_02/id_rsa"
ssh-add ~/.ssh/GitAuthentication/Dotfiles_02/id_rsa

echo
echo ">> Displaying current Git status..."
echo "git status"
git status

echo
echo ">> Staging all changes..."
echo "git add ."
git add .

echo
echo ">> Displaying Git status after staging..."
echo "git status"
git status

echo
echo ">> Please enter a commit message:"
read -p "Commit Message: " commitMessage

echo
echo ">> Committing changes..."
echo "git commit -m \"$commitMessage\""
git commit -m "$commitMessage"

echo
echo ">> Pushing to remote repository..."
echo "git push"
git push

echo
echo ">> Final Git status..."
echo "git status"
git status

echo
echo "========================================"
echo "Script completed."
echo "========================================"
