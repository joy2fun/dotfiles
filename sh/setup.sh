set -e

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
    echo "git is installed."
fi
