set -e

myhome=~

# add user
read -p "What is your name: " username

if [ -n "$username" ]
then
    echo "You have picked a name: $username"
    myhome=/home/$username
    userexists=false
    getent passwd $username >/dev/null 2>&1 && userexists=true
    if $userexists; then
        echo "user exists!"
    else
        echo "add user $username"
        sudo useradd -d $myhome $username
        sudo passwd $username

        # add sudoer
        sudo tee -a "%$username  ALL=(ALL:ALL)   ALL" /etc/sudoers

    fi
else
    echo "No user will be added."
    echo ""
fi

# install git
git="git"
yum="yum"
aptget="apt-get"

command_exists(){
    type "$1" &> /dev/null;
}

if ! command_exists $git; then
    echo "install git ..."
    if command_exists $aptget; then
        echo "apt-get install git"
        sudo apt-get install -y git
    elif command_exists $yum; then
        echo "yum install get"
        sudo yum install -y git
    else
        echo "how to ?"
    fi
else
    echo "git has been installed."
fi

# install zsh
cd $myhome
sudo mkdir temp
cd temp

wget http://www.zsh.org/pub/zsh.tar.gz
tar zxvf zsh.tar.gz
cd zsh-*

sudo ./configure
sudo make
sudo make install

# install oh-my-zsh
sudo git clone git://github.com/robbyrussell/oh-my-zsh.git $myhome/.oh-my-zsh
sudo usermod -s /usr/local/bin/zsh $username

# set up dot files
sudo git clone git://github.com/joy2fun/dotfiles.git $myhome/dotfiles
sudo $myhome/dotfiles/setup

if [ -n "$username"]
then
    sudo chown $username:$username -R $myhome
fi
