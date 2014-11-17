require 'spec_helper'

describe 'postfix' do
  [ 'Debian', 'RedHat'].each do |osfamily|
    let(:facts) {{ :osfamily => osfamily }}

    context 'with defaults' do
      describe "postfix class without any parameters on #{osfamily}" do
        let(:params) {{ }}

        it { should compile.with_all_deps }

        it { should contain_class('postfix::params') }
        it { should contain_class('postfix::install').that_comes_before('postfix::config') }
        it { should contain_class('postfix::config') }
        it { should contain_class('postfix::service').that_subscribes_to('postfix::config') }

        it { should contain_service('master').with_ensure('running') }
        it { should contain_package('postfix').with_ensure('installed') }
      end
    end

    context 'with provided params' do

      describe 'set relayhost' do
        let (:params) {{ 'relayhost' => 'smtprelay.localdomain' }}
        it { should contain_ini_setting('Postfix relayhost setting').with(
            'ensure' => 'present',
            'setting' => 'relayhost',
            'value' => 'smtprelay.localdomain'
          )
        }
      end

      describe 'set package name' do
        let (:params) {{ 'package_name' => 'somepackagename' }}
        it { should contain_package('somepackagename') }
      end

      describe 'set package ensure' do
        let (:params) {{ 'package_name' => 'somepackagename', 'package_ensure' => 'someensure' }}
        it { should contain_package('somepackagename').with_ensure('someensure') }
      end
 
      describe 'set service name' do
        let (:params) {{ 'service_name' => 'someservicename', 'service_ensure' => 'someensure' }}
        it { should contain_service('someservicename').with_ensure('someensure') }
      end

      describe 'set service ensure' do
        let (:params) {{ 'service_name' => 'someservicename', 'service_enable' => false }}
        it { should contain_service('someservicename').with_enable('false') }
      end

      describe 'set service enable' do
      end
      
    end
end

  context 'unsupported operating system' do
    describe 'postfix class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('postfix') }.to raise_error(Puppet::Error, /not supported/) }
    end
  end
end
