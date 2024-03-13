control 'VCLD-80-000100' do
  title 'The vCenter VAMI service must implement prevent rendering inside a frame or iframe on another site.'
  desc  "
    Clickjacking, also known as a “UI redress attack”, is when an attacker uses multiple transparent or opaque layers to trick a user into clicking on a button or link on another page when they were intending to click on the top level page. Thus, the attacker is “hijacking” clicks meant for their page and routing them to another page, most likely owned by another application, domain, or both.

    Using a similar technique, keystrokes can also be hijacked. With a carefully crafted combination of stylesheets, iframes, and text boxes, a user can be led to believe they are typing in the password to their email or bank account, but are instead typing into an invisible frame controlled by the attacker.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f /opt/vmware/etc/lighttpd/lighttpd.conf 2>/dev/null|awk '/setenv\\.add-response-header/,/\\)/'|sed -e 's/^[ ]*//'|grep \"X-Frame-Options\"

    Expected result:

    \"X-Frame-Options\"           => \"Deny\",

    If the output does not match the expected result, this is a finding.

    Note: The command must be run from a bash shell and not from a shell generated by the \"appliance shell\". Use the \"chsh\" command to change the shell for the account to \"/bin/bash\". Refer to KB Article 2100508 for more details:

    https://kb.vmware.com/s/article/2100508
  "
  desc 'fix', "
    Navigate to and open:

    /etc/applmgmt/appliance/lighttpd.conf

    Locate the \"setenv.add-response-header\" parameter and add or update the following value:

    \"X-Frame-Options\"           => \"Deny\",

    Note: The last line in the parameter does not need a trailing comma.

    Restart the service with the following command:

    # vmon-cli --restart applmgmt
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000516-WSR-000174'
  tag gid: 'V-VCLD-80-000100'
  tag rid: 'SV-VCLD-80-000100'
  tag stig_id: 'VCLD-80-000100'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  describe command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')} 2>/dev/null|awk '/setenv\.add-response-header/,/\)/'|sed -e 's/^[ ]*//'|grep X-Frame-Options") do
    its('stdout.strip') { should cmp '"X-Frame-Options"           => "Deny",' }
  end
end
