name 'test-audit'
maintainer 'Tim Hosey'
maintainer_email 'thosey@chef.io'
license 'All Rights Reserved'
description 'Audit cookbook for remediation and security'
version '0.3.10'
chef_version '>= 15.0'

# Dependencies
depends 'audit'
depends 'chef-client'
depends 'line'

# Supported OSes
supports 'ubuntu'
supports 'redhat'
supports 'windows'
