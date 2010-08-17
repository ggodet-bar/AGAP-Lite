# encoding: utf-8

require 'tempfile'
require 'json'

class PatternSystemsController < ApplicationController

  before_filter :load_system, :except => [:new, :index, :create]
  before_filter :check_noob_mode

  # GET /pattern_systems
  # GET /pattern_systems.xml
  def index
    @pattern_systems = PatternSystem.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pattern_systems }
      format.js {render :json => @pattern_systems.inject([]){|result, element| result << {:name => element.name, :short_name => element.short_name}}.to_json}
    end
  end

  # GET /pattern_systems/show_metamodels
  def show_metamodels
    @pattern_system = PatternSystem.new
    @metamodels = SystemFormalism.all
    # And then render the action 
  end

  # GET /pattern_systems/1
  # GET /pattern_systems/1.xml
  def show
    @isEditing = flash[:isEditing]
    @patterns_list = @pattern_system.structured_pattern_list 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pattern_system }
    end
  end

  # GET /pattern_systems/new
  # GET /pattern_systems/new.xml
  def new
    @pattern_system = PatternSystem.new
    @metamodel = @pattern_system.system_formalism
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pattern_system }
    end
  end

  # GET /pattern_systems/1/edit
  def edit
    @common_classifications = @pattern_system.system_formalism.field_descriptors \
                                    .select{|f| f.field_type.include?('classification')}

    @classifications = @pattern_system.system_formalism.pattern_formalisms.collect do |p|
       p.field_descriptors.select{|f| f.field_type.include?('classification')}
    end.flatten

  end

  # POST /pattern_systems
  # POST /pattern_systems.xml
  def create
    @pattern_system = PatternSystem.new(params[:pattern_system])
    @metamodels = SystemFormalism.all
    
    # We compute a short name, based on the full name of the pattern
    begin
      @pattern_system.short_name = generate_short_name(params[:pattern_system][:name])
    rescue
      logger.info "Could not generate a short name for the pattern system"
    end
    
    respond_to do |format|
      if @pattern_system.save
        flash[:notice] = t(:successful_creation, :model => PatternSystem.model_name.human)
        format.html { redirect_to :action => 'edit', :id => @pattern_system.short_name, :from_create => true }
        format.xml  { render :xml => @pattern_system, :status => :created, :location => @pattern_system }
      else
        format.html { render :action => "show_metamodels" }
        format.xml  { render :xml => @pattern_system.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pattern_systems/1
  # PUT /pattern_systems/1.xml
  def update
    respond_to do |format|
      if @pattern_system.update_attributes(params[:pattern_system])
        flash[:notice] = t(:successful_update, :model => PatternSystem.model_name.human)
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
      flash[:notice] = t(:successful_delete, :model => PatternSystem.model_name.human)
      format.html { redirect_to(pattern_systems_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def clone
    respond_to do |wants|
      wants.html { render :partial => "clone_system_form", :locals => {:id => @pattern_system.short_name}}
    end
  end
  
  def deploy
    respond_to do |wants|
      wants.html { render :partial => "deploy_system_form", :locals => {:id => @pattern_system.short_name}}
    end
  end
  
  def do_deploy_system
    statify_thread = Thread.new {
      Crawler::statify(request.raw_host_with_port, @pattern_system.short_name, logger)
    }
    statify_thread.join
  end
  
  def create_cloned_system
    begin  
      @new_system = @pattern_system.clone_with(params[:name].blank? ? nil : params[:name], params[:short_name].blank? ? nil : params[:short_name], params[:author].blank? ? nil : params[:author])
    rescue RuntimeError
      flash[:error] = "Could not clone system. Please check if the name and/or short_name are unique."
    end
    respond_to do |wants|
      if !@new_system.nil? && !@new_system.new_record?
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
      @pattern_system = PatternSystem.where(:short_name => params[:id]).first
  end

  def check_noob_mode
      cookies[:noob_mode] ||= 'true'
      @noob_mode = cookies[:noob_mode] == 'true' ? true : false
  end
end
