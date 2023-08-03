control 'PHTN-30-000113' do
  title 'The Photon operating system must protect all "sysctl" configuration files from unauthorized access.'
  desc 'The "sysctl" configuration file specifies values for kernel parameters to be set on boot. Incorrect or malicious configuration of these parameters can have a negative effect on system security.'
  desc 'check', "At the command line, run the following command:

# find /etc/sysctl.conf /etc/sysctl.d/* -xdev -type f -a '(' -perm -002 -o -not -user root -o -not -group root ')' -exec ls -ld {} \\;

If any files are returned, this is a finding."
  desc 'fix', 'At the command line, run the following commands for each returned file:

# chmod 600 <file>
# chown root:root <file>'
  impact 0.5
  tag check_id: 'C-60257r887418_chk'
  tag severity: 'medium'
  tag gid: 'V-256582'
  tag rid: 'SV-256582r887420_rule'
  tag stig_id: 'PHTN-30-000113'
  tag gtitle: 'SRG-OS-000480-GPOS-00227'
  tag fix_id: 'F-60200r887419_fix'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  describe command("find /etc/sysctl.conf /etc/sysctl.d/* -xdev -type f -a '(' -perm -002 -o -not -user root -o -not -group root ')' -exec ls -ld {} \\;") do
    its('stdout') { should eq '' }
  end
end
