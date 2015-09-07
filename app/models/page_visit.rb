class PageVisit < ActiveRecord::Base


  def update_view_count
    new_count = self.view_count + 1
    self.update_columns(view_count: new_count)
  end

  def update_registration_count
    new_count = self.new_user_count + 1
    self.update_columns(new_user_count: new_count)
  end

  def update_all
    update_registration_count
    update_view_count
  end
end
