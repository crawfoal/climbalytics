def count_rows_in_db(args = {})
  classes_to_exclude = args[:exclude] || []
  sum = 0
  ActiveRecord::Base.send(:subclasses).each do |subclass|
    sc_name = subclass.name
    sc_count = subclass.count
    unless sc_name.in? classes_to_exclude
      print_status_message "#{sc_name} class has #{sc_count} records in the db".light_red if sc_count > 0 and args[:verbose]
      sum += sc_count
    end
  end
  return sum
end
