require 'spec_helper_acceptance'
require 'specinfra'

describe 'postfix class' do
  let(:title) { 'postfix' }

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'postfix': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('postfix') do
      it { is_expected.to be_installed }
    end

    describe service('postfix') do
      it { is_expected.to be_enabled }
    end

    describe process('master') do
      it { is_expected.to be_running }
    end
  end

  describe 'service_ensure => stopped' do
    it 'stops the service' do
      apply_manifest("class { '::postfix': service_ensure => stopped, }", :catch_failures => true)
      output = shell('service postfix status', :acceptable_exit_codes => [0,3])
      expect(output.stdout).to match(/^.+not running$/)
    end
  end

  describe "relayhost => 'relay.localdomain'" do
    it 'sets the relayhost' do
      apply_manifest("class { '::postfix': relayhost => 'relay.localdomain', }", :catch_failures => true)
      output = shell("egrep '^\s*relayhost\s*=\s*relay.localdomain$' /etc/postfix/main.cf")
    end
  end

end
