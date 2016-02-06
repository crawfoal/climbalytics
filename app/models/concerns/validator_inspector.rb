module ValidatorInspector
  def validator_digest
    validator_digest = {length: [],
                        numericality: [],
                        presence: [],
                        uniqueness: []}
    validators.each do |validator|
      validator_digest[validator.kind] += validator.attributes if validator_digest.keys.include? validator.kind
    end
    return validator_digest
  end
end
