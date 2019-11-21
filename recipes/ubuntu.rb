## Remediations for Ubuntu

# os-05 remediation for login.defs file
execute 'sed -i \'/^PASS_MAX_DAYS/ c\\PASS_MAX_DAYS\\t60\' /etc/login.defs'
execute 'sed -i \'/^PASS_MIN_DAYS/ c\\PASS_MIN_DAYS\\t7\' /etc/login.defs'
execute 'sed -i \'/^UMASK/ c\\UMASK\\t027\' /etc/login.defs'

# Install havaged package to increase entropy (os-08)
package 'haveged'
execute 'update-rc.d haveged defaults'

# Add lines to /etc/modprobe.d/dev-sec.conf if they don't exist (os-10)
remediate 'Remediating os-10' do
  action :ubuntu_os10
end

# Install auditd to remediate package-08
package 'auditd'

# Update max_log_file_action
execute 'sed -i \'/^max_log_file_action/ c\\max_log_file_action = keep_logs\' /etc/audit/auditd.conf'

# Apply changes to various kernel parameters - see sysctl-05 to 10, 13-18,
# 20-28, 30, 31b

# sysctl05-10
sysctl 'net.ipv4.icmp_ratelimit' do
  value 100
end

sysctl 'net.ipv4.icmp_ratemask' do
  value 88089
end

sysctl 'net.ipv4.tcp_timestamps' do
  value 0
end

sysctl 'net.ipv4.conf.all.arp_ignore' do
  value 1
end

sysctl 'net.ipv4.conf.all.arp_announce' do
  value 2
end

sysctl 'net.ipv4.tcp_rfc1337' do
  value 1
end

# sysctl-13-18
sysctl 'net.ipv4.conf.default.accept_source_route' do
  value 0
end

sysctl 'net.ipv4.conf.default.accept_redirects' do
  value 0
end

sysctl 'net.ipv4.conf.all.accept_redirects' do
  value 0
end

sysctl 'net.ipv4.conf.all.secure_redirects' do
  value 0
end

sysctl 'net.ipv4.conf.default.secure_redirects' do
  value 0
end

sysctl 'net.ipv4.conf.default.send_redirects' do
  value 0
end

sysctl 'net.ipv4.conf.all.send_redirects' do
  value 0
end

sysctl 'net.ipv4.conf.all.log_martians' do
  value 1
end

sysctl 'net.ipv4.conf.default.log_martians' do
  value 1
end

sysctl 'net.ipv6.conf.all.disable_ipv6' do
  value 1
end

# sysctl20-28
sysctl 'net.ipv6.conf.default.accept_redirects' do
  value 0
end

sysctl 'net.ipv6.conf.all.accept_redirects' do
  value 0
end

sysctl 'net.ipv6.conf.default.router_solicitations' do
  value 0
end

sysctl 'net.ipv6.conf.default.accept_ra_rtr_pref' do
  value 0
end

sysctl 'net.ipv6.conf.default.accept_ra_pinfo' do
  value 0
end

sysctl 'net.ipv6.conf.default.accept_ra_defrtr' do
  value 0
end

sysctl 'net.ipv6.conf.all.accept_ra' do
  value 0
end

sysctl 'net.ipv6.conf.default.accept_ra' do
  value 0
end

sysctl 'net.ipv6.conf.default.autoconf' do
  value 0
end

sysctl 'net.ipv6.conf.default.dad_transmits' do
  value 0
end

sysctl 'net.ipv6.conf.default.max_addresses' do
  value 1
end

# sysctl30
sysctl 'kernel.sysrq' do
  value 0
end

# sysctl31b
sysctl 'kernel.core_pattern' do
  value '/^\\/.*/'
end
