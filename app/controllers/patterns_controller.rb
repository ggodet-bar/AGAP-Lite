# encoding: utf-8

class PatternsController < ApplicationController

  before_filter :find_pattern, :except => [:index, :new, :create, :tmp_images, :show_pattern_types, :create_relation, :upload_file]
  before_filter :load_system, :except => [:create_relation]
  
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
  
  def upload_file
    image_params = params[:mappable_image].merge({:pattern_system_id => @pattern_system.id})
    mappable_image = MappableImage.create image_params.merge({:is_temporary => true})
    field_id = params[:field_id]
    # Use javascript for setting the mappable_image_id in the
    # hidden fields of the image association, in the view
    responds_to_parent do 
      render :update do |page|
        page.replace_html 'mappable_image_' + field_id, <<EOF
<dl id=\"mappable_image_image_#{field_id}\" class=\"mappable_image\"  style=\"background: url(#{mappable_image.image.url}) no-repeat; height: #{mappable_image.image_height}px; width: #{mappable_image.image_width}px;\"></dl><script>AgapImageManager.install_image_observer($(\"mappable_image_image_#{field_id}\"), #{mappable_image.id})</script>
EOF
      end
    end
  end

  def index
    if params[:search]
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
    @interface_fields, @solution_fields = @process_pattern.field_instances
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @process_pattern }
    end
  end

  # GET /process_patterns/new
  # GET /process_patterns/new.xml
  def new
    @noob_mode = cookies[:noob_mode].blank? || cookies[:noob_mode] == 'true'
    # Create a new pattern based on the definition
    # provided by the formalism 
    @metamodel = @pattern_system.system_formalism
    pattern_type_id = params[:pattern_type] || @metamodel.pattern_formalisms.first.id
    # We suppose that there is only one pattern formalism
    @interface_fields, @solution_fields = @metamodel.pattern_formalisms.find(pattern_type_id).fields
    @process_pattern = @pattern_system.patterns.build(:pattern_formalism_id => pattern_type_id)
    @classifications = prepare_pattern_classifications(@metamodel.pattern_formalisms.find(pattern_type_id))
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @process_pattern }
    end
  end

  # GET /process_patterns/1/edit
  def edit
    @noob_mode = cookies[:noob_mode].blank? || cookies[:noob_mode] == 'true'
    @metamodel = @pattern_system.system_formalism
    @interface_fields, @solution_fields = @process_pattern.pattern_formalism.fields
    @classifications = prepare_pattern_classifications(@process_pattern.pattern_formalism)
  end

  # POST /process_patterns
  # POST /process_patterns.xml
  def create
    classification_selections = []
    unless params[:pattern][:classification_selections].blank?
      multi_classif_params = params[:pattern].delete(:classification_selections)
      multi_classif_params.values.collect{|a| a['classification_element_id']}.flatten.each do |classif_element_id|
        classification_selections << ClassificationSelection.new(:classification_element_id => classif_element_id)
      end
    end
    if params[:pattern][:mappable_images] && params[:pattern][:mappable_images][:image_file_name].blank?
      params[:pattern].delete(:mappable_images)
    end
    @process_pattern = @pattern_system.patterns.build params[:pattern]
    @process_pattern.classification_selections << classification_selections
    @interface_fields, @solution_fields = @process_pattern.pattern_formalism.fields
    respond_to do |format|
      if @process_pattern.save
        # If the update was successful, update all the mappable images of this process
        # pattern and make them non temporary
        @process_pattern.image_associations.each do |im|
          im.mappable_image.update_attribute(:is_temporary, false)
        end
        flash[:notice] = t(:successful_creation, :model => Pattern.model_name.human)
        format.html { redirect_to([@pattern_system, @process_pattern]) }
        format.xml  { render :xml => @process_pattern, :status => :created, :location => @process_pattern }
      else
        logger.debug @process_pattern.errors.full_messages
        @metamodel = @pattern_system.system_formalism
        @classifications = prepare_pattern_classifications(@process_pattern.pattern_formalism)
        format.html { render :action => "new" }
        format.xml  { render :xml => @process_pattern.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /process_patterns/1
  # PUT /process_patterns/1.xml
  def update
    @interface_fields, @solution_fields = @process_pattern.pattern_formalism.fields
    # Destroy existing multi classifications
    @process_pattern.classification_selections.select{|a| a.classification_element.field_descriptor.field_type == "multi_classification"}.map(&:destroy)
    
    unless params[:pattern][:classification_selections].blank?
      multi_classif_params = params[:pattern].delete(:classification_selections)
      multi_classif_params.values.collect{|a| a['classification_element_id']}.flatten.each do |classif_element_id|
        @process_pattern.classification_selections.build(:classification_element_id => classif_element_id)
      end
    end
    image_params = params[:pattern].delete(:mappable_images)
    image = @process_pattern.mappable_images.create image_params.merge({:pattern_system_id => @pattern_system.id}) \
      unless image_params.blank?
    respond_to do |format|
      if  @process_pattern.update_attributes(params[:pattern])
        # If the update was successful, update all the mappable images of this process
        # pattern and make them non temporary
        @process_pattern.image_associations.each do |im|
          im.mappable_image.update_attribute(:is_temporary, false)
        end
        flash[:notice] = t(:successful_update, :model => Pattern.model_name.human)
        format.html { redirect_to([@pattern_system, @process_pattern]) }
        format.xml  { head :ok }
      else
        logger.debug  @process_pattern.errors.full_messages
        flash[:error] = t(:failed_update, :model => Pattern.model_name.human) 
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

  def prepare_pattern_classifications(pattern_formalism)
    (pattern_formalism.field_descriptors + (pattern_formalism.system_formalism.field_descriptors || [])).select{|a| a.field_type.include?("classification")}.inject({}) do |acc, field|
      # For single classifications, we only generate a single field
      acc[field.id] = @process_pattern.classification_selections.select{|a| !a.classification_element.blank? && a.classification_element.field_descriptor_id == field.id}
      acc
    end
  end
end
