class Object
  # Expand to accept a splat of parameters once I have an use case (and a test).
  # I considered indicating to the user whether the method was defined or not,
  # but decided not to because this method is intended to be for the case where
  # you don't need to do anything if the method isn't defined. If this isn't the
  # case, you probably should just use respond_to? in combination with send.
  def send_if_defined(method_name)
    self.send(method_name) if self.respond_to? method_name
  end
end
