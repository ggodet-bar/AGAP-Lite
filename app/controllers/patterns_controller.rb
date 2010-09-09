# encoding: utf-8

class PatternsController < ApplicationController

  before_filter :find_pattern, :except => [:index, :new, :create, :tmp_images, :show_pattern_types, :create_relation, :upload_file]
  before_filter :load_system, :except => [:create_relation]
  
  def create_relation
    @relation = Relation.new params[:relation]
    if @relation.save
      render :update do |page|
        page.call 'Popup.close', 'pattern_selector'
        page.call 'AgapImageManager.validate_map', @relation.id, @relation.relation_descriptor.color_code
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
    @relation_descriptors = @process_pattern.pattern_formalism.system_formalism.relation_descriptors
    @field_relations = @relation_descriptors.inject({}) do |acc, relation_descriptor|
      if relation_descriptor.associated_field_id.present?
        associated_patterns = @process_pattern.relations.select{|r| r.relation_descriptor.associated_field_id == \
                                                                    relation_descriptor.associated_field_id} \
                                                        .collect{|r| r.target_pattern}

        acc[relation_descriptor.associated_field_id] = {:relation_descriptor => relation_descriptor, :patterns => associated_patterns}
      end
      acc
    end
    @relations = @relation_descriptors.inject({}) do |acc,relation_descriptor|
      associated_patterns = @process_pattern.relations.select{|r| r.relation_descriptor == relation_descriptor} \
                                                      .collect{|r| r.target_pattern}
      acc[relation_descriptor.name] = associated_patterns
      acc
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @process_pattern }
    end
  end

  # GET /process_patterns/new
  # GET /process_patterns/new.xml
  def new
    @noob_mode = cookies[:noob_mode].blank? || cookies[:noob_mode] == 'true'
    @metamodel = @pattern_system.system_formalism
    pattern_type_id = params[:pattern_type] || @metamodel.pattern_formalisms.first.id
    @interface_fields, @solution_fields = @metamodel.pattern_formalisms.find(pattern_type_id).fields
    @process_pattern = @pattern_system.patterns.build(:pattern_formalism_id => pattern_type_id)
    @classifications = prepare_pattern_classifications(@metamodel.pattern_formalisms.find(pattern_type_id))
    @relations = @metamodel.relation_descriptors.inject({}) do |acc, relation_descriptor|
      acc[relation_descriptor.id] = {
        :available => @pattern_system.patterns.select{|p| p != @process_pattern},
        :selected =>  []
      }
      acc
    end
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
    @relations = @metamodel.relation_descriptors.inject({}) do |acc, relation_descriptor|
      selected_relations = @process_pattern.relations.select{|r| r.relation_descriptor == relation_descriptor}
      acc[relation_descriptor.id] = {
        :available => @pattern_system.patterns.select{|p| p != @process_pattern},
        :selected =>  selected_relations
      }
      acc
    end
  end

  # POST /process_patterns
  # POST /process_patterns.xml
  def create
    if params[:pattern][:mappable_images] && params[:pattern][:mappable_images][:image_file_name].blank?
      params[:pattern].delete(:mappable_images)
    end
    @process_pattern = @pattern_system.patterns.build params[:pattern]
    @interface_fields, @solution_fields = @process_pattern.pattern_formalism.fields
    respond_to do |format|
      if @process_pattern.save
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

    image_params = params[:pattern].delete(:mappable_images)
    image = @process_pattern.mappable_images.create image_params.merge({:pattern_system_id => @pattern_system.id}) \
      unless image_params.blank?
    respond_to do |format|
      if  @process_pattern.update_attributes(params[:pattern])
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
      acc[field.id] = @process_pattern.classification_selections.select{|a| !a.classification_element.blank? && a.classification_element.field_descriptor_id == field.id}
      acc
    end
  end
end
