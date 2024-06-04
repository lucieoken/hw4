# class EntriesController < ApplicationController

#   def new
#   end

#   def create
#     @entry = Entry.new
#     @entry["title"] = params["title"]
#     @entry["description"] = params["description"]
#     @entry["occurred_on"] = params["occurred_on"]
#     @entry["place_id"] = params["place_id"]
#     @entry.save
#     redirect_to "/places/#{@entry["place_id"]}"
#   end

# end

class EntriesController < ApplicationController
  before_action :require_user

  def index
    @entries = @current_user.entries
  end

  def new
    @entry = @current_user.entries.build
  end

  def create
    @entry = @current_user.entries.build(entry_params)
    if @entry.save
      redirect_to place_path(@entry.place), notice: 'Entry created successfully.'
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image)
  end
end

