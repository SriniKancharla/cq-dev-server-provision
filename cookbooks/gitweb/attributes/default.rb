#
# Cookbook Name:: gitweb
# Attributes:: default
#
# Copyright 2012, Steffen Gebert / TYPO3 Association
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

default['gitweb']['hostname'] = node['fqdn']

default['gitweb']['path'] = "/var/cache/git"

# if this is set, an entry in the ssl_certificates data bag matching the given name must exist
# this uses the ssl-certificates cookbook
# http://github.com/binarymarbles/chef-ssl-certificates
default['gitweb']['ssl'] = false
default['gitweb']['ssl_certificate'] = nil

default['gitweb']['export-http'] = true