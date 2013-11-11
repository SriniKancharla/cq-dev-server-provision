# Oracle JDK Related Config Attributes
node.default['java']['install_flavor'] = "oracle"
node.default['java']['jdk_version'] = '7'
node.default['java']['oracle']['accept_oracle_download_terms'] = true

# Open LDAP Related Config attributes
node.default['domain'] = "example.com"
node.default['openldap']['rootpw'] = nil