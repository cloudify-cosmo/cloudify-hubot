

# Cloudify's Hubot

This repository contains Cloudify's configuration of Github's Hubot along with a Dockerfile to build the container which runs Hubot and a Vagrant file to load Hubot in Virtualbox and AWS.

## Prereqs:

- For building the container - docker
- For running the bot in AWS - vagrant and vagrant aws plugin
- For running the bot in virtualbox -  vagrant and... guess!

## Building the container

To build the container, you must have docker installed.

**Note: Don't forget to push your changes to Github before building since the build process clones this repo.**

From the Vagrant folder run:

```shell
sudo docker build -t dockerhub_user/ducker_hub_repo .
```

Then push the container by running:

**Note: You must be logged in to Docker Hub to push to the repo.**

```shell
sudo docker push dockerhub_user/ducker_hub_repo
```

## Running the container

To load the machine and run the container:

### Setup the environment variables

You must set the following environment variables on your local machine:

- HUBOT_CONTAINER_REPO - The Docker Hub repo to download the container from (e.g nir0s/cloudify-hubot)
- HUBOT_FLOWDOCK_LOGIN_EMAIL
- HUBOT_FLOWDOCK_LOGIN_PASSWORD

If you're running on AWS, set the following variables as well:

- AWS_ACCESS_KEY_ID
- AWS_ACCESS_KEY


#### Testing

When supplying the HUBOT_CONTAINER_REPO, you can use something like nir0s/cloudify-hubot:TAG, where tag is the tag you've given the docker image when you created it. This can aid in testing. After building your image, push it with a specific tag (e.g "test" or "dev", etc) and when you run the container/vm, set the HUBOT_CONTAINER_REPO env var to use the tag you've created. When you're done, you can push the image without a tag to overwrite "latest".


### Run the container locally

**Note: change "localtestbot" to the name you want to give the bot**

```shell
sudo docker run -d --name hubot $HUBOT_CONTAINER_REPO /bin/sh -c "export HUBOT_FLOWDOCK_LOGIN_EMAIL=\"$HUBOT_FLOWDOCK_LOGIN_EMAIL\" && export HUBOT_FLOWDOCK_LOGIN_PASSWORD=\"$HUBOT_FLOWDOCK_LOGIN_PASSWORD\" && cd /cloudify-hubot && bin/hubot --name localtestbot -a flowdock"
```

### Run the container inside a vm

**Note: When loading the AWS machine, the default bot name is "bot". When loading the VBOX machine, the default name is "testbot". These are setup in advance. You can change the defaults there by changing the TEST_BOT_NAME and BOT_NAME variables in the Vagrantfile.**

#### AWS

```shell
vagrant up hubot_aws --provider=aws
```

#### VBOX - for testing purposes

```shell
vagrant up hubot_vbox
```



From Github:

# Hubot

This is a version of GitHub's Campfire bot, hubot. He's pretty cool.

This version is designed to be deployed on [Heroku][heroku]. This README was generated for you by hubot to help get you started. Definitely update and improve to talk about your own instance, how to use and deploy, what functionality he has, etc!

[heroku]: http://www.heroku.com

### Testing Hubot Locally

You can test your hubot by running the following.

    % bin/hubot

You'll see some start up output about where your scripts come from and a
prompt.

    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading adapter shell
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/scripts
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/src/scripts
    Hubot>

Then you can interact with hubot by typing `hubot help`.

    Hubot> hubot help

    Hubot> animate me <query> - The same thing as `image me`, except adds a few
    convert me <expression> to <units> - Convert expression to given units.
    help - Displays all of the help commands that Hubot knows about.
    ...


### Scripting

