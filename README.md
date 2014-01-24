# Upstarter

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'upstarter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install upstarter

## Usage

Create your configuration file, like `upstarter.yml`. Check the following example:

```yaml
name: "myapp"
env: "production"
user: "www-data"
chdir: "/var/www/%{name}/current"

processes:
  thin:
    port: 5000
    instances: 3
    cmd: "bundle exec thin -p %{port} -e %{env} -P %{pidfile} start >> %{logfile} 2>&1"

  node:
    port: 7000
    cmd: "node server.js >> %{logfile} 2>&1"
```

When you run `upstarter upstarter.yml`, the following files will be generated:

```text
upstarter/myapp.conf
upstarter/myapp-thin.conf
upstarter/myapp-thin-1.conf
upstarter/myapp-thin-2.conf
upstarter/myapp-thin-3.conf
upstarter/myapp-node.conf
```

The master process `myapp.conf` allows you to manage the whole stack with a single entry point.

```bash
start myapp
stop myapp
restart myapp
```

Since all other files has a dependency on `myapp.conf`, they will be automatically started/stopped/restarted.

The `myapp-thin.conf` handles the process group for `thin`. This based on the number of instances you're going to start.

The following keywords are directly mapped into the YAML structure:

- `chdir`
- `env`
- `exec`
- `post-start` (through the `post_start` option)
- `post-stop` (through the `post_stop` option)
- `pre-start` (through the `pre_start` option)
- `pre-stop` (through the `pre_stop` option)
- `script`
- `script`
- `setuid` (through the `user` option)

Any other option can be defined through the `raw` option, which accepts any string.

All defined options can be interpolated in commands. Take the following example:

```yaml
name: "myapp"
processes:
  thin:
    instances: 5
    rails_env: production
    user: www-data
    chdir: /var/www/myapp/current
    port: 5000
    exec: "bundle exec thin -p %{port} -e %{rails_env} -P %{pidfile} start >> %{logfile} 2>&1"
```

- The `port` key is a special one, incremented by 1 in a loop.
- The `rails_env` key is taken directly from the options defined and has no special meaning.
- The `pidfile` and `logfile` are automatically defined based on the process number/name. In this case, it will generate something like `/var/log/myapp/myapp-thin-1.log` and `/var/run/myapp/myapp-thin-1.pid`.

## Contributing

1. Fork it ( http://github.com/[my-github-username]/upstarter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
