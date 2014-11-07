require 'spec_helper'

describe 'postfix' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "postfix class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('postfix::params') }
        it { should contain_class('postfix::install').that_comes_before('postfix::config') }
        it { should contain_class('postfix::config') }
        it { should contain_class('postfix::service').that_subscribes_to('postfix::config') }

        it { should contain_service('master') }
        it { should contain_package('postfix').with_ensure('installed') }
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
