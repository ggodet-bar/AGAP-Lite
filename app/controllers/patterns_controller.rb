# encoding: utf-8

class PatternsController < ApplicationController
  
  before_filter :find_pattern, :except => [:index, :new, :create, :tmp_images, :show_pattern_types, :create_relation]
  before_filter :load_system
  
  def create_relation
    puts params
    @relation = Relation.new params[:relation]
    if @relation.save
      render :update do |page|
        page.call 'Popup.close', 'pattern_selector'
        page.call 'AgapImageManager.validate_map', @relation.id
      end
    end
  end

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
  
  def upload_file
    image_params = params[:mappable_image].merge({:pattern_system_id => @pattern_system.id})
    mappable_image = MappableImage.create image_params
    @process_pattern.mappable_images << mappable_image
    
    responds_to_parent do 
      render :update do |page|
        page.replace_html 'mappable_image_' + mappable_image.field_descriptor_id.to_s, <<EOF
<dl id=\"mappable_image_image_#{mappable_image.field_descriptor_id}\" class=\"mappable_image\"  style=\"background: url(#{mappable_image.image.url}) no-repeat; height: #{mappable_image.image_height}px; width: #{mappable_image.image_width}px;\"></dl><script>AgapImageManager.install_image_observer($(\"mappable_image_image_#{mappable_image.field_descriptor_id}\"))</script>
EOF

      end
    end
#    render :inline => "<%= image_tag(mappable_image.image.path) %>", :locals => {:mappable_image => mappable_image}
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
    interface_fields, solution_fields = @process_pattern.pattern_formalism.field_descriptors.partition{|f| f.section == 'interface'}.collect{|a| a.sort_by{|b| b.index}}
    # We get the first non nil instance that corresponds to the field id
    
    muster = lambda do |field| 
      @process_pattern.string_instances.select{|a| a.field_descriptor_id == field.id}.first ||
      @process_pattern.text_instances.select{|a| a.field_descriptor_id == field.id}.first  ||
      @process_pattern.mappable_images.select{|a| a.field_descriptor_id == field.id}.first ||
      @process_pattern.classification_selections.select{|a| !a.classification_element.blank? && a.classification_element.field_descriptor_id == field.id} 
    end

    @interface_fields, @solution_fields = [interface_fields, solution_fields].map{|f| f.map(&muster)}
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

    @process_pattern = @pattern_system.patterns.build(:pattern_formalism_id => pattern_type_id)

    # We prepare both the existing classification elements as well as blank selections
    @classifications = @metamodel.pattern_formalisms.find(pattern_type_id).field_descriptors.select{|a| a.field_type.include?("classification")}.inject({}) do |acc, field|
      # For single classifications, we only generate a single field
      acc[field.id] = [] << @process_pattern.classification_selections.build # if field.field_type == 'classification'
      acc
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
    @classifications = @process_pattern.pattern_formalism.field_descriptors.select{|a| a.field_type.include?("classification")}.inject({}) do |acc, field|
      # For single classifications, we only generate a single field
      acc[field.id] = @process_pattern.classification_selections.select{|a| !a.classification_element.blank? && a.classification_element.field_descriptor_id == field.id} 
      acc[field.id] = [@process_pattern.classification_selections.build] if acc[field.id].blank?
      acc
    end
  end

  # POST /process_patterns
  # POST /process_patterns.xml
  def create
    multis = []
    unless params[:pattern][:multi_classification_selections].blank?
      multis = params[:pattern].delete(:multi_classification_selections) #.each do |m|
    end
    if params[:pattern][:mappable_images] && params[:pattern][:mappable_images][:image_file_name].blank?
      params[:pattern].delete(:mappable_images)
    end
    @process_pattern = @pattern_system.patterns.build params[:pattern]
    @interface_fields = @process_pattern.pattern_formalism.field_descriptors.select{|field| field.section == 'interface'}
    @solution_fields = @process_pattern.pattern_formalism.field_descriptors.select{|field| field.section == 'solution'}
      # We delete all the selections that are relative to the field_id
    multis.each do |k, v| 
      @process_pattern.classification_selections.select{|a| !a.classification_element.blank? && a.classification_element.field_descriptor_id == k.to_i}.map(&:destroy)
      v.each do |val|
        @process_pattern.classification_selections.build(:classification_element_id => val.to_i)
      end
    end
    respond_to do |format|
      if @process_pattern.save
        flash[:notice] = t(:successful_creation, :model => Pattern.human_name)
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
    @metamodel = @pattern_system.system_formalism
    @interface_fields = @process_pattern.pattern_formalism.field_descriptors.select{|field| field.section == 'interface'}
    @solution_fields = @process_pattern.pattern_formalism.field_descriptors.select{|field| field.section == 'solution'}
    @noob_mode = cookies[:noob_mode].blank? || cookies[:noob_mode] == 'true' ? true : false
    unless params[:pattern][:multi_classification_selections].blank?
      multis = params[:pattern].delete(:multi_classification_selections) #.each do |m|
        # We delete all the selections that are relative to the field_id
      multis.each do |k, v| 
        @process_pattern.classification_selections.select{|a| !a.classification_element.blank? && a.classification_element.field_descriptor_id == k.to_i}.map(&:destroy)
        v.each do |val|
          @process_pattern.classification_selections.create(:classification_element_id => val.to_i)
        end
      end
    end
    image_params = params[:pattern].delete(:mappable_images)
    puts image_params
    image = @process_pattern.mappable_images.create image_params.merge({:pattern_system_id => @pattern_system.id}) \
      unless image_params.blank?
    respond_to do |format|
      if  @process_pattern.update_attributes(params[:pattern])
        flash[:notice] = t(:successful_update, :model => Pattern.human_name)
        format.html { redirect_to([@pattern_system, @process_pattern]) }
        format.xml  { head :ok }
      else
        flash[:error] = t(:failed_update, :model => Pattern.human_name) 
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
