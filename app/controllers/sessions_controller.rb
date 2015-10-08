class SessionsController < ApplicationController

  def show
    @session_name = session[:user_name]
    @session_id = session[:user_id]
    @session_type = session[:user_type]
    @session_team = session[:user_team]
  end

end
