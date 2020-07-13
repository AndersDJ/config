set -x GOROOT /usr/local/cellar/go/1.14/libexec
set -x GOPATH $HOME/Documents/GoProject
set -x PATH $PATH:$GOROOT/bin 
set -x PATH $PATH:$GOPATH/bin 
set -x GO111MODULE auto


set -x NODE_PATH /usr/local/lib/node_modules

set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-11.0.4.jdk/Contents/Home
set -x CLASS_PATH $JAVA_HOME/lib
set -x PATH $PATH:$JAVA_HOME/bin

set -x MYVIMRC ~/.config/nvim/init.vim


set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.aliyun.com/homebrew/homebrew-bottles

set -x ANDROID_HOME /Users/diaojian/Library/Android/sdk
set -x PATH $PATH:$ANDROID_HOME/tools
set -x PATH $PATH:$ANDROID_HOME/platform-tools

set -x EDITOR /usr/local/bin/nvim

set -x ZOOKEEPER_HOME /usr/local/zookeeper
set -x PATH $PATH:$ZOOKEEPER_HOME/bin
set -x PATH $PATH:/usr/local/apache-maven-3.6.3/bin




