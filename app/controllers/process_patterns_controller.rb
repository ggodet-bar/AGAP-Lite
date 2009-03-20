class ProcessPatternsController < ApplicationController
  
  before_filter :find_pattern, :except => [:index, :new, :create, :add_participant, :remove_participant]  
  before_filter :load_system
  
  def choose_pattern
    render :inline  =>  "
    <ul>
    <% for pattern in @pattern_system.process_patterns %>
      <li><%= link_to_function pattern.name, alert(\'#{pattern.name}\') %></li>
    <% end %>
    </ul>
    "
    puts 'POUEEEET'
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
    @participants = @participants - Participant.find(params[:participant]).to_a
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
      format.html {redirect_to :controller  => 'pattern_systems'}
    end
  end

  # GET /process_patterns/1
  # GET /process_patterns/1.xml
  def show
    @image = MappableImage.find_by_process_pattern_id(params[:id])
    @participants = @process_pattern.participants
    @use_patterns = @process_pattern.use_patterns
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
    @participants = []
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
    @mappable_image = MappableImage.new(params[:mappable_image])
    
    if session[:participants].nil?
      @participants = []
    else
      @participants = Participant.find(session[:participants])
    end
    @selectable_participants = @pattern_system.participants - @participants
    @process_pattern.participants = @participants
    # unless @mappable_image[:uploaded_data].nil?
      @process_pattern.mappable_image = @mappable_image
    # end
    unless session[:pattern_system_id].nil?
        currentPatSystem = PatternSystem.find(session[:pattern_system_id])
        currentPatSystem.process_patterns << @process_pattern
    end
    respond_to do |format|
      if @process_pattern.save
        flash[:notice] = 'Process pattern was successfully created.'
        session[:participants] = nil
        format.html { redirect_to(@process_pattern) }
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
    respond_to do |format|
      proceedUpdate = true
      unless params[:mappable_image].nil?
        if @mappable_image.nil?
          @mappable_image = MappableImage.create(params[:mappable_image])
          puts "Creating image"
          puts params[:mappable_image]
        else 
          puts "Updating image"
          proceedUpdate = @mappable_image.update_attributes(params[:mappable_image])
        end
        @process_pattern.mappable_image = @mappable_image
      end
      
      if  proceedUpdate and @process_pattern.update_attributes(params[:process_pattern])
            flash[:notice] = 'Process pattern was successfully updated.'
            session[:participants] = nil
            format.html { redirect_to(@process_pattern) }
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
      format.html { redirect_to :controller  => "pattern_systems", :action => "show", :id  => session[:pattern_system_id] }
      format.xml  { head :ok }
    end
  end
  
private

  def find_pattern
    @process_pattern = ProcessPattern.find(params[:id])
  end

  def load_system
      @pattern_system = PatternSystem.find(session[:pattern_system_id])
      @patterns_list = ProcessPattern.find_all_by_pattern_system_id(session[:pattern_system_id])
  end
end
