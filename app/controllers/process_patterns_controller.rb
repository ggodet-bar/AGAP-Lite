class ProcessPatternsController < ApplicationController
  
  before_filter :find_pattern, :except => [:index, :new, :create, :add_participant, :remove_participant, :tmp_images]  
  before_filter :load_system
  
  # GET /process_patterns/tmp_images
  def tmp_images
    puts 'tmp_images called'
    @images = MappableImage.all.select{|image| image.process_pattern.pattern_system.short_name == @pattern_system.short_name}
    @images.each do |image|
      puts image.public_filename
    end
    render :update do |page|
      # page << "var pat_system_id = '#{@pattern_system.short_name}';"
      page.replace_html :form_content, :partial => "image_form", :locals => {:images => @images}
    end
  end
  
  def tmp_upload
    puts 'tmp_upload called'
    puts params[:image]
    puts @pattern_system.short_name
    @image = MappableImage.new(params[:image])
    
    # TODO  On doit trouver un moyen de "raccrocher" TEMPORAIREMENT l'image à son process_pattern
    # (éventuellement en modifiant le lien PatternSystem>ProcessPattern>MappableImage en PatternSystem>MappableImage)
    
    puts @image.process_pattern
    puts @image.public_filename
    if @image.save
      puts 'Save successful'
    else
      puts 'You SUCK!'
    end
    responds_to_parent do
      render :update do |page|
        page << 'ExampleDialog.insert_image(\'' + @image.public_filename + '\');'
      end
      # format.js { puts 'successful render'}
      
    end
  end
  
  def choose_pattern
    respond_to do |format|
      format.html {
        render :partial  => 'possible_patterns', :locals => {:x => params[:x], :y => params[:y], :w => params[:w], :h => params[:h]}
      }
    end
  end
  
  def save_map
    # puts params[:pattern_id]
    session[:maps] << {:pattern_id  => params[:pattern_id], :x_corner => params[:x], :y_corner => params[:y], :width => params[:w], :height => params[:h]}
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
  
  # GET /process_patterns
  # GET /process_patterns.xml
  # def index
  #   unless params[:id].nil?
  #     session[:pattern_system_id] = params[:id]
  #   end
  #   @process_patterns = ProcessPattern.find_all_by_pattern_system_id(session[:pattern_system_id])
  #   @pattern_system_name = @pattern_system.name
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @process_patterns }
  #   end
  # end
  
  def index
    respond_to do |format|
      format.html {redirect_to @pattern_system}
    end
  end

  # GET /process_patterns/1
  # GET /process_patterns/1.xml
  def show
    @image = MappableImage.find_by_process_pattern_id(params[:id])
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
    # @selectable_participants = @pattern_system.participants ? @pattern_system.participants : []
    @selectable_participants = @pattern_system.participants
    unless params[:id].nil?
      session[:pattern_system_id] = params[:id]
    end
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
  end

  # POST /process_patterns
  # POST /process_patterns.xml
  def create
    if params[:process_pattern][:context_patterns].nil? or params[:process_pattern][:context_patterns] == [""]
      params[:process_pattern][:context_patterns] = []
    else
      params[:process_pattern][:context_patterns] = ProcessPattern.find(params[:process_pattern][:context_patterns])
    end
    if params[:process_pattern][:use_patterns].nil? or params[:process_pattern][:use_patterns] == [""]
      params[:process_pattern][:use_patterns] = []
    else
      params[:process_pattern][:use_patterns] = ProcessPattern.find(params[:process_pattern][:use_patterns])
    end
    @process_pattern = ProcessPattern.new(params[:process_pattern])
    if params[:mappable_image]
      @mappable_image = MappableImage.new(params[:mappable_image])
      @process_pattern.mappable_image = @mappable_image
    end
    
    if session[:participants].nil?
      @participants = []
    else
      @participants = Participant.find(session[:participants])
    end
    @selectable_participants = @pattern_system.participants - @participants
    @process_pattern.participants = @participants
    
    @pattern_system.process_patterns << @process_pattern
    respond_to do |format|
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
    
    unless session[:maps].nil?
      session[:maps].each {|map|
      puts map
      @aMap = Map.new(map)
      @mappable_image.maps << @aMap
      }
    end
    if params[:process_pattern][:context_patterns].blank? or params[:process_pattern][:context_patterns] == [""]
      params[:process_pattern][:context_patterns] = []
    else
      params[:process_pattern][:context_patterns] = ProcessPattern.find(params[:process_pattern][:context_patterns])
    end
    if params[:process_pattern][:use_patterns].blank? or params[:process_pattern][:use_patterns] == [""]
      params[:process_pattern][:use_patterns] = []
    else
      params[:process_pattern][:use_patterns] = ProcessPattern.find(params[:process_pattern][:use_patterns])
    end
    respond_to do |format|
      proceedUpdate = true
      unless params[:mappable_image].blank?
        if @mappable_image.nil?
          @mappable_image = MappableImage.create(params[:mappable_image])
          puts params[:mappable_image]
        else 
          puts 'Updating image (and maps !)'
          proceedUpdate = @mappable_image.update_attributes(params[:mappable_image])
        end
        
        
        @process_pattern.mappable_image = @mappable_image
      end
      
      if  proceedUpdate and @process_pattern.update_attributes(params[:process_pattern])
            flash[:notice] = t(:successful_update, :model => ProcessPattern.human_name)
            session[:participants] = nil
            format.html { redirect_to([@pattern_system, @process_pattern]) }
            format.xml  { head :ok }
      else
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
        @patterns_list = ProcessPattern.find_all_by_pattern_system_id(params[:pattern_system_id])
  end
end
