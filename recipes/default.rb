#
# Cookbook:: test-audit
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

case node['platform']
when 'ubuntu'
  include_recipe 'test-audit::ubuntu'
  # Call the chef-client cookbook
  include_recipe 'chef-client::cron'
when 'windows'
  include_recipe 'test-audit::windows'
  # Call the chef-client cookbook
  include_recipe 'chef-client::task'
end

# Call the audit cookbook to run
include_recipe 'audit::default'
