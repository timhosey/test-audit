#
# Cookbook:: test-audit
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

if platform?('windows')
  include_recipe 'test-audit::windows'
else
  include_recipe 'test-audit::linux'
end
