control 'PHTN-30-000112' do
  title 'The Photon operating system must protect sshd configuration from unauthorized access.'
  desc  'The "sshd_config" file contains all the configuration items for sshd. Incorrect or malicious configuration of sshd can allow unauthorized access to the system, insecure communication, limited forensic trail, etc.'
  desc  'rationale', ''
  desc  'check', "
    At the command line, run the following command:

    # stat -c \"%n permissions are %a and owned by %U:%G\" /etc/ssh/sshd_config

    Expected result:

    /etc/ssh/sshd_config permissions are 600 and owned by root:root

    If the output does not match the expected result, this is a finding.
  "
  desc 'fix', "
    At the command line, run the following commands:

    # chmod 600 /etc/ssh/sshd_config_effective
    # chown root:root /etc/ssh/sshd_config_effective
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-OS-000480-GPOS-00227'
  tag gid: 'V-PHTN-30-000112'
  tag rid: 'SV-PHTN-30-000112'
  tag stig_id: 'PHTN-30-000112'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  describe file('/etc/ssh/sshd_config_effective') do
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    its('mode') { should cmp '0600' }
  end
end
