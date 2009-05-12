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

    # puts @isEditing

    @participants_list = @pattern_system.participants
    @patterns_list = ProcessPattern.find_all_by_pattern_system_id(@pattern_system)
    unless @pattern_system.root_pattern.blank?
      @root_pattern = ProcessPattern.find(@pattern_system.root_pattern)
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
      @root_pattern = @pattern_system.root_pattern unless @pattern_system.root_pattern.blank?
      @noob_mode = cookies[:noob_mode] == 'true' ? true : false
  end

  # POST /pattern_systems
  # POST /pattern_systems.xml
  def create
    @pattern_system = PatternSystem.new(params[:pattern_system])
    @noob_mode = cookies[:noob_mode] == 'true' ? true : false
    
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
    params[:pattern_system][:root_pattern] = params[:pattern_system][:root_pattern].blank? ? nil : ProcessPattern.find(params[:pattern_system][:root_pattern])
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
  
  
  def clone
    respond_to do |wants|
      wants.html { render :partial => "clone_system_form", :locals => {:id => @pattern_system.short_name}}
    end
  end
  
  def create_cloned_system
    begin  
      @new_system = @pattern_system.clone_with(params[:name].blank? ? nil : params[:name], params[:short_name].blank? ? nil : params[:short_name], params[:author].blank? ? nil : params[:author])
    rescue RuntimeError
      flash[:error] = "Could not clone system. Please check if the name and/or short_name are unique."
    end
    respond_to do |wants|
      if !@new_system.nil? && @new_system.save
        flash[:notice] = "Pattern System was cloned."
        wants.js {
          render :update do |page|
                      page.insert_html :bottom, "pattern_systems_list", :partial => "pattern_system", :locals => {:pattern_system => @new_system}
                      page.replace_html "notices", flash[:notice]
                      page[:clone_form].hide
                    end
          }
      else
        wants.html {
            render :update do |page|
              page['notices'].setStyle(:color  => "#f00")
              page.replace_html "notices", flash[:error]
              page.replace_html "pattern_form_#{@pattern_system.short_name}", :partial => "clone_system_form"
              page[:clone_form].reset
            end
          }
       end
    end
  end
private
  def load_system
      @pattern_system = PatternSystem.find_by_short_name(params[:id])
  end
end
