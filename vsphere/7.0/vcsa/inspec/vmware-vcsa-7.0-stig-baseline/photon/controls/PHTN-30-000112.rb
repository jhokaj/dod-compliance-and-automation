control 'PHTN-30-000112' do
  title 'The Photon operating system must protect sshd configuration from unauthorized access.'
  desc 'The "sshd_config" file contains all the configuration items for sshd. Incorrect or malicious configuration of sshd can allow unauthorized access to the system, insecure communication, limited forensic trail, etc.'
  desc 'check', 'At the command line, run the following command:

# stat -c "%n permissions are %a and owned by %U:%G" /etc/ssh/sshd_config

Expected result:

/etc/ssh/sshd_config permissions are 600 and owned by root:root

If the output does not match the expected result, this is a finding.'
  desc 'fix', 'At the command line, run the following commands:

# chmod 600 /etc/ssh/sshd_config
# chown root:root /etc/ssh/sshd_config'
  impact 0.5
  tag check_id: 'C-60256r887415_chk'
  tag severity: 'medium'
  tag gid: 'V-256581'
  tag rid: 'SV-256581r887417_rule'
  tag stig_id: 'PHTN-30-000112'
  tag gtitle: 'SRG-OS-000480-GPOS-00227'
  tag fix_id: 'F-60199r887416_fix'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  describe file('/etc/ssh/sshd_config') do
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    its('mode') { should cmp '0600' }
  end
end
