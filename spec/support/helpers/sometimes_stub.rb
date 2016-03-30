require "#{Rails.root}/lib/sometimes"
def Sometimes.sometimes(*args)
  if block_given?
    yield
  else
    true
  end
end
