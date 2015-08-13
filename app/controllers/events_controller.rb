class EventsController < ApplicationController
  respond_to :json

  def index
    @cal_events = current_user.events.as_json
    render :json @cal_events
  end



end