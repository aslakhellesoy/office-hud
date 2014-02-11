# Office HUD

Office HUD is a [Heads Up Display](http://en.wikipedia.org/wiki/Head-up_display) for small offices.

It aggregates information from various information sources into a high-level overview. The purpose
of Office HUD is to make it easier to get an overview over financial information, staffing and
other important metrics in a small or medium sized office.

Office HUD integrates with the following information sources:

* [FreeAgent](http://freeagent.com/)
* More later?

## Run the server

The application must run on a web server and can then be accessed from a browser, tablet or phone.
To run the server locally on your own laptop you must [Install Ruby](https://www.ruby-lang.org)
and [Git](http://git-scm.com/).

### Pull the source code down to your machine

If you are familiar with git and GitHub, please read the [GitHub Guides](http://guides.github.com/).

Open a terminal window and clone the repo:

```
git clone https://github.com/aslakhellesoy/office-hud.git
cd office-hud
```

### Install Dependencies

```
gem install bundler
bundle
```

### Register the app in FreeAgent

You need a [FreeAgent developer account](https://dev.freeagent.com/) for this.
Register a new OAuth app (call it `Office HUD`). This should create two tokens that you'll need
to start the app.

### Start the app

```
FREE_AGENT_KEY=... FREE_AGENT_SECRET=... rackup
```

### Open it up in the browser

Just go to http://localhost:9292 in your browser

## TODO

* Add tests (it's a little too experimental at the moment)
* Draw some charts
* Deploy the webapp to Heroku or other hosting provider
