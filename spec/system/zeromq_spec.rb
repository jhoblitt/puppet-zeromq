require 'spec_helper_system'

describe 'zeromq class' do
  case node.facts['osfamily']
  when 'RedHat'
    package_name = ['zeromq3', 'zeromq3-devel']
    pp = <<-EOS
      Class['epel'] -> Class['zeromq']
      include epel
      include zeromq
    EOS
  when 'Debian'
    package_name = ['libzmq3', 'libzmq3-dev']
    pp = <<-EOS
      include zeromq
    EOS
  when 'Gentoo'
    package_name = 'net-libs/zeromq'
    pp = <<-EOS
      include zeromq
    EOS
  end

  describe 'running puppet code' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do

      # Run it twice and test for idempotency
      puppet_apply(pp) do |r|
        r.exit_code.should_not == 1
        r.refresh
        r.exit_code.should be_zero
      end
    end
  end

  package_name.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
