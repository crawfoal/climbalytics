# only for one-to-one relationships right now

# assumes the default class name, table name, polymorphic type set up (I think...)

# this is tested in athlete_climb_log_spec, but the tests are coupled to my application.

module StiChooseable

  def sti_chooseable(base_class, *child_classes)
    child_classes.each do |class_name|
      type = class_name.to_s.capitalize
      klass = type.classify.constantize

      define_method class_name do
        record = self.send(base_class)
        record if record.type == type
      end

      define_method "#{class_name}=" do |record|
        self.send("#{base_class}=", record)
      end

      define_method "build_#{class_name}" do |attributes|
        self.send("#{base_class}=", klass.new(attributes))
      end

      define_method "create_#{class_name}" do |attributes|
        self.send("#{base_class}=", klass.create(attributes))
      end

      define_method "create_#{class_name}!" do |attributes|
        self.send("#{base_class}=", klass.create!(attributes))
      end
    end
  end
end
