class PatternSystemsController < ApplicationController

  before_filter :load_system, :except => [:new, :index, :create]

  # GET /pattern_systems
  # GET /pattern_systems.xml
  def index
    @pattern_systems = PatternSystem.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pattern_systems }
    end
  end

  # GET /pattern_systems/1
  # GET /pattern_systems/1.xml
  def show
    if flash[:participant]
      @participant=flash[:participant]
    end
    @isEditing = flash[:isEditing]

    puts @isEditing

    @participants_list = @pattern_system.participants
    @patterns_list = ProcessPattern.find_all_by_pattern_system_id(@pattern_system)
    unless @pattern_system.root_pattern_id.nil? or @pattern_system.root_pattern_id.empty?
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
      @root_pattern = ProcessPattern.find(@pattern_system.root_pattern_id) unless @pattern_system.root_pattern_id.blank?
  end

  # POST /pattern_systems
  # POST /pattern_systems.xml
  def create
    @pattern_system = PatternSystem.new(params[:pattern_system])
    respond_to do |format|
      if @pattern_system.save
        flash[:notice] = t(:successful_creation, :model => PatternSystem.human_name)
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
    respond_to do |format|
      if @pattern_system.update_attributes(params[:pattern_system])
        flash[:notice] = t(:successful_update, :model => PatternSystem.human_name)
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
    @pattern_system.destroy
    respond_to do |format|
      flash[:notice] = t(:successful_delete, :model => PatternSystem.human_name)
      format.html { redirect_to(pattern_systems_url) }
      format.xml  { head :ok }
    end
  end
  
private
  def load_system
      @pattern_system = PatternSystem.find_by_short_name(params[:id])
  end
end
