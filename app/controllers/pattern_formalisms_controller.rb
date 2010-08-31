class PatternFormalismsController < ApplicationController
  layout 'system_formalisms'

  def show
    @pattern_formalism = PatternFormalism.find(params[:id])
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
end
