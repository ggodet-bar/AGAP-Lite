# encoding: utf-8

class ProcessPatternsController < ApplicationController
  
  before_filter :find_pattern, :except => [:index, :new, :create, :add_participant, :remove_participant, :tmp_images, :display_parameters]  
  before_filter :load_system
  

  
  # GET /process_patterns/tmp_images
  def tmp_images
    @images = MappableImage.all.select{|image| 
      image.pattern_system.short_name == @pattern_system.short_name}
    render :update do |page|
      page.replace_html :form_content, :partial => "image_form", :locals => {:id => params[:id]}
    end
  end
  
  def tmp_upload
    puts 'tmp_upload called'
    @image = MappableImage.new(params[:image])
    @image.pattern_system = @pattern_system
    if @image.save
      responds_to_parent do
        render :update do |page|
          page << 'UpImage.insert_image(\'' + @image.public_filename + '\');'
        end
      end
    else
      logger.error "Error while attempting to save image #{@image.filename} inside the pattern system #{@pattern_system.short_name}."
    end
  end
  
  
  # TODO Passer un Hash (vérifier compatibilité Rails/Prototype) des patterns disponibles directement
  # (on économise ainsi une requête au serveur) 
  def choose_pattern
    respond_to do |format|
      format.html {
        render :partial  => 'possible_patterns', :locals => {:x => params[:x], :y => params[:y], :w => params[:w], :h => params[:h]}
      }
    end
  end
  
  def save_map
    respond_to do |wants|
      wants.js {
        render :update do |page|
          session[:maps] << {:target_pattern_id  => params[:target_pattern_id], :x_corner => params[:x], :y_corner => params[:y], :width => params[:w], :height => params[:h]}
        end
      }
    end
  end
  
  def add_participant
    @participants = Participant.find(session[:participants])
    @participants << Participant.find(params[:participant])
    session[:participants] = @participants.collect{|part| part.id}
    @selectable_participants = @pattern_system.participants - @participants
    respond_to do |format|
        format.html {
            render :partial  => 'participants'
          }
    end
  end
  
  def remove_participant
    @participants = Participant.find(session[:participants])
    @participants = @participants - Array(Participant.find(params[:participant]))
    @selectable_participants = @pattern_system.participants - @participants
    session[:participants] = @participants
    respond_to do |format|
        format.html {
            render :partial  => 'participants'
          }
    end
  end
  
  def index
    if params[:search]
      puts @pattern_system.id
      @patterns = ProcessPattern.search(params[:search], :with => { :pattern_system_id => @pattern_system.id })
      respond_to do |wants|
        wants.html
      end
    else
      respond_to do |format|
        format.html {redirect_to @pattern_system}
      end
    end
  end

  # GET /process_patterns/1
  # GET /process_patterns/1.xml
  def show
    @image = @process_pattern.mappable_image
    @participants = @process_pattern.participants
    @use_patterns = @process_pattern.use_patterns
    if @image
      @maps = @image.maps
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @process_pattern }
    end
  end

  # GET /process_patterns/new
  # GET /process_patterns/new.xml
  def new
    @process_pattern = ProcessPattern.new
    session[:participants] = []
    session[:maps] = []
    @participants = []
    @selectable_participants = @pattern_system.participants
    unless params[:id].nil?
      session[:pattern_system_id] = params[:id]
    end
    @noob_mode = cookies[:noob_mode].blank? || cookies[:noob_mode] == 'true' ? true : false
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @process_pattern }
    end
  end

  # GET /process_patterns/1/edit
  def edit
    session[:participants] = @process_pattern.participants.collect{|part| part.id}
    @participants = @process_pattern.participants
    @context_patterns = @process_pattern.context_patterns.collect{|context| context.id}
    @use_patterns = @process_pattern.use_patterns.collect{|use| use.id}
    if @participants.nil?
       @participants = []
    end
    session[:maps] = []
    @selectable_participants = @pattern_system.participants - @participants
    @noob_mode = cookies[:noob_mode].blank? || cookies[:noob_mode] == 'true' ? true : false
  end

  # POST /process_patterns
  # POST /process_patterns.xml
  def create
    context_patterns = params[:process_pattern][:context_patterns]
    params[:process_pattern][:context_patterns] = []
    unless context_patterns.blank? || (context_patterns.size == 1 && context_patterns[0].include?(?[))
      context_patterns.each{ |pattern_id|
        params[:process_pattern][:context_patterns] << ProcessPattern.find(pattern_id) unless pattern_id.split.empty?
      }      
    end
    
    use_patterns = params[:process_pattern][:use_patterns]
    params[:process_pattern][:use_patterns] = []
    unless use_patterns.blank? || (use_patterns.size == 1 && use_patterns[0].include?(?[))
      use_patterns.each{ |pattern_id|
        params[:process_pattern][:use_patterns] << ProcessPattern.find(pattern_id) unless pattern_id.split.empty?
      }      
    end
    @process_pattern = ProcessPattern.new(params[:process_pattern])
    unless params[:mappable_image].blank?
      @mappable_image = MappableImage.new(params[:mappable_image])
      @mappable_image.pattern_system = @pattern_system
      @mappable_image.save
      @process_pattern.mappable_image = @mappable_image
    end
    
    if session[:participants].blank?
      @participants = []
    else
      @participants = Participant.find(session[:participants])
    end
    @selectable_participants = @pattern_system.participants - @participants
    @process_pattern.participants = @participants
    
    @pattern_system.process_patterns << @process_pattern
    respond_to do |format|
      # puts @participants.errors.full_messages
      if @process_pattern.save
        flash[:notice] = t(:successful_creation, :model => ProcessPattern.human_name)
        session[:participants] = nil
        format.html { redirect_to([@pattern_system, @process_pattern]) }
        format.xml  { render :xml => @process_pattern, :status => :created, :location => @process_pattern }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @process_pattern.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /process_patterns/1
  # PUT /process_patterns/1.xml
  def update
    @process_pattern.participants = Participant.find(session[:participants])
    @participants = @process_pattern.participants
    @selectable_participants = @pattern_system.participants - @participants
    @mappable_image = @process_pattern.mappable_image
    unless session[:maps].blank?
      session[:maps].each {|map|
      @aMap = Map.new(map)
      @mappable_image.maps << @aMap
      }
      session[:maps] = nil
    end
    
    # TODO Utiliser les mécanismes d'injection!
    context_patterns = params[:process_pattern][:context_patterns]
    params[:process_pattern][:context_patterns] = []
    unless context_patterns.blank? || (context_patterns.size == 1 && context_patterns[0].include?(?[))
      context_patterns.each{ |pattern_id|
        params[:process_pattern][:context_patterns] << ProcessPattern.find(pattern_id) unless pattern_id.split.empty?
      }      
    end
    
    use_patterns = params[:process_pattern][:use_patterns]
    params[:process_pattern][:use_patterns] = []
    unless use_patterns.blank? || (use_patterns.size == 1 && use_patterns[0].include?(?[))
      use_patterns.each{ |pattern_id|
        params[:process_pattern][:use_patterns] << ProcessPattern.find(pattern_id) unless pattern_id.split.empty?
      }      
    end

    respond_to do |format|
      proceedUpdate = @process_pattern.update_attributes(params[:process_pattern])
      unless params[:mappable_image].blank? || params[:mappable_image][:uploaded_data].blank?
        if @mappable_image.blank?
          @mappable_image = MappableImage.new(params[:mappable_image])
          @mappable_image.pattern_system = @pattern_system
          proceedUpdate &= @mappable_image.save
        else 
          logger.info 'Updating image (and maps !)'
          proceedUpdate &= @mappable_image.update_attributes(params[:mappable_image])
        end
        
        unless @mappable_image.blank?
          @process_pattern.mappable_image = @mappable_image
          @pattern_system.mappable_images << @mappable_image
          proceedUpdate &= @pattern_system.save
        end
        
      end
      
      if  proceedUpdate
            flash[:notice] = t(:successful_update, :model => ProcessPattern.human_name)
            session[:participants] = nil
            format.html { redirect_to([@pattern_system, @process_pattern]) }
            format.xml  { head :ok }
      else
        puts @mappable_image.errors.full_messages
        format.html { render :action => "edit" }
        format.xml  { render :xml => @process_pattern.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /process_patterns/1
  # DELETE /process_patterns/1.xml
  def destroy
    @process_pattern.destroy

    respond_to do |format|
      flash[:notice] = t(:successful_delete, :model => ProcessPattern.human_name)
      format.html { redirect_to @pattern_system}
      format.xml  { head :ok }
    end
  end
  
private

  def find_pattern
    @process_pattern = ProcessPattern.find(params[:id])
  end

  def load_system
        @pattern_system = PatternSystem.find_by_short_name(params[:pattern_system_id])
        @patterns_list = ProcessPattern.find_all_by_pattern_system_id(@pattern_system.id, :order => :name)
  end
end
