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
  def index
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @entries = @user.entries
    else
      redirect_to login_path, notice: "Please log in to view your entries."
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @entry = @user.entries.build
    else
      redirect_to login_path, notice: "Please log in to create a new entry."
    end
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @entry = @user.entries.build(entry_params)
      if @entry.save
        redirect_to place_path(@entry.place), notice: 'Entry logged successfully!'
      else
        render :new
      end
    else
      redirect_to login_path, notice: "Please log in to create an entry."
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image)
  end
end

