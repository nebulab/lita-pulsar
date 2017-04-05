module Lita
  module Handlers
    class Pulsar < Handler
      config :conf_repo, required: true, default: nil

      route(/deploy\s+(.+)\s+(.+)/i, :deploy, command: true, help:
        { 'deploy APPLICATION STAGE' => 'Deploys APPLICATION on STAGE' })

      def deploy(response)
        args = cmd_args(response.args)

        Bundler.with_clean_env do
          spawn("eval `ssh-agent -s` && ssh-add && bundle exec pulsar deploy #{cmd_opts} #{args}; kill $SSH_AGENT_PID")
        end

        response.reply 'OK, I will run a deploy soon...'
      end

      private

      def cmd_args(args)
        Shellwords.shelljoin(args)
      end

      def cmd_opts
        "-c #{config.conf_repo}"
      end
    end

    Lita.register_handler(Pulsar)
  end
end
