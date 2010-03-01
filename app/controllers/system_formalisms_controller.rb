class SystemFormalismsController < ApplicationController

  def index
    @system_formalisms = SystemFormalism.all
  end
end
