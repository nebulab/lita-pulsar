require "spec_helper"

describe Lita::Handlers::Pulsar, lita_handler: true do
  it { is_expected.to route_command('deploy app stage').to(:deploy) }

  it 'sets the conf_repo to nil by default' do
    expect(registry.config.handlers.pulsar.conf_repo).to be_nil
  end

  context 'when :pulsar_conf configuration is specified' do
    before do
      registry.config.handlers.pulsar.conf_repo = 'git://pulsar_conf_repo'

      allow(subject).to receive(:spawn)
    end

    it 'replies properly and calls pulsar' do
      send_command('deploy app stage')

      is_expected.to have_received(:spawn).with('eval `ssh-agent -s` && ssh-add && bundle exec pulsar -c git://pulsar_conf_repo app stage; kill $SSH_AGENT_PID')
      expect(replies.last).to eq('OK, I will run a deploy soon...')
    end
  end
end
