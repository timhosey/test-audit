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
  } ]
when 'ubuntu', 'redhat'
  default['audit']['profiles'] = [ {
    'compliance': 'admin/linux-baseline',
    'version': '2.2.2',
  } ]
end
