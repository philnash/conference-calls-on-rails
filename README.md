# Conference calls on Rails

This application is a simple example of hosting a conference call with Twilio in a Ruby on Rails application.

## Running the application

Make sure you have the following:

* [Ruby](ruby-lang.org/) and [Bundler](https://bundler.io/) installed
* A Twilio account ([sign up for a free account here](https://www.twilio.com/try-twilio))
* A [Twilio phone number](https://www.twilio.com/user/account/phone-numbers/incoming) that can receive incoming calls
* [ngrok](https://ngrok.com) for [testing webhooks with our local application](https://www.twilio.com/user/account/phone-numbers/incoming)

Clone or download the repo:

```bash
git clone https://github.com/philnash/conference-calls-on-rails.git
cd conference-calls-on-rails
```

Install the dependencies:

```bash
bundle install
```

Start the application:

```bash
bundle exec rails server
```

Start ngrok exposing port 3000:

```bash
ngrok http 3000
```

Take the ngrok URL, add the path `/calls`, open the edit page for your Twilio phone number and enter it in the field marked "When a call comes in". The full URL should look like: `https://YOUR_NGROK_SUBDOMAIN.ngrok.io/calls`. Save the number.

Place a phone call to your Twilio number, you will now be on hold waiting for your conference call to start.

## LICENSE

MIT © Phil Nash 2020