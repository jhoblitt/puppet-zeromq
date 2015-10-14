require 'spec_helper_acceptance'

describe 'zeromq class' do
  case fact('osfamily')
  when 'RedHat'
    package_name = ['czmq', 'czmq-devel']
    pp = <<-EOS
      Class['epel'] -> Class['zeromq']
      include epel
      include zeromq::czmq
    EOS
  when 'Gentoo'
    package_name = 'net-libs/czmq'
    pp = <<-EOS
      include zeromq::czmq
    EOS
  end

  describe 'running puppet code' do
    it 'should work with no errors' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  package_name.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
