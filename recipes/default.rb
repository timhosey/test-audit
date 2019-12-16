#
# Cookbook:: test-audit
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

case node['platform']
when 'ubuntu'
  include_recipe 'test-audit::ubuntu'
  include_recipe 'chef-client::cron'
when 'redhat'
  # TODO: Add remediation recipe
  include_recipe 'chef-client::cron'
when 'windows'
  include_recipe 'test-audit::windows'
  include_recipe 'chef-client::task'
end

include_recipe 'audit::default'
