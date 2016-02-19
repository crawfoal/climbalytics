desc 'Raises expection if used for non-development database'
task non_prod: [:environment] do
  raise '!!! You cannot run this for a non-development database !!!' if Rails.env.production?
end
