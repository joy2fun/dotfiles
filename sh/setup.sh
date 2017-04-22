#!/bin/bash
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
        sudo sed -i "/^root/a\%$username\tALL=(ALL)\tNOPASSWD:ALL" /etc/sudoers
    fi

    if [ ! -d "$myhome" ]; then
        sudo mkdir $myhome
    fi
else
    username=$USER
    echo "No user will be added."
    echo ""
fi

yum="yum"
aptget="apt-get"

command_exists(){
    type "$1" &> /dev/null;
}

# install ncurses & fontconfig
#if command_exists $aptget; then
#    for packages in fontconfig gcc make zsh libc6-dbg gdb libncurses5-dev libcurl-dev apache2-utils lrzsz inotify-tools byacc flex autotools-dev automake;
#    do sudo apt-get install -y $packages; done
#elif command_exists $yum; then
#    for packages in ncurses-devel fontconfig curl-devel;
#    do sudo yum install -y $packages; done
#fi

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

sleep 1
# install zsh
if ! command_exists zsh ; then
    zshgz="zsh.tar.gz"
    if [ ! -f "$zshgz" ];then
        wget http://www.zsh.org/pub/$zshgz
    fi
    rm -rf zsh-*
    tar zxvf zsh.tar.gz
    cd zsh-*

    ./configure
    make
    sudo make install
else
    echo "zsh has been installed."
fi

if [ ! -d "$myhome/temp" ];then
    sudo mkdir $myhome/temp
fi
cd $myhome/temp

sleep 1
# install oh-my-zsh
read -p "Do you need oh-my-zsh?[y/N]" needomz
case $needomz in
  [Yy]* )
    sudo git clone git://github.com/joy2fun/oh-my-zsh.git $myhome/.oh-my-zsh --depth=1
    zshbin=$(which zsh)
    sudo usermod -s $zshbin $username
    ;;
esac

sleep 1
# dot files
read -p "Do you need dotfiles?[y/N]" needdotfiles
case $needdotfiles in
  [Yy]* )
    sudo git clone git://github.com/joy2fun/dotfiles.git $myhome/dotfiles
    sudo sed -i "s/chiao/$username/g" $myhome/dotfiles/.zshrc
    sudo $myhome/dotfiles/setup.sh $myhome

    ;;
esac

if [ -n "$username" ];then
    echo "change ownership to $username."
    sudo chown $username:$username -R $myhome
fi
