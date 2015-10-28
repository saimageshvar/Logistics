class ItemsController < ApplicationController

  def create
    @item = Item.new
    @item.item_name = params[:item_name]
    @item.item_total = Integer(params[:item_total])
    @item.item_requested = 0
    @item.item_approved = 0
    @item.item_alloted = 0
    @item.item_remaining = params[:item_total]
    @item.save

    if @item.save
      if session[:user_type] == 'admin'
        redirect_to(:action => 'admin_dashboard')
      else
        redirect_to(:controller => 'request' , :action => 'user_dashboard')
      end
    end
  end


  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    if session[:user_type] == "admin"
      redirect_to(:action => 'admin_dashboard')
    else
      redirect_to(:controller => 'request' , :action => 'user_dashboard')
    end
  end

  def update
    @item = Item.find(params[:team_id])
    if params[:action] == 'plus'
      @item.item_total = @item.item_total + Integer(params[:num])
    elsif params[:action] == 'minus'
      @item.item_total = @item.item_total - Integer(params[:num])
    end
    @item.save
    redirect_to(:action => 'admin_dashboard')
  end

  def show
  end

  def admin_dashboard
    @items = Item.all
  end

  def list_by_team
    if params[:team_id] == nil and params[:team_type] == nil
      @temp = "Hello" # dummy parameter to use for if elif conditions
    elsif params[:team_id] == nil and params[:team_type] != nil
      @teams = Team.where(:team_type => params[:team_type])
    else
      @requests = Request.where(:team_id => params[:team_id])
      @team = Team.find(params[:team_id])
    end
  end

  def list_by_item
    @requests = Request.where(:item_id => params[:item_id])
    @item = Item.find(params[:item_id])
  end

  def approvebyitem
    @item = Item.find_by_id(params[:item_id])
    @request = Request.find_by_id(params[:request_id])
    @log = Log.where( "request_id = #{params[:request_id]} and item_id = #{params[:item_id]} and team_id = #{params[:team_id]}").first;
    if Integer(params[:toApprove]) <= Integer(@item.item_remaining) and Integer(params[:toApprove]) <= @request.requested and Integer(params[:toApprove]) <= (@request.requested-@request.approved)
      @request.approved = @request.approved + Integer(params[:toApprove])
      @item.item_remaining = @item.item_remaining - Integer(params[:toApprove])
      @item.item_approved = @item.item_approved + Integer(params[:toApprove])
      @log.requested = @request.requested
      @log.approved = @request.approved
      if @request.approved == @request.requested
         @log.status = 'Approved'
       elsif @request.approved < @request.requested
         @log.status = 'Pending'
       elsif @request.requested == 0
         @log.status = 'Returned'
       end
    elsif Integer(params[:toApprove]) > Integer(@item.item_remaining)
       flash[:notice] = "Cannot approve more than remaining items"
     else
       flash[:notice] = "Cannot approve more than requested"
    end
    # @log.save
    @request.save
    @item.save
    @log.save
    redirect_to('/items/list_by_item?item_id=' + params[:item_id]);
  end


  def approvebyteam
    @item = Item.find_by_id(params[:item_id])
    @request = Request.find_by_id(params[:request_id])
    @log = Log.where( "request_id = #{params[:request_id]} and item_id = #{params[:item_id]} and team_id = #{params[:team_id]}").first;
    if Integer(params[:toApprove]) <= Integer(@item.item_remaining) and Integer(params[:toApprove]) <= @request.requested and Integer(params[:toApprove]) <= (@request.requested-@request.approved)
      @request.approved = @request.approved + Integer(params[:toApprove])
      @item.item_remaining = @item.item_remaining - Integer(params[:toApprove])
      @item.item_approved = @item.item_approved + Integer(params[:toApprove])
      @log.requested = @request.requested
      @log.approved = @request.approved
      if @request.approved == @request.requested
         @log.status = 'Approved'
       elsif @request.approved < @request.requested
         @log.status = 'Pending'
       elsif @request.requested == 0
         @log.status = 'Returned'
       end
    elsif Integer(params[:toApprove]) > Integer(@item.item_remaining)
       flash[:notice] = "Cannot approve more than remaining items"
     else
       flash[:notice] = "Cannot approve more than requested"
    end
    # @log.save
    @request.save
    @item.save
    @log.save
    redirect_to('/items/list_by_item?item_id=' + params[:item_id]);
  end

  def returnbyitem
    @item = Item.find_by_id(params[:item_id])
    @request = Request.find_by_id(params[:request_id])
    @log = Log.where( "request_id = #{params[:request_id]} and item_id = #{params[:item_id]} and team_id = #{params[:team_id]}").first;
    @request.requested = @request.requested - Integer(params[:toReturn])
    @request.approved = @request.approved - Integer(params[:toReturn])
    @item.item_remaining = @item.item_remaining + Integer(params[:toReturn])
    @item.item_approved = @item.item_approved - Integer(params[:toReturn])
	  @item.item_requested = @item.item_requested - Integer(params[:toReturn])
    #@log.requested = @request.requested
    #@log.approved = @request.approved
    if @request.approved == @request.requested and @request.requested != 0
      @log.status = 'Approved'
    elsif @request.approved < @request.requested
      @log.status = 'Pending'
    elsif @request.requested == 0
      @log.status = 'Returned'
    end
    @log.save
    @request.save
    @item.save
      redirect_to('/items/list_by_item?item_id=' + params[:item_id]);
  end

  def returnbyteam
    @item = Item.find_by_id(params[:item_id])
    @request = Request.find_by_id(params[:request_id])
    @log = Log.where( "request_id = #{params[:request_id]} and item_id = #{params[:item_id]} and team_id = #{params[:team_id]}").first;
    @request.requested = @request.requested - Integer(params[:toReturn])
    @request.approved = @request.approved - Integer(params[:toReturn])
    @item.item_remaining = @item.item_remaining + Integer(params[:toReturn])
    @item.item_approved = @item.item_approved - Integer(params[:toReturn])
    @item.item_requested = @item.item_requested - Integer(params[:toReturn])
    #@log.requested = @request.requested
    #@log.approved = @request.approved
    if @request.approved == @request.requested and @request.requested != 0
      @log.status = 'Approved'
    elsif @request.approved < @request.requested
      @log.status = 'Pending'
    elsif @request.requested == 0
      @log.status = 'Returned'
    end
    @log.save
    @request.save
    @item.save
      redirect_to('/items/list_by_item?item_id=' + params[:item_id]);
  end



  def allotbyteam
    @num = Integer(params[:toAllot])
    @item = Item.find_by_id(params[:item_id])
    @request = Request.find_by_id(params[:request_id])
    @log = Log.where( "request_id = #{params[:request_id]} and item_id = #{params[:item_id]} and team_id = #{params[:team_id]}").first;
    if @num <= @request.requested and @num <= @item.item_remaining
      @request.allotted = @num
      @item.item_alloted = @item.item_alloted + @num
      @request.requested = @num
      @log.allotted = @num
    end
    @request.save
    @item.save
    @log.save
    redirect_to('/items/list_by_team?team_id=' + params[:team_id]);
  end

  def allotbyitem
    @num = Integer(params[:toAllot])
    @item = Item.find_by_id(params[:item_id])
    @request = Request.find_by_id(params[:request_id])
    @log = Log.where( "request_id = #{params[:request_id]} and item_id = #{params[:item_id]} and team_id = #{params[:team_id]}").first;
    if @num <= @request.requested and @num <= @item.item_remaining
      @request.allotted = @num
      @item.item_alloted = @item.item_alloted + @num
      @request.requested = @num
      @log.allotted = @num
    end
    @request.save
    @item.save
    @log.save
    redirect_to('/items/list_by_item?item_id=' + params[:item_id]);
  end

  def total
    @item = Item.find(params[:item_id])
    puts 'ID => ' + params[:item_id]
    puts 'Task => ' + params[:task]
    if params[:task] == 'plus'
      @item.item_total = @item.item_total + Integer(params[:number])
      @item.item_remaining = @item.item_total - @item.item_approved
    elsif params[:task] == 'minus'
      if @item.item_total - Integer(params[:number]) > 0
        @item.item_total = @item.item_total - Integer(params[:number])
        @item.item_remaining = @item.item_total - @item.item_approved
      end
    end

    if @item.save
      redirect_to(:action => 'admin_dashboard')
    end
  end

end
