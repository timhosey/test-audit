resource_name :remediate
provides :remediate

action :ubuntu_os10 do
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
    execute "grep -qxF '#{entry}' /etc/modprobe.d/dev-sec.conf || echo '#{entry}' >> /etc/modprobe.d/dev-sec.conf"
  end
end
