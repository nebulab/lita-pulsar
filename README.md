# lita-pulsar

A simple integration between a [Lita](https://www.lita.io) bot and [Pulsar](http://pulsar.nebulab.it).

It will make it easy to integrate a chat application with your infrastructure to deploy apps via chat.

## Installation

Add lita-pulsar to your Lita instance's Gemfile:

``` ruby
gem "lita-pulsar"
```

## Configuration

The only configuration you should need is the repository where the Pulsar configuration is stored:

```
Lita.configure do |config|
  config.handlers.pulsar.conf_repo = "your-gh-user/pulsar-conf"
end
```

## Usage

The command that this plugin exposes is `deploy`:

```
deploy APPLICATION STAGE - Deploys APPLICATION on STAGE
```

It will run Pulsar on the machine where Lita is running and deploy `APPLICATION` on `STAGE`.

## License

[MIT](http://opensource.org/licenses/MIT)
