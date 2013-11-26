require 'spec_helper'

describe 'zeromq', :type => :class do

  context 'on osfamily RedHat' do
    # epel6 provides 3.2.4
    # epel5 provides 2.1.9

    context 'el6' do
      let(:facts) {{ :osfamily => 'RedHat', :operatingsystemmajrelease => '6' }}

      context 'no params' do
        it { should contain_package('zeromq3').with_ensure('present') }
        it { should contain_package('zeromq3-devel').with_ensure('present') }
      end

      context 'version => 3' do
        let(:params) {{ :version => '3' }}

        it { should contain_package('zeromq3').with_ensure('present') }
        it { should contain_package('zeromq3-devel').with_ensure('present') }
      end

      context 'version => 4' do
        let(:params) {{ :version => '4' }}

        it 'should fail' do
          expect { should }.
            to raise_error(Puppet::Error, /API version 4 is not supported on RedHat 6/)
        end
      end
    end # el6

    context 'el5' do
      let(:facts) {{ :osfamily => 'RedHat', :operatingsystemmajrelease => '5' }}

      it 'should fail' do
        expect { should }.
          to raise_error(Puppet::Error, /not supported on RedHat 5/)
      end
    end # el5
  end # on osfamily RedHat

  context 'on osfamily Debian' do
    # debian sid has 3.x packages (not manually tested)
    #  - http://zeromq.org/distro:debian
    # debian wheezy has 2.2 packages named: libzmq1, libzmq-dev, libzmq-dbg
    # debian squeeze does not include zeromq
    context 'sid' do
      let(:facts) {{ :osfamily => 'Debian', :lsbdistcodename => 'sid' }}

      context 'no params' do
        it { should contain_package('libzmq3').with_ensure('present') }
        it { should contain_package('libzmq3-dev').with_ensure('present') }
      end

      context 'version => 3' do
        let(:params) {{ :version => '3' }}

        it { should contain_package('libzmq3').with_ensure('present') }
        it { should contain_package('libzmq3-dev').with_ensure('present') }
      end

      context 'version => 4' do
        let(:params) {{ :version => '4' }}

        it 'should fail' do
          expect { should }.
            to raise_error(Puppet::Error, /API version 4 is not supported on Debian sid/)
        end
      end
    end # sid

    context 'wheezy' do
      let(:facts) {{ :osfamily => 'Debian', :lsbdistcodename => 'wheezy' }}

      it 'should fail' do
        expect { should }.
          to raise_error(Puppet::Error, /not supported on Debian wheezy/)
      end
    end # wheezy

    context 'squeeze' do
      let(:facts) {{ :osfamily => 'Debian', :lsbdistcodename => 'squeeze' }}

      it 'should fail' do
        expect { should }.
          to raise_error(Puppet::Error, /not supported on Debian squeeze/)
      end
    end # squeeze
  end # on osfamily Debian

  context 'on osfamily Gentoo' do
    let(:facts) {{ :osfamily => 'Gentoo' }}
    # portage on 2013-11-26 has
    # [-P-] [  ] net-libs/zeromq-2.1.11:0
    # [-P-] [  ] net-libs/zeromq-2.2.0:0
    # [-P-] [  ] net-libs/zeromq-3.2.3:0
    # [IP-] [  ] net-libs/zeromq-3.2.4:0
    # [-P-] [  ] net-libs/zeromq-4.0.1:0
    # [-P-] [  ] net-libs/zeromq-4.0.1-r1:0

    context 'no params' do
      it { should contain_package('net-libs/zeromq').with_ensure('3*') }
    end

    context 'version => 3' do
      let(:params) {{ :version => '3' }}

      it { should contain_package('net-libs/zeromq').with_ensure('3*') }
    end

    context 'version => 4' do
      let(:params) {{ :version => '4' }}

      it { should contain_package('net-libs/zeromq').with_ensure('4*') }
    end
  end # on osfamily Gentoo

  context 'on an unsupported osfamily' do
    let(:facts) {{ :osfamily => 'Solaris' }}

    it 'should fail' do
      expect { should }.
        to raise_error(Puppet::Error, /not supported on Solaris/)
    end
  end # on an unsupported osfamily

end
