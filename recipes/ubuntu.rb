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
execute 'sysctl -w net.ipv4.icmp_ratelimit=100'
execute 'sysctl -w net.ipv4.icmp_ratemask=88089'
execute 'sysctl -w net.ipv4.tcp_timestamps=0'
execute 'sysctl -w net.ipv4.conf.all.arp_ignore=1'
execute 'sysctl -w net.ipv4.conf.all.arp_announce=2'
execute 'sysctl -w net.ipv4.tcp_rfc1337=1'
# sysctl-13-18
execute 'sysctl -w net.ipv4.conf.default.accept_source_route=0'
execute 'sysctl -w net.ipv4.conf.default.accept_redirects=0'
execute 'sysctl -w net.ipv4.conf.all.accept_redirects=0'
execute 'sysctl -w net.ipv4.conf.all.secure_redirects=0'
execute 'sysctl -w net.ipv4.conf.default.secure_redirects=0'
execute 'sysctl -w net.ipv4.conf.default.send_redirects=0'
execute 'sysctl -w net.ipv4.conf.all.send_redirects=0'
execute 'sysctl -w net.ipv4.conf.all.log_martians=1'
execute 'sysctl -w net.ipv4.conf.default.log_martians=1'
execute 'sysctl -w net.ipv6.conf.all.disable_ipv6=1'
# sysctl20-28
execute 'sysctl -w net.ipv6.conf.default.accept_redirects=0'
execute 'sysctl -w net.ipv6.conf.all.accept_redirects=0'
execute 'sysctl -w net.ipv6.conf.default.router_solicitations=0'
execute 'sysctl -w net.ipv6.conf.default.accept_ra_rtr_pref=0'
execute 'sysctl -w net.ipv6.conf.default.accept_ra_pinfo=0'
execute 'sysctl -w net.ipv6.conf.default.accept_ra_defrtr=0'
execute 'sysctl -w net.ipv6.conf.all.accept_ra=0'
execute 'sysctl -w net.ipv6.conf.default.accept_ra=0'
execute 'sysctl -w net.ipv6.conf.default.autoconf=0'
execute 'sysctl -w net.ipv6.conf.default.dad_transmits=0'
execute 'sysctl -w net.ipv6.conf.default.max_addresses=1'
# sysctl30
execute 'sysctl -w kernel.sysrq=0'
#sysctl31b
execute 'sysctl -w kernel.core_pattern=/^\\/.*/'
