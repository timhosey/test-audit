# InSpec test for recipe test-audit::default, test-audit::ubuntu and test-audit::windows.

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

# Windows tests
if os.windows?
  describe directory('C:\\Tools') do
    it { should exist }
  end

  describe file('C:\\Tools\\UserRights.psm1') do
    it { should exist }
  end
end

# Ubuntu tests
if os.debian?
  describe package('haveged') do
    it { should be_installed }
  end

  describe package('auditd') do
    it { should be_installed }
  end
end
