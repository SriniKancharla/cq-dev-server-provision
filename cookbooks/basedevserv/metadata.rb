name             'basedevserv'
maintainer       'Headwire Inc.'
maintainer_email 'sk@headwire.com'
license          'All rights reserved'
description      'Installs/Configures basedevserv'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "java"
depends "tomcat_latest"
depends "subversion"
depends "git"
depends "apache2"

