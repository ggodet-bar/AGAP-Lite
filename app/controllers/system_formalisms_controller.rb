class SystemFormalismsController < ApplicationController

  def index
    @system_formalisms = SystemFormalism.all
  end

  def show
    @system_formalism = SystemFormalism.find(params[:id])
  end

  def new
    @system_formalism = SystemFormalism.new
    @relation_descriptors = prepare_associated_fields
  end

  def edit
    @system_formalism = SystemFormalism.find(params[:id])
    @system_interface_fields, @system_solution_fields = @system_formalism.field_descriptors.partition{|field| field.section == 'interface'}
    @relation_descriptors = prepare_associated_fields

    @pattern_formalism_fields = @system_formalism.pattern_formalisms.inject({}) do |acc, pattern_formalism|
      acc[pattern_formalism.name] = pattern_formalism.field_descriptors.partition{|field| field.section == 'interface'}
      acc
    end
  end

  def create
    @system_formalism = SystemFormalism.new(params[:system_formalism])
    respond_to do |format|
      if @system_formalism.save
        flash[:notice] = "Successfully created system formalism."
        format.html { redirect_to system_formalisms_path }
        format.xml  { render :xml => @system_formalism, :status => :created, :location => @system_formalism }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @system_formalism.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @system_formalism = SystemFormalism.find(params[:id])
    respond_to do |format|
      if @system_formalism.update_attributes(params[:system_formalism])
        flash[:notice] = "Successfully updated system formalism."
        format.html { redirect_to @system_formalism }
        format.xml  { head :ok }
      else
        format.html { render 'edit' }
        format.xml  { render :xml => @system_formalism.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @system_formalism = SystemFormalism.find(params[:id])
    @system_formalism.destroy
    respond_to do |format|
      flash[:notice] = "Successfully deleted system formalism."
      format.html {redirect_to(system_formalisms_path)}
      format.xml  {head :ok}
    end
  end

private
  def prepare_associated_fields
    pattern_formalism_fields = []
    @system_formalism.pattern_formalisms.each do |p|
      p.field_descriptors.each do |f|
        pattern_formalism_fields << ["#{p.name}:#{f.name}", f.id]
      end
    end
    system_formalism_fields = @system_formalism.field_descriptors.collect do |f|
        ["#{f.name}", f.id]
    end

    pattern_formalism_fields + system_formalism_fields
  end
end
