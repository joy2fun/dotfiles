#/bin/bash
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
        sudo sed -i "/^root/a\%$username\tALL=(ALL)\tALL" /etc/sudoers
    fi
else
    echo "No user will be added."
    echo ""
fi

yum="yum"
aptget="apt-get"

command_exists(){
    type "$1" &> /dev/null;
}

# install ncurses & fontconfig
if command_exists $yum; then
    sudo yum install -y ncurses-devel
    sudo yum install -y fontconfig
elif command_exists $aptget; then
    apt-get install -y libncurses5-dev
fi

# install git
git="git"
if ! command_exists $git; then
    echo "install git ..."
    if command_exists $aptget; then
        echo "apt-get install git"
        sudo apt-get install -y git
    elif command_exists $yum; then
        echo "yum install git"
        sudo yum install -y git
    else
        echo "how to ?"
    fi
else
    echo "git has been installed."
fi

# install zsh
if ! command_exists zsh ; then
    zshgz="zsh.tar.gz"
    if [ ! -f "$zshgz" ];then
        wget http://www.zsh.org/pub/$zshgz
    fi
    rm -rf zsh-*
    tar zxvf zsh.tar.gz
    cd zsh-*

    sudo ./configure
    sudo make
    sudo make install
else
    echo "zsh has been installed."
fi

if [ ! -d "$myhome/temp" ];then
    sudo mkdir temp
fi
cd $myhome/temp

# install oh-my-zsh
read -p "Do you need oh-my-zsh?[y/N]" needomz
case $needomz in
  [Yy]* )
    sudo git clone git://github.com/robbyrussell/oh-my-zsh.git $myhome/.oh-my-zsh
    sudo usermod -s /usr/local/bin/zsh $username

    ;;
esac

# dot files
read -p "Do you need dotfiles?[y/N]" needdotfiles
case $needdotfiles in
  [Yy]* )
    sudo git clone git://github.com/joy2fun/dotfiles.git $myhome/dotfiles
    sudo sed -i "s/chiao/$username/g" $myhome/dotfiles/.zshrc
    ;;
esac

if [ -n "$username" ];then
    echo "change ownership to $username."
    sudo chown $username:$username -R $myhome
fi
