control 'VRLT-8X-000070' do
  title 'The VMware Aria Operations for Logs tc Server must set an inactive timeout for sessions.'
  desc  "
    Leaving sessions open indefinitely is a major security risk. An attacker can easily use an already authenticated session to access the hosted application as the previously authenticated user. By closing sessions after a set period of inactivity, the web server can make certain that those sessions that are not closed through the user logging out of an application are eventually closed.

    tc Server provides a session timeout parameter in the web.xml configuration file.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # xmllint --xpath \"//*[local-name()='session-timeout']/parent::*\" /usr/lib/loginsight/application/3rd_party/apache-tomcat/conf/web.xml

    If the value of <session-timeout> is not \"30\" or less, or is missing, this is a finding.

    EXAMPLE:
    <session-config>
      <session-timeout>15</session-timeout>
      <cookie-config>
        <http-only>true</http-only>
        <secure>true</secure>
      </cookie-config>
    </session-config>
  "
  desc 'fix', "
    Edit the /usr/lib/loginsight/application/3rd_party/apache-tomcat/conf/web.xml file.

    Navigate to the <session-config> node.

    Add or edit the <session-timeout>30</session-timeout> node setting in the <session-config> node.

    EXAMPLE:
    <session-config>
      <session-timeout>15</session-timeout>
      <cookie-config>
        <http-only>true</http-only>
        <secure>true</secure>
      </cookie-config>
    </session-config>

    Restart the service:
    # systemctl restart loginsight.service
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000295-AS-000263'
  tag satisfies: ['SRG-APP-000389-AS-000253']
  tag gid: 'V-VRLT-8X-000070'
  tag rid: 'SV-VRLT-8X-000070'
  tag stig_id: 'VRLT-8X-000070'
  tag cci: ['CCI-002038', 'CCI-002361']
  tag nist: ['AC-12', 'IA-11']

  # Open web.xml
  xmlconf = xml("#{input('catalinaBase')}/conf/web.xml")

  # find the session-timeout value
  describe xmlconf['//session-config/session-timeout'] do
    it { should eq ["#{input('sessionTimeout')}"] }
  end
end
