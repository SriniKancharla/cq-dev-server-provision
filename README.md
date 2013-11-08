<h3>GOAL</h3>
Provision a cq dev server with the following software pre-installed

  Java OpenJDK <br>
  Tomcat Latest<br>
  Git<br>
  SVN Client<br>
  SVN Server<br>
  OpenLDAP<br>
  Nexus<br>
  and last but not least CQ<br>
  
  This project uses Chef Solo to do the provisioning. Currently onlu Ubuntu 12.04 and CentOS 6 are supported
  which at the time of developemnt are the latest LTS versions of the respective OSs.<br>

The bootstrap script for ubuntu is modified from the following gist:<br>
https://gist.github.com/chrismdp/1026628

For bootstraping CentOS 6, use:


<h3>Prerequisites</h3>
Its assumed that you have access to a barebones server and the server can connect to the internet. <br>
You have a github account.

<h3>Provision</h3>
To provision the barebones server just run the following command. <br>

For Ubuntu:<br>
<code>$GIT_USER='git_username' GIT_PASSWORD='git_password' bash < bootstrap_chef.sh </code> <br>

For CentOS: <br>

<b>Note:</b> You will have to set execute flags on the file. e.g. chmod 755 bootstrap_chef.sh

This would update and install all the nessesary software. The script would need you to confirm adding github.com to known hosts list. After the script is done executing succesfully it will print a chef-solo command to run. Please copy and paste that command in the terminal and run it.

<h5>Tomcat</h5>
You can verify that the tomcat is running by accessing it at http://<code>ip-address</code>:8080/

<h5>Git Server</h5>
Login with your username and password to the server. Git server deamon should already be started when the server starts.

<code>$ cd /srv/git <br>
       $ mkdir repo_name.git <br>
       $ cd repo_name.git <br>
       $ git --bare init <br>
</code>
This creates a new repo on the git server. <br>

In your local dev environment run git clone ssh://username@servername/srv/git/repo_name.git (where repo_name.git is your actual app repo directory) <br>
·         cd into repo_name locally <br>
·         Commit your local code <br>
·         git push origin master <br>

<b>Note:</b> You might need sudo access to run some of these commands.
