## Remediations for Windows

#########################################################################################################
# User rights management
# Note: Might be easier/idempotent to use windows cookbook and windows_user_privilege resource
windows_userright 'User rights setup' do
  action :prep
end

# Set Access Credential Manager as a trusted caller to No One -- cis-access-cred-manager-2.2.1
windows_userright 'SeTrustedCredManAccessPrivilege' do
  user 'S-1-0-0'
end

# Set Act as part of the operating system to No One -- cis-act-as-os-2.2.3
windows_userright 'SeTcbPrivilege' do
  user 'S-1-0-0'
end

# Set Add workstations to domain to Administrators -- cis-add-workstations-2.2.4
windows_userright 'SeMachineAccountPrivilege' do
  user 'S-1-5-32-544'
end

# Set Access this computer from the network -- cis-network-access-2.2.2
# Commented out as it was making it so I couldn't remote or WinRM in
# windows_userright 'SeNetworkLogonRight' do
#   user 'S-1-0-0'
# end

# Windows Remote Desktop Configured to Only Allow System Administrators Access -- windows-account-100
windows_userright 'SeRemoteInteractiveLogonRight' do
  user 'S-1-5-32-544'
end
#########################################################################################################

#########################################################################################################
# Set user password/auth policies
# These are not idempotent, which I don't like; but I couldn't find a better way to do this.
# Set LockoutDuration to 30 minutes -- cis-account-lockout-duration-1.2.1
batch 'Set LockoutDuration' do
  code 'net accounts /lockoutduration:30'
end

# Set LockoutThreshold to 10 -- cis-account-lockout-threshold-1.2.2
batch 'Set LockoutThreshold' do
  code 'net accounts /lockoutthreshold:10'
end

# Set PasswordHistorySize to 24 -- cis-enforce-password-history-1.1.1
batch 'Set PasswordHistorySize' do
  code 'net accounts /uniquepw:24'
end

# Set MinimumPasswordAge to 1 -- cis-minimum-password-age-1.1.3
batch 'Set MinimumPasswordAge' do
  code 'net accounts /minpwage:24'
end

# Set MinimumPasswordLength to 14 -- cis-minimum-password-length-1.1.4
batch 'Set MinimumPasswordLength' do
  code 'net accounts /minpwlen:14'
end

# Set MinimumPasswordLength to 14 -- cis-minimum-password-length-1.1.4
batch 'Set MinimumPasswordLength' do
  code 'net accounts /minpwlen:14'
end
#########################################################################################################

#########################################################################################################
# Set registry keys
# Disable indexing of encrypted files -- disable-index-encrypted-files
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search' do
  values [{
    name: 'AllowIndexingEncryptedStoresOrItems',
    type: :dword,
    data: 0,
  }]
  recursive true
  action :create
end

# Disable Windows Store -- disable-windows-store
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore' do
  values [
    { name: 'AllowIndexingEncryptedStoresOrItems', type: :dword, data: 0 },
    { name: 'AutoDownload', type: :dword, data: 4 },
    { name: 'DisableOSUpgrade', type: :dword, data: 1 },
  ]
  recursive true
  action :create
end

# Disabling Microsoft account logon sign-in option -- microsoft-online-accounts
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Settings\AllowYourAccount' do
  values [
    { name: 'value', type: :dword, data: 0 },
  ]
  recursive true
  action :create
end

# Disable PowerShell Script Block Logging -- powershell-script-blocklogging
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging' do
  values [
    { name: 'EnableScriptBlockLogging', type: :dword, data: 0 },
  ]
  recursive true
  action :create
end

# Disable PowerShell Transcription -- powershell-transcription
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription' do
  values [
    { name: 'EnableTranscripting', type: :dword, data: 0 },
  ]
  recursive true
  action :create
end

# Configure System Event Log (Application) -- windows-audit-100
registry_key 'HKLM\Software\Policies\Microsoft\Windows\EventLog\Application' do
  values [
    { name: 'MaxSize', type: :dword, data: 500 },
  ]
  recursive true
  action :create
end

# All Shares are Configured to Prevent Anonymous Access -- windows-base-103
registry_key 'HKLM\System\CurrentControlSet\Services\LanManServer\Parameters' do
  values [
    { name: 'NullSessionShares', type: :multi_string, data: [''] },
  ]
  recursive true
  action :create
end

# Strong Windows NTLMv2 Authentication Enabled; Weak LM Disabled -- windows-base-201
registry_key 'HKLM\System\CurrentControlSet\Control\Lsa' do
  values [
    { name: 'LmCompatibilityLevel', type: :dword, data: 4 },
  ]
  recursive true
  action :create
end

# Enable Strong Encryption for Windows Network Sessions on Clients and Servers -- windows-base-202 and windows-base-203
registry_key 'HKLM\System\CurrentControlSet\Control\Lsa\MSV1_0' do
  values [
    { name: 'NtlmMinClientSec', type: :dword, data: 537395200 },
    { name: 'NtlmMinServerSec', type: :dword, data: 537395200 },
  ]
  recursive true
  action :create
end

# IE 64-bit tab -- windows-ie-101
registry_key 'HKLM\Software\Policies\Microsoft\Internet Explorer\Main' do
  values [
    { name: 'Isolation64Bit', type: :dword, data: 1 },
  ]
  recursive true
  action :create
end

# Run antimalware programs against ActiveX controls -- windows-ie-102
registry_key 'HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' do
  values [
    { name: '270C', type: :dword, data: 0 },
  ]
  recursive true
  action :create
end

# Windows Remote Desktop Configured to Always Prompt for Password -- windows-rdp-100
# Strong Encryption for Windows Remote Desktop Required -- windows-rdp-101
registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' do
  values [
    { name: 'fPromptForPassword', type: :dword, data: 1 },
    { name: 'MinEncryptionLevel', type: :dword, data: 3 },
  ]
  recursive true
  action :create
end

# Configure System Event Log (Security) -- windows-audit-101
registry_key 'HKLM\Software\Policies\Microsoft\Windows\EventLog\Security' do
  values [
    { name: 'MaxSize', type: :dword, data: 196608 },
  ]
  recursive true
  action :create
end

# Configure System Event Log (Setup) -- windows-audit-102
registry_key 'HKLM\Software\Policies\Microsoft\Windows\EventLog\Setup' do
  values [
    { name: 'MaxSize', type: :dword, data: 32768 },
  ]
  recursive true
  action :create
end

# Configure System Event Log (System) -- windows-audit-103
registry_key 'HKLM\Software\Policies\Microsoft\Windows\EventLog\System' do
  values [
    { name: 'MaxSize', type: :dword, data: 32768 },
  ]
  recursive true
  action :create
end
#########################################################################################################
