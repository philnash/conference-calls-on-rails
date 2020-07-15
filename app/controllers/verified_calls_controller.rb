# frozen_string_literal: true

class VerifiedCallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def welcome
    twiml = Twilio::TwiML::VoiceResponse.new
    if participant_permitted?(params["From"])
      start_verification(params["From"])
      twiml.gather(action: verified_calls_verify_path) do |gather|
        gather.say(voice: "alice", message: "Please enter the code to enter the conference followed by the hash.")
      end
    else
      twiml.say(voice: "alice", message: "Sorry, I don't recognize the number you're calling from.")
      twiml.hangup
    end
    render :xml
  end

  def verify
    twiml = Twilio::TwiML::VoiceResponse.new
    if verification_approved?(params["From"], params["Digits"])
      twiml.say(voice: "alice", message: "Thank you, joining the conference now.")
      twiml.dial do |dial|
        dial.conference(
          "Verified",
          start_conference_on_enter: is_moderator?(params["From"]),
          end_conference_on_exit: is_moderator?(params["From"]),
        )
      end
    else
      twiml.say(voice: "alice", message: "Sorry, that code is incorrect.")
      twiml.redirect(verified_calls_welcome_path)
    end
    render :xml
  end

  private

  def verify_service
    client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    client.verify.services(ENV["VERIFY_SERVICE_SID"])
  end

  def start_verification(number)
    verify_service.verifications.create(to: number, channel: "sms")
  end

  def verification_approved?(number, code)
    verify_service.verification_checks.create(to: number, code: code).status == "approved"
  end

  def participant_permitted?(from)
    is_moderator?(from) || ENV["PERMITTED_CALLERS"].split(",").include?(from)
  end

  def is_moderator?(from)
    from == ENV["MODERATOR"]
  end
end
