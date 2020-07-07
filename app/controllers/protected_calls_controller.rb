# frozen_string_literal: true

class ProtectedCallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def welcome
    twiml = Twilio::TwiML::VoiceResponse.new
    twiml.gather(action: protected_calls_verify_path) do |gather|
      gather.say(voice: "alice", message: "Please enter the code to enter the conference followed by the hash.")
    end
    render xml: twiml
  end

  def verify
    twiml = Twilio::TwiML::VoiceResponse.new
    digits = params["Digits"]
    if digits == ENV["CONFERENCE_PIN"]
      twiml.say(voice: "alice", message: "Thank you, joining the conference now.")
      twiml.dial do |dial|
        dial.conference("Vault")
      end
    else
      twiml.say(voice: "alice", message: "Sorry, that code is incorrect.")
      twiml.redirect(protected_calls_welcome_path)
    end
    render xml: twiml
  end
end
