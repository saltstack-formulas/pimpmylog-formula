control 'config' do
  impact 1.0
  title 'PimpMyLog configuration should be created'
  desc 'verifies that the configuration file is created and has the right content'

  target = '/var/www/pimpmylog/config.user.json'

  describe file(target) do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0644'}
    its('owner') { should eq 'root' }
    its('group') { should eq 'root'}
  end

  describe json(target) do
    its(['badges','http', '1']) { should eq 'info' }
    its(['badges','http', '2']) { should eq 'success' }
    its(['badges','http', '3']) { should eq 'default' }
    its(['badges','http', '4']) { should eq 'warning' }
    its(['badges','http', '5']) { should eq 'danger' }

    its(['badges','severity', 'alert']) { should eq 'danger' }
    its(['badges','severity', 'crit']) { should eq 'danger' }
    its(['badges','severity', 'debug']) { should eq 'success' }
    its(['badges','severity', 'fatal error']) { should eq 'danger' }

    its(['globals', 'AUTH_LOG_FILE_COUNT']) { should eq 100 }
    its(['globals', 'AUTO_UPGRADE']) { should eq false }
    its(['globals', 'GEOIP_URL']) { should eq 'http://www.geoiptool.com/en/?IP=%p' }
    its(['globals', 'LOCALE']) { should eq 'gb_GB' }
    its(['globals', 'LOGS_MAX']) { should eq 50 }
  end
end
