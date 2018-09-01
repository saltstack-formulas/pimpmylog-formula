control 'install' do
  impact 1.0
  title 'PimpMyLog is downloaded and installed'
  desc 'verifies that the git repo is cloned in the desired place'

  target = '/var/www/pimpmylog'

  describe file(target) do
    it { should exist }
    it { should be_directory }
  end

  describe file("#{target}/index.php") do
    it { should exist }
    it { should be_file }
  end
end
