namespace :visits do
  desc "TODO"
  task reset: :environment do
    PageVisit.create!
  end

end
