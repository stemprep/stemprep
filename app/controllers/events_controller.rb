class EventsController < ApplicationController
  respond_to :json
  # wrap_parameters :event

  def index
    @cal_events = current_user.events
    render json: @cal_events
  end

  def create

    event = current_user.events.new(event_params)

    if event.save
      puts "<><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><>><><><"
      puts "event saved:"
      puts event
      require 'pry'
      binding.pry
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><"
    end
  end



  private
  def event_params
    params.require(:event).permit(:start_time, :end_time, :title, :url, :all_day)
  end



end