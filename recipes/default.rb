#
# Cookbook:: test-audit
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

case node['platform']
when 'windows'
  include_recipe 'test-audit::windows'
  include_recipe 'chef-client::task'
else
  include_recipe 'test-audit::linux'
  include_recipe 'chef-client::cron'
end

include_recipe 'audit::default'
