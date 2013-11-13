# Oracle JDK Related Config Attributes
node.default['java']['install_flavor'] = "oracle"
node.default['java']['jdk_version'] = '7'
node.default['java']['oracle']['accept_oracle_download_terms'] = true

# Open LDAP Related Config attributes
node.default['domain'] = "example.com"
node.default['openldap']['rootpw'] = "password"
node.default['openldap']['basedn'] = "example.com"
#node.default['openldap']['server'] = "ldap.example.com"
node.default[:certs] = [ '/etc/ldap/ssl/ldap.example.com.crt',
                         '/etc/ldap/ssl/ldap.example.com.key',
                         '/etc/ldap/ssl/ldap.example.com.pem' ]

# Jenkins attributes
node.default['jenkins']['server']['install_method'] = 'war'
node.default['jenkins']['server']['home'] = '/var/lib/jenkins'
node.default['jenkins']['server']['user'] = 'jenkins_user'
node.default['jenkins']['server']['group'] = 'jenkins'
node.default['jenkins']['server']['port'] = 8082
node.default['jenkins']['server']['url'] = 'http://localhost:8082'
node.default['jenkins']['server']['plugins'] = ['analysis-core', 'pmd', 'token-macro', 'email-ext', 'm2release']

node.default[:nexus][:port] = '8081'

node.default['apache']['listen_ports'] = %w[81]