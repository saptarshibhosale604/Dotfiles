# Git SSH Authentication
- Create a dir for the key pair
mkdir -p ~/.ssh/GitAuthentication/Dotfiles_01/

- Generate a key pair
ssh-keygen -t rsa -b 4096 -C "saptarshibhosale604@gmail.com" -f ~/.ssh/GitAuthentication/Dotfiles_01/id_rsa

- Start the ssh agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/GitAuthentication/Dotfiles_01/id_rsa

- Check the key
cat ~/.ssh/GitAuthentication/Dotfiles_01/id_rsa.pub

- Add the key to Github account
GitHub > Settings > SSH and GPG Keys > New SSH key > Paste the key > save

- Test connection
ssh -T git@github.com
