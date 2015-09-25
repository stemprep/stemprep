class DocumentsController < ApplicationController

  def index
    @user_documents = current_user.documents
    @is_uploading = true
    @uploader = current_user.documents.new.document
    @uploader.success_action_redirect = "https://morning-atoll-2439.herokuapp.com/users/#{current_user.id}/documents/new"
  end

  def new
    @doc_key = params[:key]
    render 'documents/index'
  end

  def show
  end

  def create
    new_doc = current_user.documents.new(document_params)
    if new_doc.save
      redirect_to user_documents_path
    end
  end

  def update

  end

  def destroy

  end

  private

  def document_params
    params.require(:document).permit(:user_id, :title, :amazon_url, :amazon_key)
  end


end