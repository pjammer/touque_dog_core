class SearchController < ApplicationController
  def index
  end
  
  def search
    @results = ActsAsFerret.find(params[:q], 'comeonworkjerk')
  end
end
