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
    @system_formalism = SystemFormalism.find(params[:system_formalism_id])
    @pattern_formalism = PatternFormalism.new(params[:pattern_formalism])

    if @pattern_formalism.save
      flash[:notice] = "Successfully created a new pattern formalism."
      redirect_to [@system_formalism, @pattern_formalism]
    else
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
      render 'edit'
    end
  end
end
