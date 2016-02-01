module RandomRecord
  class << self
    def random_record(klass, record_count, nil_to_found_ratio = 0)
      record_id = Random.random(1, record_count*(nil_to_found_ratio + 1))
      klass.find(record_id) if record_id < record_count
    end
  end
end
