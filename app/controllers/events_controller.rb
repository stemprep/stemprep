class EventsController < ApplicationController
  respond_to :json
  # wrap_parameters :event

  def index
    @cal_events = current_user.events
    render json: @cal_events
  end

  def create
    user_start = Time.at(params[:event][:start_time].to_i / 1000).to_datetime
    user_end = Time.at(params[:event][:end_time].to_i / 1000).to_datetime
    event = current_user.events.new(event_params)
    event.start_time = user_start
    event.end_time = user_end
    if current_user.admin?
      # User.admins
    end
    if event.save
      puts "<><><><><><><><><>><><><><><><><><><><><><><><><><><><><><><><><><>><><><"
      puts "event saved:"
      puts event
      puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><><"
    end
  end



  private
  def event_params
    params.require(:event).permit(:start_time, :end_time, :title, :url, :all_day)
  end




end