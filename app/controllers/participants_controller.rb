class ParticipantsController < ApplicationController
  
  before_filter :load_system
  # before_filter :load_participant, :except => [:new, :create, ]
  
  # GET /pattern_systems/1/participants/new
  # GET /pattern_systems/1/participants/new.xml
  def new
    flash[:participant] = Participant.new
    respond_to do |format|
       format.html {redirect_to(@pattern_system)}
    end
  end
  
  def create
    @participant = Participant.new(params[:participant])
    respond_to do |format|
      if @participant.save
        @pattern_system.participants << @participant
        @pattern_system.save
        flash[:notice] = t(:successful_creation, :model => Participant.human_name)
        format.html { redirect_to(@pattern_system) }
  #      format.xml  { render :xml => @pattern_system, :status => :created, :location => @pattern_system }
      else
        format.html {
          flash[:participant] = @participant
          flash[:isEditing] = true
          redirect_to(@pattern_system)
        }
   #     format.xml  { render :xml => @pattern_system.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    # @pattern_system = PatternSystem.find(params[:pattern_system_id])
    flash[:participant] = Participant.find(params[:id])
    flash[:isEditing] = true
    respond_to do |format|
       format.html {redirect_to(@pattern_system)}
    end
  end
  
  def update
    # @pattern_system = PatternSystem.find(params[:pattern_system_id])
    @participant = Participant.find(params[:id])

    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        flash[:notice] = t(:successful_update, :model => Participant.human_name)
        format.html { redirect_to(@pattern_system) }
        format.xml  { head :ok }
      else
        format.html {
          flash[:participant] = @participant
          flash[:isEditing] = true
          redirect_to(@pattern_system)
        }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    # @pattern_system = PatternSystem.find(params[:pattern_system_id])
    @participant = Participant.find(params[:id])
    @participant.destroy
    
    respond_to do |format|
      flash[:notice] = t(:successful_delete, :model => Participant.human_name)
      format.html { redirect_to(@pattern_system) }
      format.xml  { head :ok }
    end
  end

private
  def load_system
    @pattern_system = PatternSystem.find_by_short_name(params[:pattern_system_id])
    
  end
end
