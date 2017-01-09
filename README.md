# New Orleans Area Habitat For Humanity Sign-In

[![Stories in Ready](https://badge.waffle.io/rubyforgood/habitat_humanity.png?label=ready&title=Ready)](https://waffle.io/rubyforgood/habitat_humanity)
[![Code Climate](https://codeclimate.com/github/rubyforgood/habitat_humanity/badges/gpa.svg)](https://codeclimate.com/github/rubyforgood/habitat_humanity)

As software developers we have it pretty good and and housing isn't a concern
for us. Unfortunately, not everyone is as lucky, especially the people of New
Orleans. Despite hurricane Katrina happening about a decade ago, there are still
a lot of displaced people in temporary residences who need somewhere to call
home. The amazing people at habitat for humanity are trying to fix this with
their work in New Orleans 9th ward (one of the hardest hit areas by Katrina) and
with a recent grant they received their work is only going to move quicker. The
problem is, one of the requirements of the grant is a stricter recording and
reporting process of their 300 or so daily volunteers which is where we come in!
Let's help them with the great work they are doing by making this process faster
so they have more time to rebuilding people's lives.

Volunteers will use this app to sign in and out of work sites by entering a
touch-based signature on their smartphone. The technical details will be decided
by the team as a group, but this JS widget for taking signatures is promising
(try it on your phone): https://github.com/szimek/signature_pad


## Quick Start

By the end of this section, you should have the project and dependencies
installed on your local system. For information on how to contribute, see
[Contributing](#contributing).

You need:

- Ruby 2.3
- Rails 4.2.x
- Postgres 9.5 (May be changed by team later)
- A javascript runtime, we recommend node.js 
- PhantomJS (`brew install phantomjs` on macOS or
  [read instructions](https://github.com/teampoltergeist/poltergeist#installing-phantomjs))

You will need Node.js (which comes bundled with NPM) and it is simple to install on Mac, Windows, or Linux by downloading and installing from [node.js](https://nodejs.org/en/download/).


You will also need Git, Ruby, Rails, and PostgreSQL.  If you have Git, Ruby and Postgres in
some version or another you're probably set. But:

- If you're working on a virgin Windows machine, you're best off installing Ruby and Rails with
  the [RailsInstaller](http://railsinstaller.org). For PostgreSQL, you'll want to install [EnterpriseDB](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads#windows)
- If you have a virgin Mac OSX machine, just follow these [directions](https://gorails.com/setup/osx/10.12-sierra). This includes PostgreSQL
- If you are using Ubuntu Linux, use this [RailsApps Guide](http://railsapps.github.io/installrubyonrails-ubuntu.html) to get set up with Ruby, Rails, and node.js and this guide to [install PostgreSQL in Ubuntu](https://www.postgresql.org/download/linux/ubuntu/)

Then from a command prompt:

```bash
$ git clone http://github.com/rubyforgood/habitat_humanity
$ cd habitat_humanity
$ bin/setup
$ rails s
```

Then navigate to `http://localhost:3000` in your browser to view the app.

To view the admin tools, navigate to `http://localhost:3000/sign_in`. Use the credentials below:

* Admin
   * Email: `admin@example.com`
   * Password: `password`

*Note: If you didn't run `bin/setup`, run `rake db:initialize_admin` to initialize the admin account.*


## Contributing

We ♥ contributors! Learn more about our tools, technologies, and workflow
in the [Wiki][wiki]. Be sure to follow our [Contribution Guidelines][CONTRIBUTING.md]
before submitting a PR.

To join the conversation, join the [#habitat_humanity][slack-channel] channel
on Slack ([get an invite][slack-invite]).

[wiki]: https://github.com/rubyforgood/habitat_humanity/wiki
[CONTRIBUTING.md]: CONTRIBUTING.md
[slack-channel]: https://rubyforgood.slack.com/messages/habitat_humanity
[slack-invite]: https://rubyforgood.herokuapp.com/


## About Habitat for Humanity NOLA

Habitat for Humanity NOLA is the New Orleans branch of the international organization Habitat for
Humanity. Habitat for Humanity is dedicated to building decent, affordable housing. From their
statement of purpose:

> We believe in the power of building homes for and with those who need them. We believe that by
  teaming up with families, volunteers, and donors, we can create thriving communities for
  generations to come. **We are New Orleans Area Habitat for Humanity. And we believe in the
  power of home.**

More information on the organization is available on their website:
http://www.habitat-nola.org/


## About Ruby for Good

This project was born at Ruby for Good 2016.

Ruby for Good is an annual event based out of the DC-metro area where Ruby programmers from all over
the globe get together for a long weekend to build projects that help our communities. For more
information about Ruby for Good, [visit the website] or [check out the other projects].

[visit the website]: http://rubyforgood.org/
[check out the other projects]: http://rubyforgood.org/yearbook.html
