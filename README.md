# Conference calls on Rails

This application is an example of hosting conference calls with Twilio in a Ruby on Rails application.

There are three types of conference call available and blog posts to describe how to build and run them.

1. [An open conference line](https://www.twilio.com/blog/build-conference-line-twilio-ruby)
2. [A passcode protected conference line](https://www.twilio.com/blog/passcode-protected-conference-line-twilio-ruby)
3. A one-time passcode protected conference line with Twilio Verify

The path you use when setting your phone number's webhook will define which type of conference you are using.

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

Copy the `config/env.yml.example` to `config/env.yml` and fill in the details:

| Environment variable | Meaning |
|----------------------|---------|
| `CONFERENCE_PIN`     | A static passcode to protect conference calls using the `ProtectedCallsController` |
| `TWILIO_ACCOUNT_SID` | Your Account Sid from the [Twilio console](https://www.twilio.com/console) |
| `TWILIO_AUTH_TOKEN`  | Your Auth Token from the [Twilio console](https://www.twilio.com/console) |
| `VERIFY_SERVICE_SID` | A Verify Service Sid, [create the service in your Twilio console](https://www.twilio.com/console/verify/services) |
| `PERMITTED_CALLERS`  | A comma separated list of [e.164 formatted phone numbers](https://www.twilio.com/docs/glossary/what-e164) that are permitted to join a conference call using the `VerifiedCallsController` |
| `MODERATOR`          | An [e.164 formatted phone number](https://www.twilio.com/docs/glossary/what-e164) that is allowed to moderate conference calls using the `VerifiedCallsController` |

Start the application:

```bash
bundle exec rails server
```

Start ngrok exposing port 3000:

```bash
ngrok http 3000
```

Take the ngrok URL, add the required path:

* `/calls` for an open conference line
* `/protected_calls/welcome` for a passcode protected conference line
* `/verified_calls/welcome` for a one-time passcode verified conference line

Then open the edit page for your Twilio phone number and enter it in the field marked "When a call comes in". The full URL should look like: `https://YOUR_NGROK_SUBDOMAIN.ngrok.io/PATH`. Save the number.

Place a phone call to your Twilio number.

## LICENSE

MIT © Phil Nash 2020