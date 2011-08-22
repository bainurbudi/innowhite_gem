class ApiController < ApplicationController
  require 'digest/sha1'
 # require 'innowhite'
  before_filter :pass_authenticate, :initialize_key

  def get_active_session
    if params[:status].downcase == "active"
      @active_sessions = @innowhite.get_sessions("active") rescue nil
    else
      @past_sessions = @innowhite.get_sessions("past") rescue nil
    end

    render :update do |page|
      if params[:status] == "active"
        page.replace "result-active", :partial => "active", :locals => {:active_sessions => @active_sessions}
      else
        page.replace "result-past", :partial => "past", :locals => {:past_sessions => @past_sessions}
      end
    end
  end


  ## testing api
  def index    
    act = @innowhite.get_sessionsaa("active") rescue nil
    pst = @innowhite.get_sessionsaa("Past") rescue nil
    @active_sessions = act.nil? ? [] : act
    @past_sessions = pst.nil?? [] : pst
  end

  def create_room
    innowhite = Innowhite.new(params[:user],"abc")
    res = innowhite.create_room
    render :update do |page|
      page.replace "result", "<div id='result'>room_id = #{res[:room_id]} and address = #{res[:address]}</div>"
    end
  end

  def join_room    
    innowhite = Innowhite.new(params[:user],"abc")
    res = innowhite.join_meeting(params[:room_id], params[:user])
    require 'pp'
    
    render :update do |page|
      page.replace "result-room", "<div id='result-room'>#{res}</div>"
    end
  end

  def create_room_info
    @user = User.find(params[:user])
    @meeting = WebSession.find_by_session_id(params[:roomId])
    @tags = params[:tags].split(',')
    @desc = params[:desc]

    @meeting.update_attribute(:session_desc, @desc)
    @meeting.tag_list = @tags
    @meeting.save!

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meeting }
    end
  end


  private

  def pass_authenticate
    Digest::SHA1.hexdigest("#{params[:orgName]}"+"innowhite"+"#{params[:private]}")
  end

  def initialize_key
    @innowhite =  Innowhite.new("bainur","abc")
  end
end
