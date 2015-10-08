class UsersController < ApplicationController

  def index
    # if session exists, then
    if session[:user_id] != nil
      # if user is admin redirect to admin_dashboard
      if session[:user_type] == "admin"
          redirect_to(:controller => 'items', :action => 'admin_dashboard')
      # else if user is user, redirect to user_dashboard
      elsif session[:user_type] == "user"
        redirect_to(:controller => 'request', :action => 'user_dashboard')
      end
    end
    # else do nothing, display normal index page
  end

  def login
    if params[:username].present? && params[:password].present?
      found_user = User.where(:user_name => params[:username]).first
      found_team = Team.where(:id => found_user.team_id).first
      if found_user
        authorized_user = (found_user.password == params[:password])
      end
    end
    if authorized_user
      # mark user as logged in
      session[:user_id] = found_user.id
      session[:user_name] = found_user.user_name
      session[:user_team] = found_team.team_name
      session[:user_type] = found_user.user_type
      session[:team_id] = found_user.team_id
      if found_user.user_type == "admin"
        # flash[:notice] = "You are now logged in."
        redirect_to(:controller => 'items', :action => 'admin_dashboard')
      else
        # flash[:notice] = "You are now logged in."
        redirect_to(:controller => 'request', :action => 'user_dashboard')
      end
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'index')
    end
  end

  def logout
    session[:user_id] = nil;
    session[:user_name] = nil;
    session[:user_team] = nil;
    redirect_to :action => 'index'
  end

  def new
  end

  def create
  end

  def destroy
  end

end
