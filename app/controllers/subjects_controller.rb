class SubjectsController < ApplicationController
  layout false

  def index
    @subjects=Subject.sorted
  end

  def show
    @subject=Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
  end

  def create
    #instantiate new object using form parameters
    @subject= Subject.new(subject_params)
    #save the object
    if @subject.save
      #if saved properly, return to index
      flash[:notice]="Subject created successfully"
      redirect_to(:action =>'index')
    else
      # else re-render form
      render('new')
    end
  end

  def edit
    @subject=Subject.find(params[:id])
  end

  def update
    #find existing object using form parameters
    @subject=Subject.find(params[:id])
    #update object
    if @subject.update_attributes(subject_params)
      #if saved properly, return to index
      flash[:notice]="Subject updated successfully"
      redirect_to(:action =>'show', :id=>@subject.id)
    else
      # else re-render form
      render('edit')
    end
  end

  def delete
    @subject=Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice]="Subject destroyed successfully"
    redirect_to({:action => 'index'})
  end
  private
    def subject_params
      # same as using "params[:subject]", but...
      # - raises error when no :subject provided
      # - allows listed attributes to be mass-assigned
      #   - otherwise by default none can be mass-assigned for security reasons
      params.require(:subject).permit(:name,:position,:visible)
    end

end
