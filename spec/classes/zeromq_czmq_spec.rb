require 'spec_helper'

describe 'zeromq::czmq', :type => :class do

  context 'on osfamily RedHat' do
    context 'el6' do
      let(:facts) {{ :osfamily => 'RedHat', :operatingsystemmajrelease => '6' }}

      context 'no params' do
        it { should include_class('zeromq') }
        it { should contain_package('czmq').with_ensure('present') }
        it { should contain_package('czmq-devel').with_ensure('present') }
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

  context 'on osfamily Gentoo' do
    let(:facts) {{ :osfamily => 'Gentoo' }}

    context 'no params' do
      it { should include_class('zeromq') }
      it { should contain_package('net-libs/czmq').with_ensure('present') }
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