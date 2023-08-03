control 'PHTN-30-000064' do
  title 'The Photon operating system must configure sshd to use FIPS 140-2 ciphers.'
  desc 'Privileged access contains control and configuration information and is particularly sensitive, so additional protections are necessary. This is maintained by using cryptographic mechanisms such as encryption to protect confidentiality.

Nonlocal maintenance and diagnostic activities are conducted by individuals communicating through an external network (e.g., the internet) or internal network. Local maintenance and diagnostic activities are carried out by individuals physically present at the information system or information system component and not communicating across a network connection.

This requirement applies to hardware/software diagnostic test equipment or tools. It does not cover hardware/software components that may support information system maintenance, yet are a part of the system (e.g., the software implementing "ping," "ls," "ipconfig," or the hardware and software implementing the monitoring port of an Ethernet switch).

The operating system can meet this requirement by leveraging a cryptographic module.

'
  desc 'check', 'At the command line, run the following command:

# sshd -T|&grep -i Ciphers

Expected result:

ciphers aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr

If the output matches the ciphers in the expected result or a subset thereof, this is not a finding.

If the ciphers in the output contain any ciphers not listed in the expected result, this is a finding.'
  desc 'fix', 'Navigate to and open:

/etc/ssh/sshd_config

Ensure the "Ciphers" line is uncommented and set to the following:

Ciphers aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr

At the command line, run the following command:

# systemctl restart sshd.service'
  impact 0.3
  tag check_id: 'C-60209r887274_chk'
  tag severity: 'low'
  tag gid: 'V-256534'
  tag rid: 'SV-256534r887276_rule'
  tag stig_id: 'PHTN-30-000064'
  tag gtitle: 'SRG-OS-000394-GPOS-00174'
  tag fix_id: 'F-60152r887275_fix'
  tag satisfies: ['SRG-OS-000394-GPOS-00174', 'SRG-OS-000424-GPOS-00188']
  tag cci: ['CCI-002421', 'CCI-003123']
  tag nist: ['SC-8 (1)', 'MA-4 (6)']

  sshdcommand = input('sshdcommand')
  describe.one do
    describe command("#{sshdcommand}|&grep -i Ciphers") do
      its('stdout.strip') { should cmp 'ciphers aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr' }
      # ^ciphers\s(?=.*\baes256-gcm@openssh\.com\b)(?=.*\baes128-gcm@openssh\.com\b)(?=.*\baes256-ctr\b)(?=.*\baes192-ctr\b)(?=.*\baes128-ctr\b)$
    end
    describe command("#{sshdcommand}|&grep -i Ciphers") do
      its('stdout.strip') { should cmp 'ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com' }
    end
  end
end
