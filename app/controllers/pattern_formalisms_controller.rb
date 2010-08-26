class PatternFormalismsController < ApplicationController
  layout 'system_formalisms'

  def show
    @pattern_formalism = PatternFormalism.find(params[:id])

  end
end
