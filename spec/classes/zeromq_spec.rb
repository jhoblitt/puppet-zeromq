require 'spec_helper'

describe 'zeromq', :type => :class do

  describe 'for osfamily RedHat' do
    it { should contain_class('zeromq') }
  end

end
