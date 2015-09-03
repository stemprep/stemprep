class Comment < ActiveRecord::Base
include ActionView::Helpers::DateHelper
  belongs_to :post
  belongs_to :user

  def generate_template
    "<tr class='row ind-comment-container'>\n
      <td width='100%' class='col-md-10 author-row'>\n
          #{time_ago_in_words(self.created_at)}  from #{self.user.username}\n
      </td>\n
      <td width='98%' class='col-md-12 comment-row'>#{self.body} </td>\n
    </tr>".html_safe
  end
end
