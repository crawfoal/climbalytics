module DevelopmentDatabaseSwitch

  def development_database
    branch_based_database("development")
  end

  def test_database
    branch_based_database("test")
  end

  protected
  def branch_based_database(base_name)
    # we only want to run git in dev/test modes
    master_db_name =  "db/#{base_name}.sqlite3"
    if git_branch_name
      branch_db = Rails.root.join("db/#{base_name}.#{git_branch_name}.sqlite3")
      FileUtils.cp Rails.root.join(master_db_name), branch_db unless branch_db.exist?
      branch_db.to_s
    else
      master_db_name
    end
  end

  def git_branch_name
    return unless Rails.env.development? || Rails.env.test?
    @_db_switch_branch_name ||= begin
      branch = `git branch --no-color`.match(/\* (\S+)\s/m)[1]
      branch != 'master' && branch != '(no' ? branch : nil
    end
  end
end
