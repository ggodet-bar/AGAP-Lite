class PatternSystemsController < ApplicationController
  


  def new_participant
    @pattern_system = PatternSystem.find(params[:id])
    flash[:participant] = Participant.new
    respond_to do |format|
       format.html {redirect_to(@pattern_system)}
    end
  end

  def create_participant
    @pattern_system = PatternSystem.find(params[:id])
    @participant = Participant.new(params[:participant])
    respond_to do |format|
      if @participant.save
        @pattern_system.participants << @participant
        @pattern_system.save
        flash[:notice] = 'Participant was successfully created.'
        format.html { redirect_to(@pattern_system) }
  #      format.xml  { render :xml => @pattern_system, :status => :created, :location => @pattern_system }
      else
        format.html { render :action => "new_participant" }
   #     format.xml  { render :xml => @pattern_system.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit_participant
    @pattern_system = PatternSystem.find(session[:pattern_system_id])
    flash[:participant] = Participant.find(params[:id])
    flash[:isEditing] = true
    respond_to do |format|
       format.html {redirect_to(@pattern_system)}
    end
  end
  
  def update_participant
    @pattern_system = PatternSystem.find(session[:pattern_system_id])
    @participant = Participant.find(params[:id])

    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        flash[:notice] = 'Participant was successfully updated.'
        format.html { redirect_to(@pattern_system) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy_participant
    @pattern_system = PatternSystem.find(session[:pattern_system_id])
    @participant = Participant.find(params[:id])
    @participant.destroy
    
    respond_to do |format|
      flash[:notice] = 'Participant was successfully deleted.'
      format.html { redirect_to(@pattern_system) }
      format.xml  { head :ok }
    end
  end

  # GET /pattern_systems
  # GET /pattern_systems.xml
  def index
    @pattern_systems = PatternSystem.find(:all)
    
    session[:pattern_system_id] = nil
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pattern_systems }
    end
  end

  # GET /pattern_systems/1
  # GET /pattern_systems/1.xml
  def show
    @pattern_system = PatternSystem.find(params[:id])
    unless flash[:participant].nil?
      @participant=flash[:participant]
    end
    if flash[:isEditing].nil? or !flash[:isEditing]
      @isEditing = false
    else
      @isEditing = true
    end
    @participants_list = @pattern_system.participants
    session[:pattern_system_id] = params[:id]
    @patterns_list = ProcessPattern.find_all_by_pattern_system_id(params[:id])
    unless @pattern_system.root_pattern_id.nil?
      @root_pattern = ProcessPattern.find(@pattern_system.root_pattern_id)
      @patterns_list = @patterns_list - Array(@root_pattern)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pattern_system }
    end
  end

  # GET /pattern_systems/new
  # GET /pattern_systems/new.xml
  def new
    @pattern_system = PatternSystem.new
    @participant = Participant.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pattern_system }
    end
  end

  # GET /pattern_systems/1/edit
  def edit
    @pattern_system = PatternSystem.find(params[:id])
    unless @pattern_system.root_pattern_id.nil? or @pattern_system.root_pattern_id == ""
      @root_pattern = ProcessPattern.find(@pattern_system.root_pattern_id)
    end
    # puts @root_pattern_idd
    
  end

  # POST /pattern_systems
  # POST /pattern_systems.xml
  def create
    @pattern_system = PatternSystem.new(params[:pattern_system])
    respond_to do |format|
      if @pattern_system.save
        flash[:notice] = 'PatternSystem was successfully created.'
        format.html { redirect_to(@pattern_system) }
        format.xml  { render :xml => @pattern_system, :status => :created, :location => @pattern_system }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pattern_system.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pattern_systems/1
  # PUT /pattern_systems/1.xml
  def update
    @pattern_system = PatternSystem.find(params[:id])
    
    respond_to do |format|
      if @pattern_system.update_attributes(params[:pattern_system])
        flash[:notice] = 'PatternSystem was successfully updated.'
        format.html { redirect_to(@pattern_system) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pattern_system.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pattern_systems/1
  # DELETE /pattern_systems/1.xml
  def destroy
    @pattern_system = PatternSystem.find(params[:id])
    @pattern_system.destroy

    respond_to do |format|
      format.html { redirect_to(pattern_systems_url) }
      format.xml  { head :ok }
    end
  end
end
