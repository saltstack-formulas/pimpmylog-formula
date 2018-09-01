control 'sites' do
  impact 1.0
  title 'PimpMyLog configuration sites should be created'
  desc 'verifies that the configuration sites files are created and have the right content'

  target_d = '/var/www/pimpmylog/config.user.d'

  describe file(target_d) do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755'}
    its('owner') { should eq 'root' }
    its('group') { should eq 'root'}
  end

  describe file("#{target_d}/apache_access.json") do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0644'}
    its('owner') { should eq 'root' }
    its('group') { should eq 'root'}
  end

  describe json("#{target_d}/apache_access.json") do
    its(['display']) { should eq 'Apache Access' }
    its(['format', 'exclude', 'CMD']) { should eq ['/OPTIONS/'] }
    its(['format', 'exclude', 'URL']) { should eq %w{/favicon.ico/ /\.pml\.php.*$/} }

    its(['format', 'match', 'CMD']) { should eq 7 }
    its(['format', 'match', 'Code']) { should eq 10 }
    its(['format', 'match', 'Date']) { should eq 6 }

    its(['format', 'types', 'Code']) { should eq 'badge:http' }
    its(['format', 'types', 'Size']) { should eq 'numeral:0b' }
  end

  describe json("#{target_d}/apache_error.json") do
    its(['display']) { should eq 'Apache Error' }
    its(['format', 'exclude', 'Log']) { should eq ['/PHP Stack trace:/', '/PHP *[0-9]*\. /'] }

    its(['format', 'match', 'Log']) { should eq 5 }
    its(['format', 'match', 'Date']) { should eq 1 }

    its(['format', 'types', 'Date']) { should eq 'date:H:i:s' }
    its(['path']) { should eq '/var/log/apache2/error.log' }
  end

  describe file("#{target_d}/some_absent_site.json") do
    it { should_not exist }
  end

end
