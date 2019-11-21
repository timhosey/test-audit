resource_name :windows_userright
provides :windows_userright

property :right, String, name_property: true
property :user, String

action :set do
  powershell_script "Set #{new_resource.right}" do
    code <<-EOH
    Import-Module C:\\Tools\\UserRights.psm1
    Get-AccountsWithUserRight -Right #{new_resource.right} | Revoke-UserRight -Right #{new_resource.right}
    Grant-UserRight -Account "#{new_resource.user}" -Right #{new_resource.right}
    EOH
  end
end

# The prep action sets everything up if it needs it.
action :prep do
  # Make a tools directory on C:\
  directory 'c:\\Tools' do
    action :create
    not_if { ::Dir.exist?('c:\\Tools') }
  end

  # Copy UserRights.psm1 into the Tools folder
  cookbook_file 'c:\\Tools\\UserRights.psm1' do
    source 'UserRights.psm1'
    action :create
  end
end
