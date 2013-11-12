# Oracle JDK Related Config Attributes
node.default['java']['install_flavor'] = "oracle"
node.default['java']['jdk_version'] = '7'
node.default['java']['oracle']['accept_oracle_download_terms'] = true

# Open LDAP Related Config attributes
node.default['openldap-server'][:domain] = "example.com"
node.default['openldap-server'][:rootpw] = "password"
node.default['openldap-server'][:root_user_attr] = "cn=admin"
#node.default['domain'] = "example.com"
#node.default['openldap']['rootpw'] = 'password'
#node.default['openldap']['basedn'] = 'example.com'
#node.default['openldap']['server'] = "ldap.example.com"