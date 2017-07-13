codigo nuevo desde el portatil


bajarse el keychain y poner esta linea en el .bashrc
## ssh-agent persistency
eval `keychain --eval --agents ssh id_rsa`

no funciona del todo bien, hay que ponerlo alguna ve

ssh-keygen -t rsa -b 4096 -C "gelowin33@yahoo.es"
cd .ssh/
ll
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat id_rsa.pub 
cat /etc/gitconfig
cd ..
ll
mkdir git
cd git
ll
git config --global user.name "Angel Martinez-Perez"
git config --global user.email gelowin33@yahoo.es
git config --global core.editor emacs
exit




podria ser algo del know_host, pero no lo creo

###########################################################3
## modifico el ~/.ssh/config
Host github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/id_rsa

## chmod 600 ~/.ssh/config

