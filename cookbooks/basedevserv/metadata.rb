name             'basedevserv'
maintainer       'Srini K'
maintainer_email 'sk@gmail.com'
license          'All rights reserved'
description      'Installs/Configures basedevserv'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apache2"
depends "java"
depends "tomcat_latest"
depends "subversion"
depends "mysql"
depends "openldap-server"
depends "git"
depends "gitlab"
depends "jenkins"
depends "nexus"
