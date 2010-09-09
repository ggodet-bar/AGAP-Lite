class PatternFormalismsController < ApplicationController
  layout 'system_formalisms'

  def show
    @pattern_formalism = PatternFormalism.find(params[:id])
    @system_formalism = @pattern_formalism.system_formalism
    @interface_fields, @solution_fields = @pattern_formalism.field_descriptors.partition{|field| field.section == 'interface'}
  end

  def edit
    @pattern_formalism = PatternFormalism.find(params[:id])
    @system_formalism = @pattern_formalism.system_formalism
    @interface_fields, @solution_fields = @pattern_formalism.field_descriptors.partition{|field| field.section == 'interface'}
  end

  def new
    @system_formalism = SystemFormalism.find(params[:system_formalism_id])
    @pattern_formalism = @system_formalism.pattern_formalisms.build
    @interface_fields, @solution_fields = @pattern_formalism.field_descriptors.partition{|field| field.section == 'interface'}
  end

  def create
    @pattern_formalism = PatternFormalism.new(params[:pattern_formalism])
    @system_formalism = @pattern_formalism.system_formalism

    if @pattern_formalism.save
      flash[:notice] = "Successfully created a new pattern formalism."
      redirect_to [@system_formalism, @pattern_formalism]
    else
      @interface_fields, @solution_fields = @pattern_formalism.field_descriptors.partition{|field| field.section == 'interface'}
      render 'edit'
    end
  end

  def update
    @pattern_formalism = PatternFormalism.find(params[:id])
    @system_formalism = @pattern_formalism.system_formalism
    if @pattern_formalism.update_attributes(params[:pattern_formalism])
      flash[:notice] = "Successfully updated pattern formalism."
      redirect_to [@system_formalism, @pattern_formalism]
    else
      @interface_fields, @solution_fields = @pattern_formalism.field_descriptors.partition{|field| field.section == 'interface'}
      render 'edit'
    end
  end

  def destroy
    @pattern_formalism = PatternFormalism.find(params[:id])
    @system_formalism = @pattern_formalism.system_formalism
    @pattern_formalism.destroy

    flash[:notice] = t(:successful_delete, :model => PatternFormalism.model_name.human)
    redirect_to @system_formalism
  end
end
