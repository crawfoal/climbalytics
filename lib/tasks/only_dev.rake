desc 'Raises expection if used for non-development database'
task only_dev: [:environment] do
  raise '!!! You cannot run this for a non-development database !!!' unless Rails.env.development?
end