Take a look at the scripts in the `./scripts` folder for examples.
Delete any scripts you think are useless or boring.  Add whatever functionality you
want hubot to have. Read up on what you can do with hubot in the [Scripting Guide](https://github.com/github/hubot/blob/master/docs/scripting.md).

### Redis Persistence

If you are going to use the `redis-brain.coffee` script from `hubot-scripts`
(strongly suggested), you will need to add the Redis to Go addon on Heroku which requires a verified
account or you can create an account at [Redis to Go][redistogo] and manually
set the `REDISTOGO_URL` variable.

    % heroku config:set REDISTOGO_URL="..."

If you don't require any persistence feel free to remove the
`redis-brain.coffee` from `hubot-scripts.json` and you don't need to worry
about redis at all.

[redistogo]: https://redistogo.com/

## Adapters

Adapters are the interface to the service you want your hubot to run on. This
can be something like Campfire or IRC. There are a number of third party
adapters that the community have contributed. Check
[Hubot Adapters][hubot-adapters] for the available ones.

If you would like to run a non-Campfire or shell adapter you will need to add
the adapter package as a dependency to the `package.json` file in the
`dependencies` section.

Once you've added the dependency and run `npm install` to install it you can
then run hubot with the adapter.

    % bin/hubot -a <adapter>

Where `<adapter>` is the name of your adapter without the `hubot-` prefix.

[hubot-adapters]: https://github.com/github/hubot/blob/master/docs/adapters.md

## hubot-scripts

There will inevitably be functionality that everyone will want. Instead
of adding it to hubot itself, you can submit pull requests to
[hubot-scripts][hubot-scripts].

To enable scripts from the hubot-scripts package, add the script name with
extension as a double quoted string to the `hubot-scripts.json` file in this
repo.

[hubot-scripts]: https://github.com/github/hubot-scripts

## external-scripts

Tired of waiting for your script to be merged into `hubot-scripts`? Want to
maintain the repository and package yourself? Then this added functionality
maybe for you!

Hubot is now able to load scripts from third-party `npm` packages! To enable
this functionality you can follow the following steps.

1. Add the packages as dependencies into your `package.json`
2. `npm install` to make sure those packages are installed

To enable third-party scripts that you've added you will need to add the package
name as a double quoted string to the `external-scripts.json` file in this repo.

## Deployment

    % heroku create --stack cedar
    % git push heroku master
    % heroku ps:scale app=1

If your Heroku account has been verified you can run the following to enable
and add the Redis to Go addon to your app.

    % heroku addons:add redistogo:nano

If you run into any problems, checkout Heroku's [docs][heroku-node-docs].

You'll need to edit the `Procfile` to set the name of your hubot.

More detailed documentation can be found on the
[deploying hubot onto Heroku][deploy-heroku] wiki page.

### Deploying to UNIX or Windows

If you would like to deploy to either a UNIX operating system or Windows.
Please check out the [deploying hubot onto UNIX][deploy-unix] and
[deploying hubot onto Windows][deploy-windows] wiki pages.

[heroku-node-docs]: http://devcenter.heroku.com/articles/node-js
[deploy-heroku]: https://github.com/github/hubot/blob/master/docs/deploying/heroku.md
[deploy-unix]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md
[deploy-windows]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md

## Campfire Variables

If you are using the Campfire adapter you will need to set some environment
variables. Refer to the documentation for other adapters and the configuraiton
of those, links to the adapters can be found on [Hubot Adapters][hubot-adapters].

Create a separate Campfire user for your bot and get their token from the web
UI.

    % heroku config:set HUBOT_CAMPFIRE_TOKEN="..."

Get the numeric IDs of the rooms you want the bot to join, comma delimited. If
you want the bot to connect to `https://mysubdomain.campfirenow.com/room/42`
and `https://mysubdomain.campfirenow.com/room/1024` then you'd add it like this:

    % heroku config:set HUBOT_CAMPFIRE_ROOMS="42,1024"

Add the subdomain hubot should connect to. If you web URL looks like
`http://mysubdomain.campfirenow.com` then you'd add it like this:

    % heroku config:set HUBOT_CAMPFIRE_ACCOUNT="mysubdomain"

[hubot-adapters]: https://github.com/github/hubot/blob/master/docs/adapters.md

## Restart the bot

You may want to get comfortable with `heroku logs` and `heroku restart`
if you're having issues.
