#!/bin/bash

set -x -e 

sudo apt-get update  #to get the latest package list

#Install all the related libraries
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config g++ openjdk-6-jre-headless ant openjdk-6-jdk curl mono-2.0-devel nodejs npm libruby.so.1.9 libruby.so.1.9.1 libruby.so.1.9.3 zlib.so

#Check and install Mysql
echo "Checking for MySQL installation in the system....."
which mysql &> /dev/null
if [ $? != 0 ]; then
	echo "MySQL was not found in the system. Please Install and rerun this script!!"
	echo "To set up different databases with rails, please refer: https://gorails.com/setup/ubuntu/14.10"
	exit
fi	

#Check and install Ruby
echo "Checking for Ruby in the system....."
command -v ruby &> /dev/null
if [ $? != 0 ]; then
	echo "Missing status::Ruby is not found in the system."
	echo "How would you like to proceed?"
    echo "1: Installing Ruby with RVM!"
    echo "2: Installing Ruby with RBENV!"
    echo "3: Installing Ruby from source without any version manager!"
    while true
    do
    echo -n "Enter your choice: "
    read answer
    case $answer in
    	1) curl -L https://get.rvm.io | bash -s stable --ruby;rvm install 1.9.3;rvm use 1.9.3;rvm rubygems latest;
		;;
		2) git clone git://github.com/sstephenson/rbenv.git .rbenv
           echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
           echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
           git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
           source ~/.bash_profile
           rbenv install 1.9.3-p0
           rbenv local 1.9.3-p0
           rbenv rehash
           echo "Note: rbenv local 1.9.3-p0 ensures that your installation is using Ruby 1.9.3-p0 without modifying your environment in any other directory. If you wish to use 1.9.3-p0 everywhere, run rbenv global 1.9.3-p0 instead."
        ;;
        3) wget http://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p551.tar.gz
		   tar xvgf ruby-1.9.3-p551.tar.gz
		   rm -rf ruby-1.9.3-p551.tar.gz
		   cd ruby-1.9.3-p551
		   ./configure
		   make
		   sudo make install
		;;
		*) echo "This is not an option";;
	esac
done
else echo "Ruby was found in the system: `command -v ruby` !!!"		
fi

#Check and install Rails
echo "Checking for Rails....."
command -v rails &> /dev/null
if [ $? != 0 ]; then
	echo "Rails was not found in the system."
	echo "Installing Rails now.........."
	echo "gem: --no-ri --no-rdoc" > ~/.gemrc
	echo "Since Rails ships with so many dependencies these days, the script will install a Javascript runtime like NodeJS. This lets you use Coffeescript and the Asset Pipeline in Rails which combines and minifies your javascript to provide a faster production environment."
    
    sudo add-apt-repository ppa:sada-lea/node.js
    sudo apt-get update
	sudo apt-get install nodejs
	gem install rails -v=3.2.13
     
    echo "Checking if the system has rbenv, in that case rehashing is required to make the rails executable available..." 
	if [ rbenv ];then rbenv rehash;fi
    echo "Rails installed successfully: `command -v rails`"
else echo "Rails was found in the system: `command -v rails`"
fi	

#Check and install Imagemagick software for image manipulation
command -v convert &> /dev/null
if [ $? != 0 ]; then
echo "Imagemagick was not found in the system."
echo "Installing Imagemagick for image manipulation......."
wget ftp://ftp.imagemagick.org/pub/ImageMagick/ImageMagick-6.9.0-4.tar.gz
tar xvzf ImageMagick-6.9.0-4.tar.gz
cd ImageMagick-6.9.0-4
sudo ./configure
sudo make 
sudo make install
echo "Imagemagick is now installed with `identify -version`"
else echo "Imagemagick was found in the system!!!"
fi


#Clone the git repository to your local directory
echo "Cloning the SADA(bioaqua1) repository from GitHub to your local directory...."
echo "Although Git is not required but its preferred to have git installed in your system!!"
git clone https://github.com/kumarsaurabh20/bioaqua1.git

echo "Finished Installing SADA"
cat << HEAD

PLATFORMS
  ruby

DEPENDENCIES
  bio
  columnize
  fastercsv
  gravatar
  jquery-rails (~> 2.1)
  mysql2 (>= 0.3)
  paperclip (= 3.5.3)
  rails (= 3.2.13)
  rake (= 0.8.7)
  rdoc
  therubyracer
  to_xls (~> 1.0.0)
  will_paginate (~> 3.0.4)

Run 'bundle install'

Keep Imagemagick in your rails path.


HEAD 



