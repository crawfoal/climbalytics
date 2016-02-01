require_relative "../helpers/make_users.rb"

namespace :db do
  desc "Fill database with sample data"
  task :populate => :only_dev do
    Rake::Task['db:reset'].invoke

    # make users, as well as climb logs, seshes and related
    MakeUsers.make_users
  end
end
