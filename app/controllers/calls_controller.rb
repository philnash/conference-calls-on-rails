# frozen_string_literal: true

class CallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    twiml = Twilio::TwiML::VoiceResponse.new
    twiml.say(voice: 'alice', message: "Welcome to the conference call, let's dial you in right away.")
    twiml.dial do |dial|
      dial.conference('Thunderdome')
    end
    render xml: twiml
  end
end
