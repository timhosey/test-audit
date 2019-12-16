# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'test-audit'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'test-audit::default'

# Specify a custom source for a single cookbook:
cookbook 'test-audit', path: '.'

cookbook 'audit', '~> 9.0.1', :supermarket
cookbook 'chef-client', '~> 11.4.0', :supermarket
cookbook 'line', '~> 2.5.0', :supermarket
