def sometimes(*args)
  if block_given?
    yield
  else
    true
  end
end
