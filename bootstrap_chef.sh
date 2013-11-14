#!/usr/bin/env bash
# call like this on the target server:
# NODENAME='foo' CHEF_ENV='production' GIT_USER='git_username' GIT_PASSWORD='git_password' bash < bootstrap_chef.sh
 
set -e
export CHEF_DIR="${HOME}/chef"
#export RUNLIST='["role[foo]","recipe[bar]"]'
export RUNLIST='[ "recipe[apt]", "recipe[basedevserv]" ]'
#export CHEFREPO='git@github.com:SriniKancharla/cq-dev-server-provision'
export CHEFREPO='https://$GIT_USER:$GIT_PASSWORD@github.com/SriniKancharla/cq-dev-server-provision.git'

sudo rm -rf $CHEF_DIR
mkdir -p "$CHEF_DIR"
 
echo "-- Installing Packages"

sudo apt-get update
 
yes | sudo apt-get install ruby1.9.1 ruby1.9.1-dev \
rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 \
build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
        --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
                  /usr/share/man/man1/ruby1.9.1.1.gz \
        --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
        --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
        --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1

# choose your interpreter
# changes symlinks for /usr/bin/ruby , /usr/bin/gem
# /usr/bin/irb, /usr/bin/ri and man (1) ruby
sudo update-alternatives --config ruby
sudo update-alternatives --config gem

# now try
echo "----- Ruby Version ----"
ruby --version 

# Install Latest git and its dependencies
sudo apt-get install -y libcurl4-openssl-dev libexpat1-dev gettext libz-dev libssl-dev build-essential

# Download and compile from source
cd /tmp
curl --progress https://git-core.googlecode.com/files/git-1.8.4.1.tar.gz | tar xz
cd git-1.8.4.1/
make prefix=/usr/local all

# Install into /usr/local/bin
sudo make prefix=/usr/local install

echo "----- Git Version ----"
git --version 

#yes | sudo apt-get install ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert git-core

echo "-- Installing RubyGems"
 
if [[ ! (`command -v gem`) ]]; then
  cd /tmp
  wget -c http://production.cf.rubygems.org/rubygems/rubygems-1.7.2.tgz
  tar zxf rubygems-1.7.2.tgz
  cd rubygems-1.7.2
  sudo ruby setup.rb --no-format-executable
fi
 
echo "-- Installing Chef gem"
 
if [[ ! (`command -v ohai` && `command -v chef-solo`) ]]; then
  sudo gem install chef ohai --no-ri --no-rdoc
fi
 
mkdir -p "$HOME/.chef"
cat <<EOF > $HOME/.chef/knife.rb
log_level                :debug
log_location             STDOUT
node_name                '$NODENAME'
cookbook_path [ '$CHEF_DIR/cookbooks', '$CHEF_DIR/site-cookbooks' ]
cookbook_copyright "Cheftest Inc."
EOF
 
echo "-- Cloning repository"
 
cd $CHEF_DIR
git clone $CHEFREPO .

echo "-- Setting up chef config"
 
cat <<EOF > $CHEF_DIR/config/solo.rb
log_level                :debug
data_bag_path "$CHEF_DIR/data_bags"
file_cache_path "$CHEF_DIR"
cookbook_path "$CHEF_DIR/cookbooks"
role_path "$CHEF_DIR/roles"
json_attribs "$CHEF_DIR/config/default.json"
EOF
 
cat <<EOF > $CHEF_DIR/config/default.json
{ "chef_environment":"$CHEF_ENV","mysql": { "server_root_password": "admin", "server_repl_password": "admin", "server_debian_password": "admin" }, "run_list": $RUNLIST }
EOF
 
sudo groupadd jenkins || true

printf "
=== Run the following ===
sudo chef-solo -c $CHEF_DIR/config/solo.rb
"