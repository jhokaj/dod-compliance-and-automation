control 'VCUI-70-000012' do
  title 'vSphere UI must have Multipurpose Internet Mail Extensions (MIME) that invoke operating system shell programs disabled.'
  desc 'MIME mappings tell the vSphere UI what type of program various file types and extensions are and what external utilities or programs are needed to execute the file type. By ensuring various shell script MIME types are not included in "web.xml", the server is protected against malicious users tricking the server into executing shell command files.'
  desc 'check', "At the command prompt, run the following command:

# grep -En '(x-csh<)|(x-sh<)|(x-shar<)|(x-ksh<)' /usr/lib/vmware-vsphere-ui/server/conf/web.xml

If the command produces any output, this is a finding."
  desc 'fix', 'Navigate to and open:

/usr/lib/vmware-vsphere-ui/server/conf/web.xml

Remove all of the following nodes lines:

<mime-type>application/x-csh</mime-type>
<mime-type>application/x-shar</mime-type>
<mime-type>application/x-sh</mime-type>
<mime-type>application/x-ksh</mime-type>

Restart the service with the following command:

# vmon-cli --restart vsphere-ui

Note: Delete the entire mime-mapping node for the target mime-type.

Example:

<mime-mapping>
    <extension>sh</extension>
    <mime-type>application/x-sh</mime-type>
</mime-mapping>'
  impact 0.5
  tag check_id: 'C-60464r889364_chk'
  tag severity: 'medium'
  tag gid: 'V-256789'
  tag rid: 'SV-256789r889366_rule'
  tag stig_id: 'VCUI-70-000012'
  tag gtitle: 'SRG-APP-000141-WSR-000081'
  tag fix_id: 'F-60407r889365_fix'
  tag cci: ['CCI-000381']
  tag nist: ['CM-7 a']

  describe command("grep -En \'(x-csh<)|(x-sh<)|(x-shar<)|(x-ksh<)\' '#{input('webXmlPath')}'") do
    its('stdout.strip') { should eq '' }
  end
end
