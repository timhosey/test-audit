# os-05 remediation for login.defs file and os-05b RedHat-specific remediations for login.defs
login_defs_file = if platform?('ubuntu')
                    'ubuntu-login.defs'
                  else
                    'rhel-login.defs'
                  end

cookbook_file '/etc/login.defs' do
  source login_defs_file
  mode '0444'
  owner 'root'
  group 'root'
end

# os-06 clearing /usr/libexec/openssh/ssh-keysign
file '/usr/libexec/openssh/ssh-keysign' do
  action :delete
end

# Add lines to /etc/modprobe.d/dev-sec.conf if they don't exist (os-10)
entries = [
    'install cramfs /bin/true',
    'install freevxfs /bin/true',
    'install jffs2 /bin/true',
    'install hfs /bin/true',
    'install hfsplus /bin/true',
    'install squashfs /bin/true',
    'install udf /bin/true',
    'install vfat /bin/true',
  ]
entries.each do |entry|
  append_if_no_line entry do
    path '/etc/modprobe.d/dev-sec.conf'
    line entry
  end
end

# Install auditd to remediate package-08
package 'auditd' do
  only_if { platform?('ubuntu') }
end

# Update max_log_file_action
replace_or_add 'Audit max_log_file_action' do
  path '/etc/audit/auditd.conf'
  pattern 'max_log_file_action*'
  line 'max_log_file_action = keep_logs'
end

replace_or_add 'Audit log_format' do
  path '/etc/audit/auditd.conf'
  pattern 'log_format*'
  line 'log_format = raw'
end

# Install havaged package to increase entropy (os-08)
package 'haveged' do
  notifies :run, 'execute[update-rc.d haveged defaults]', :immediately
  only_if { platform?('ubuntu') }
end

execute 'update-rc.d haveged defaults' do
  action :nothing
end

# Apply changes to various kernel parameters - see sysctl-02, 05-10, 13-18,
# 20-28, 30, 31b

# sysctl-05-10
sysctl 'net.ipv4.icmp_ratelimit' do
  value 100
end

sysctl 'net.ipv4.icmp_ratemask' do
  value 88089
end

sysctl 'net.ipv4.conf.all.arp_announce' do
  value 2
end

# sysctl31b
sysctl 'kernel.core_pattern' do
  value '/^\\/.*/'
end

# sysctl-02, sysctl-13 to 18, sysctl-20 to 28, # sysctl-30
# Sets all these values to 0
zero_set = [
  'net.ipv4.tcp_timestamps',
  'net.ipv4.conf.default.accept_source_route',
  'net.ipv4.conf.default.accept_redirects',
  'net.ipv4.conf.all.accept_redirects',
  'net.ipv4.conf.all.secure_redirects',
  'net.ipv4.conf.default.secure_redirects',
  'net.ipv4.conf.default.send_redirects',
  'net.ipv4.conf.all.send_redirects',
  'net.ipv6.conf.default.accept_redirects',
  'net.ipv6.conf.all.accept_redirects',
  'net.ipv6.conf.default.router_solicitations',
  'net.ipv6.conf.default.accept_ra_rtr_pref',
  'net.ipv6.conf.default.accept_ra_pinfo',
  'net.ipv6.conf.default.accept_ra_defrtr',
  'net.ipv6.conf.all.accept_ra',
  'net.ipv6.conf.default.accept_ra',
  'net.ipv6.conf.default.autoconf',
  'net.ipv6.conf.default.dad_transmits',
  'kernel.sysrq',
]

zero_set.each do |this_set|
  sysctl this_set do
    value 0
  end
end

# Sets all these values to 1

one_set = [
  'net.ipv4.conf.default.rp_filter',
  'net.ipv4.conf.all.arp_ignore',
  'net.ipv4.tcp_rfc1337',
  'net.ipv4.conf.all.log_martians',
  'net.ipv4.conf.default.log_martians',
  'net.ipv6.conf.all.disable_ipv6',
  'net.ipv6.conf.default.max_addresses',
]

one_set.each do |this_set|
  sysctl this_set do
    value 1
  end
end
