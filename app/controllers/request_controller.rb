class RequestController < ApplicationController


  def create
    @item=Item.where("item_name LIKE '#{params[:item_name]}%'")

  end

  def add
    if params[:count].to_i > 0
      flash[:error] = false
      item=TempReq.where("team_id = #{session[:team_id]} and item_name='#{params[:item]}'")
      if item.empty?
        tmp=TempReq.new
        tmp.team_id = session[:team_id]
        tmp.item_name = "#{params[:item]}"
        tmp.count = params[:count]
        tmp.save
        redirect_to(:controller => 'request', :action => 'user_dashboard')
      else
        @item=TempReq.where("team_id = #{session[:team_id]} and item_name='#{params[:item]}'")
        for item in @item
          item.count = params[:count]
          item.save
        end
        redirect_to(:controller => 'request', :action => 'user_dashboard')

      end
    else
      flash[:error]=true
    end

  end

  def destroy
    TempReq.where("team_id = #{session[:team_id]} and item_name='#{params[:item]}'").destroy_all
    redirect_to(:controller => 'request', :action => 'user_dashboard')

  end

  def late_destroy
    @item=Request.where("team_id = #{session[:team_id]} and item_id=#{params[:item_id]} and id=#{params[:req_id]}").first
    @log=Log.where("team_id = #{session[:team_id]} and item_id=#{params[:item_id]} and id=#{params[:req_id]}").first
    @id = Item.where("id = #{params[:item_id]}").first
    #var=@item.requested.to_i - @item.approved.to_i
    if @item.approved.to_i == 0
      @id.item_requested = (@id.item_requested.to_i - (@item.requested.to_i - @item.approved.to_i)).to_s
      @item.destroy
      @log.destroy

    else
      @id.item_requested = (@id.item_requested.to_i - (@item.requested.to_i - @item.approved.to_i)).to_s
      @item.requested=@item.approved
      @item.save
      @log.requested=@log.approved
      @log.save
    end
    #@id.item_requested = (@id.item_requested.to_i - (@item.requested.to_i - @item.approved.to_i)).to_s
    @id.save
    redirect_to(:controller => 'request', :action => 'display')

  end

  def submit
    @item=TempReq.where("team_id = #{session[:team_id]}")
    for item in @item
      @id = Item.where("item_name = '#{item.item_name}'").first

        tmp=Request.where("team_id = #{session[:team_id]} and item_id=#{@id.id}")
        #if tmp.empty?
        req=Request.new
        req.team_id = session[:team_id]
        req.item_id = @id.id
        req.requested = item.count
        req.approved = 0
        req.save
        #else
        #	@req=Request.where("user_id = #{session[:user_id]} and item_id=#{id.id}")
        #	for req in @req
        #		req.requested = req.requested + item.count
        #		req.save
        #	end
        #end

        log=Log.new
        log.request_id = req.id
        log.team_id = session[:team_id]
        log.item_id = @id.id
        log.requested = item.count
        log.approved = 0
        log.status = "pending"
        log.save


        @id.item_requested = (@id.item_requested.to_i + item.count.to_i).to_s
        @id.save

    end
    sql = ActiveRecord::Base.connection();
    sql.execute("delete from temp_reqs where team_id=#{session[:team_id]}")
  end

  def update
  end

  def plus
    val = 1
    val = params[:count].to_i + val.to_i
    params[:count] = val.to_s
    redirect_to(:controller => 'request', :action => 'create' ,:item_name => params[:item] ,:val => params[:count] )
  end

  def display
    @req=Request.where("team_id = #{session[:team_id]}")
    @ary=Array.new
    for req in @req
      @item=Item.where("id=#{req.item_id}")
      for item in @item
        @ary.push(item.item_name)
      end
    end

  end


  def log
    @l=Log.where("team_id = #{session[:team_id]}")
    @ary=Array.new
    for l in @l
      @item=Item.where("id=#{l.item_id}")
      for item in @item
        @ary.push(item.item_name)
      end
    end

  end

  def admin_dashboard
  end

  def user_dashboard
    #user=User.find(session[:user_id])

    #flash[:id]=user[:team_id]
    @item=TempReq.where("team_id = #{session[:team_id]}")
    @req_item=Request.where("team_id = #{session[:team_id]}")
    if !params[:item_name].nil?
      @itemList=Item.where("item_name LIKE '#{params[:item_name]}%'")
    end




  end


end
