# SSHero

### Provision production app
```
cd ~
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install esl-erlang
sudo apt-get install elixir
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### EDeliver commands
```
<!--  initial deployment -->
mix edeliver build release
mix edeliver deploy release to production
mix edeliver start production

OR

DOES NOT WORK!
<!--  subsequent deployments (when app is still running in production) -->
mix edeliver upgrade production --auto-version=commit-count+git-revision+branch-unless-master


WORKS!
https://github.com/edeliver/edeliver/wiki/Auto-Versioning
<!--  subsequent deployments (when app is still running in production) -->
mix edeliver version production (ensure local store has the current release tar zip)
mix edeliver build upgrade --with=0.0.1+22-ebaecdf
rm .deliver/releases/sshero_0.0.1+22-ebaecdf.upgrade.tar.gz
mix edeliver deploy upgrade to production

```

### Log a stream
```
 require Logger
 alias Porcelain.Process, as: Proc
 alias Porcelain.Result
 opts = [out: :stream]
 proc = %Proc{out: outstream} = Porcelain.spawn("mix", ["edeliver", "upgrade", "production"], opts)
 Enum.each(outstream, &Logger.info/1)
 ```

### Misc.
 ```
 # RELEASE_DIR="$BUILD_AT/$APP"
 AUTO_VERSION=commit-count+git-revision+branch-unless-master
 scp ~/workspace/sshero/config/prod.secret.exs deployer:/root/app_config/prod.secret.exs
 ```
