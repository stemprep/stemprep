class DocumentsController < ApplicationController

  def index
    # @user_documents = current_user.documents
    session[:user_id] = 1;
    @document = current_user.documents.new
    @errors
    render 'users/documents'
  end

  def show

  end

  def create
    require 'pry'
    binding.pry

  end

  def update

  end

  def destroy

  end

end