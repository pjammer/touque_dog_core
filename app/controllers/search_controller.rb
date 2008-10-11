class SearchController < ApplicationController
  def index
  end
  
  def search
    per_page = 10
    @results = ActsAsFerret.find(params[:q], 'tdcoredex', :page => params[:page], :per_page => per_page)
  end
end
