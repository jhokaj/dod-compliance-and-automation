control 'VCSA-70-000267' do
  title 'The vCenter Server must disable the distributed virtual switch health check.'
  desc 'Network health check is disabled by default. Once enabled, the health check packets contain information on host#, vds#, and port#, which an attacker would find useful. It is recommended that network health check be used for troubleshooting and turned off when troubleshooting is finished.'
  desc 'check', 'If distributed switches are not used, this is not applicable.

From the vSphere Client, go to "Networking".

Select a distributed switch >> Configure >> Settings >> Health Check.

View the health check pane and verify the "VLAN and MTU" and "Teaming and failover" checks are "Disabled".

or

From a PowerCLI command prompt while connected to the vCenter server, run the following commands:

$vds = Get-VDSwitch
$vds.ExtensionData.Config.HealthCheckConfig

If the health check feature is enabled on distributed switches and is not on temporarily for troubleshooting purposes, this is a finding.'
  desc 'fix', 'From the vSphere Client, go to "Networking".

Select a distributed switch >> Configure >> Settings >> Health Check.

Click "Edit".

Disable the "VLAN and MTU" and "Teaming and failover" checks.

Click "OK".

or

From a PowerCLI command prompt while connected to the vCenter server, run the following command:

Get-View -ViewType DistributedVirtualSwitch | ?{($_.config.HealthCheckConfig | ?{$_.enable -notmatch "False"})}| %{$_.UpdateDVSHealthCheckConfig(@((New-Object Vmware.Vim.VMwareDVSVlanMtuHealthCheckConfig -property @{enable=0}),(New-Object Vmware.Vim.VMwareDVSTeamingHealthCheckConfig -property @{enable=0})))}'
  impact 0.3
  tag check_id: 'C-60022r885650_chk'
  tag severity: 'low'
  tag gid: 'V-256347'
  tag rid: 'SV-256347r885652_rule'
  tag stig_id: 'VCSA-70-000267'
  tag gtitle: 'SRG-APP-000516'
  tag fix_id: 'F-59965r885651_fix'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  command = 'Get-VDSwitch | Select -ExpandProperty Name'
  vdswitches = powercli_command(command).stdout.gsub("\r\n", "\n").split("\n")

  if vdswitches.empty?
    describe '' do
      skip 'No distributed switches found to check.'
    end
  else
    vdswitches.each do |vds|
      command = "(Get-VDSwitch -Name \"#{vds}\").ExtensionData.Config.HealthCheckConfig | Select-Object -ExpandProperty Enable"
      checks = powercli_command(command)
      checks.stdout.split.each do |hc|
        describe "Health check for #{vds}" do
          subject { hc }
          it { should cmp 'false' }
        end
      end
    end
  end
end
