# encoding: utf-8

class PatternsController < ApplicationController
  
  before_filter :find_pattern, :except => [:index, :new, :create, :tmp_images, :show_pattern_types]  
  before_filter :load_system
  

  def show_pattern_types
    content = <<EOF
<h2 style="width: auto; margin-left: 0em; padding-left: 0em; float: none;">Pick a pattern type</h2>
<ul>
<% @pattern_system.system_formalism.pattern_formalisms.each do |pat| %>
<li><%= link_to pat.name, new_pattern_system_pattern_path(@pattern_system, :pattern_type => pat.id) %></li>
<%- end %>
</ul>
EOF
    render :inline => content, :layout => true
  end
  
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
  
  def index
    if params[:search]
      puts @pattern_system.id
      @patterns = Pattern.search(params[:search], :with => { :pattern_system_id => @pattern_system.id })
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
    # We should be creating an array of fields
    interface_fields = @process_pattern.pattern_formalism.field_descriptors.select{|f| f.section == 'interface'}.sort_by{|a| a.index}
    # We get the first non nil instance that corresponds to the field id
    @interface_fields = interface_fields.collect do |field|
      @process_pattern.string_instances.select{|a| a.field_descriptor_id == field.id}.first ||
      @process_pattern.text_instances.select{|a| a.field_descriptor_id == field.id}.first 
    end

    solution_fields = @process_pattern.pattern_formalism.field_descriptors.select{|f| f.section == 'solution'}.sort_by{|a| a.index}
    # We get the first non nil instance that corresponds to the field id
    @solution_fields = solution_fields.collect do |field|
      @process_pattern.string_instances.select{|a| a.field_descriptor_id == field.id}.first ||
      @process_pattern.text_instances.select{|a| a.field_descriptor_id == field.id}.first 
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @process_pattern }
    end
  end

  # GET /process_patterns/new
  # GET /process_patterns/new.xml
  def new
    # Create a new pattern based on the definition
    # provided by the formalism 
    @metamodel = @pattern_system.system_formalism
    pattern_type_id = params[:pattern_type] || @metamodel.pattern_formalisms.first.id
    # We suppose that there is only one pattern formalism
    @interface_fields = @metamodel.pattern_formalisms.find(pattern_type_id).field_descriptors.select{|field| field.section == 'interface'}
    @solution_fields = @metamodel.pattern_formalisms.find(pattern_type_id).field_descriptors.select{|field| field.section == 'solution'}

    @process_pattern = Pattern.new(:pattern_formalism_id => pattern_type_id)
    session[:maps] = []
    #@participants = []
    #@selectable_participants = @pattern_system.participants
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
    @metamodel = @pattern_system.system_formalism
    @interface_fields = @process_pattern.pattern_formalism.field_descriptors.select{|field| field.section == 'interface'}
    @solution_fields = @process_pattern.pattern_formalism.field_descriptors.select{|field| field.section == 'solution'}
    @noob_mode = cookies[:noob_mode].blank? || cookies[:noob_mode] == 'true' ? true : false
  end

  # POST /process_patterns
  # POST /process_patterns.xml
  def create
    @process_pattern = Pattern.new(params[:pattern])
    unless params[:mappable_image].blank?
      @mappable_image = MappableImage.new(params[:mappable_image])
      @mappable_image.pattern_system = @pattern_system
      @mappable_image.save
      @process_pattern.mappable_image = @mappable_image
    end
    
    @pattern_system.patterns << @process_pattern
    respond_to do |format|
      if @process_pattern.save
        flash[:notice] = t(:successful_creation, :model => Pattern.human_name)
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
    #@process_pattern.participants = Participant.find(session[:participants])
    #@participants = @process_pattern.participants
    #@selectable_participants = @pattern_system.participants - @participants
    #@mappable_image = @process_pattern.mappable_image
    #unless session[:maps].blank?
    #  session[:maps].each {|map|
    #  @aMap = Map.new(map)
    #  @mappable_image.maps << @aMap
    #  }
    #  session[:maps] = nil
    #end
    
    respond_to do |format|
      proceedUpdate = @process_pattern.update_attributes(params[:pattern])
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
            flash[:notice] = t(:successful_update, :model => Pattern.human_name)
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
      flash[:notice] = t(:successful_delete, :model => Pattern.human_name)
      format.html { redirect_to @pattern_system}
      format.xml  { head :ok }
    end
  end
  
private

  def find_pattern
    @process_pattern = Pattern.find(params[:id])
  end

  def load_system
        @pattern_system = PatternSystem.find_by_short_name(params[:pattern_system_id])
        @patterns_list = Pattern.find_all_by_pattern_system_id(@pattern_system.id, :order => :name)
  end
end
