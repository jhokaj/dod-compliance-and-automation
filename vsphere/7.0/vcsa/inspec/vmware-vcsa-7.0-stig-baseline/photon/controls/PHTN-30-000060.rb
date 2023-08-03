control 'PHTN-30-000060' do
  title 'The Photon operating system RPM package management tool must cryptographically verify the authenticity of all software packages during installation.'
  desc 'Installation of any nontrusted software, patches, service packs, device drivers, or operating system components can significantly affect the overall security of the operating system. Cryptographically verifying the authenticity of all software packages during installation ensures the software has not been tampered with and has been provided by a trusted vendor.'
  desc 'check', 'At the command line, run the following command:

# grep "^gpgcheck" /etc/tdnf/tdnf.conf

If "gpgcheck" is not set to "1", this is a finding.'
  desc 'fix', 'Navigate to and open:

/etc/tdnf/tdnf.conf

Remove any existing "gpgcheck" setting and add the following line:

gpgcheck=1'
  impact 0.5
  tag check_id: 'C-60206r887265_chk'
  tag severity: 'medium'
  tag gid: 'V-256531'
  tag rid: 'SV-256531r887267_rule'
  tag stig_id: 'PHTN-30-000060'
  tag gtitle: 'SRG-OS-000366-GPOS-00153'
  tag fix_id: 'F-60149r887266_fix'
  tag cci: ['CCI-001749']
  tag nist: ['CM-5 (3)']

  describe command('grep "^gpgcheck" /etc/tdnf/tdnf.conf') do
    its('stdout.strip') { should cmp 'gpgcheck=1' }
  end
end
