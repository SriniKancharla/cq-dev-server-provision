#!/usr/bin/env bash
# call like this on the target server:
# NODENAME='foo' CHEF_ENV='production' GIT_USER='git_username' GIT_PASSWORD='git_password' bash < bootstrap_chef.sh
# You will need to ensure that the ssh key is already set up on the server.
 
set -e
#export CHEFREPO='srinikancharla@https://github.com/SriniKancharla:cq-dev-server-provision.git' 
export CHEF_DIR="${HOME}/chef"
#export RUNLIST='["role[foo]","recipe[bar]"]'
export RUNLIST='[ "recipe[apt]", "recipe[basedevserv]" ]'
#export CHEFREPO='git@github.com:SriniKancharla/cq-dev-server-provision'

export CHEFREPO='https://$GIT_USER:$GIT_PASSWORD@github.com/SriniKancharla/cq-dev-server-provision.git'

sudo rm -rf $CHEF_DIR
mkdir -p "$CHEF_DIR"
 
echo "-- Installing Packages"
 
yes | sudo apt-get install ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert git-core
 
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
{ "chef_environment":"$CHEF_ENV","run_list": $RUNLIST }
EOF
 
printf "
=== Run the following ===
sudo chef-solo -c $CHEF_DIR/config/solo.rb
"