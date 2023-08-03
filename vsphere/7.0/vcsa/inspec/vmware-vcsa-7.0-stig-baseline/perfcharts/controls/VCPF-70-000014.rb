control 'VCPF-70-000014' do
  title 'Performance Charts must not have the Web Distributed Authoring (WebDAV) servlet installed.'
  desc 'WebDAV is an extension to the HTTP protocol that, when developed, was meant to allow users to create, change, and move documents on a server, typically a web server or web share. WebDAV is not widely used and has serious security concerns because it may allow clients to modify unauthorized files on the web server and must therefore be disabled.

Tomcat uses the "org.apache.catalina.servlets.WebdavServlet" servlet to provide WebDAV services. Because the WebDAV service has been found to have an excessive number of vulnerabilities, this servlet must not be installed. Performance Charts does not configure WebDAV by default.'
  desc 'check', "At the command prompt, run the following command:

# grep -n 'webdav' /usr/lib/vmware-perfcharts/tc-instance/conf/web.xml

If the command produces any output, this is a finding."
  desc 'fix', 'Navigate to and open:

/usr/lib/vmware-perfcharts/tc-instance/conf/web.xml

Find the <servlet-name>webdav</servlet-name> node and remove the entire parent <servlet> block.

Restart the service with the following command:

# vmon-cli --restart perfcharts'
  impact 0.5
  tag check_id: 'C-60299r888361_chk'
  tag severity: 'medium'
  tag gid: 'V-256624'
  tag rid: 'SV-256624r888363_rule'
  tag stig_id: 'VCPF-70-000014'
  tag gtitle: 'SRG-APP-000141-WSR-000085'
  tag fix_id: 'F-60242r888362_fix'
  tag cci: ['CCI-000381']
  tag nist: ['CM-7 a']

  describe xml("#{input('webXmlPath')}") do
    its('/web-app/servlet-mapping[servlet-name="webdav"]') { should eq [] }
  end
end
