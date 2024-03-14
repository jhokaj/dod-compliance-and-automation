control 'CFDM-4X-000010' do
  title 'The SDDC Manager Domain Manager service directory tree must have permissions in an "out of the box" state.'
  desc  'As a rule, accounts on a web server are to be kept to a minimum. Only administrators, web managers, developers, auditors, and web authors require accounts on the machine hosting the web server. The resources to which these accounts have access must also be closely monitored and controlled. The application files must be adequately protected with correct permissions as applied "out of the box".'
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # find /opt/vmware/vcf/domainmanager -xdev -type f -a '(' -perm -o+w -o -not -user vcf_domainmanager -o -not -group vcf ')' -exec ls -ld {} \\;

    If the command produces any output, this is a finding.
  "
  desc 'fix', "
    At the command prompt, run the following command(s):

    # chmod o-w <file>
    # chmod vcf-domainmanager:vcf <file>

    Repeat the command for each file that was returned.
  "
  impact 0.7
  tag severity: 'high'
  tag gtitle: 'SRG-APP-000211-WSR-000030'
  tag satisfies: ['SRG-APP-000380-WSR-000072']
  tag gid: nil
  tag rid: nil
  tag stig_id: 'CFDM-4X-000010'
  tag cci: ['CCI-001082', 'CCI-001813']
  tag nist: ['SC-2', 'CM-5 (1)']

  describe command('find /opt/vmware/vcf/domainmanager -xdev -type f -a \'(\' -perm -o+w -o -not -user vcf_domainmanager -o -not -group vcf \')\' -exec ls -ld {} \\;') do
    its('stdout.strip') { should eq '' }
  end
end
