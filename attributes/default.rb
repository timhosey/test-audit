## Sets our reporter to chef-server-automate
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['quiet'] = false

## Sets our audit profile based on OS
case node['platform']
when 'windows'
  default['audit']['profiles'] = [ {
    'compliance': 'admin/thosey-windows-baseline',
    'version': '0.1.2',
  },
  {
    'compliance': 'admin/cis-windows2016rtm-release1607-level1-memberserver',
    'version': '1.1.0-9',
  } ]
when 'ubuntu'
  default['audit']['profiles'] = [ {
    'compliance': 'admin/linux-baseline',
    'version': '2.2.2',
  } ]
end

## Sets our attributes for chef-client
default['chef_client']['interval'] = 1800
