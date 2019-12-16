resource_name :remediate
provides :remediate

action :os10 do
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
end
