require 'spec_helper'

describe 'postfix', :type => 'class' do

  context "on a Debian osfamily" do
    let :facts do
      { :osfamily => 'Debian' }
    end

    it { 
      should contain_package('postfix').with( {'name' => 'postfix' } )
      should contain_service('postfix').with( {'name' => 'postfix' } )
    }
  end

  context "on a RedHat osfamily" do
    let :facts do 
      { :osfamily => 'RedHat' }
    end

    it {
      should contain_package('postfix').with( {'name' => 'postfix' } )
      should contain_service('postfix').with( {'name' => 'postfix' } )
    }
  end
end
