# Oracle JDK Related Config Attributes
node.default['java']['install_flavor'] = "oracle"
node.default['java']['jdk_version'] = '7'
node.default['java']['oracle']['accept_oracle_download_terms'] = true

# Open LDAP Related Config attributes
node.default['domain'] = "example.com"
node.default['openldap']['rootpw'] = 'password'
node.default['openldap']['basedn'] = 'example.com'
#node.default['openldap']['server'] = "ldap.example.com"

# Jenkins attributes
node.default['jenkins']['server']['install_method'] = 'war'
node.default['jenkins']['server']['home'] = '/var/lib/jenkins'
node.default['jenkins']['server']['user'] = 'jenkins_user'
node.default['jenkins']['server']['group'] = 'jenkins'
node.default['jenkins']['server']['port'] = 8081
node.default['jenkins']['server']['url'] = 'http://192.168.42.80:8081'
node.default['jenkins']['server']['plugins'] = ['pmd', 'email-ext', 'm2release']