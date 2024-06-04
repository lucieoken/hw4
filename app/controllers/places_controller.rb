class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def show
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @user["id"] })
    else
      redirect_to login_path, notice: "Please log in to view this place."
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @place = Place.new
    else
      redirect_to login_path, notice: "Please log in to add a new place."
    end
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @place = Place.new
      @place["name"] = params["name"]
      if @place.save
        redirect_to "/places", notice: "Place created successfully."
      else
        render :new
      end
    else
      redirect_to login_path, notice: "Please log in to create a place."
    end
  end
end

