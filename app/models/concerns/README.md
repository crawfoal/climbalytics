# Concerns

Model concerns are just modules that are to be included in some (or all) models. `ActiveSupport` now includes a small module called `Concern` that makes it super quick to write modules that have separate class and instance methods and that run a block of code when included in your models. To use this module, just place

```ruby
extend ActiveSupport::Concern
```

at the top of your module. [Put chubby models on a diet with concerns][1] gives a concise introduction to model concerns and [Concerning Yourself with ActiveSupport:Concern][2] goes more into how they work and why `ActiveSupport::Concern` was created.

Many of our concerns are included in `ActiveRecord::Base` so that they get added to all models (see `initializers/active_record_extensions.rb`). This is convenient, but some things don't work as well since the target class is not the actual model class. E.g. we can't use the `include` block to run code for the model the class (it would run for `ActiveRecord::Base`). I believe that Ruby's `Class` class has a callback for when a class is inherited by another - this might be a good alternative for that particular problem, but I haven't used it yet.

Some of our concerns don't extend `ActiveSupport::Concern` because it isn't really needed (e.g. the module only defines class methods).

## IndexInspector

### Public Methods
The following methods are extended into `ActiveRecord::Base`:

#### `index_exists?(column_name, options = {})`
Looks to see if there is an index defined. `column_name` can be either a single colun name, or an array of column names. [`options`][4] can be things like `unique: true`, or `name: "some_index_name"`.

##### Examples
```ruby
User.index_exists?(:email, unique: true)
```
```ruby
Address.index_exists?([:addressable_id, :addressable_type])
```

## KeyInspector
The main purpose of this module is to maintain a cached hash of the foreign key column names (the keys) and the name of their corresponding association. This allows us to quickly grab an [association reflection][3].

### Public Methods
The following methods are extended into `ActiveRecord::Base`:

#### `has_fk?(column_name)`
Returns true if the model has a foreign key column with the provided name, false otherwise.

##### Examples
```ruby
Address.has_fk?(:addressable_id)
```

#### `association_for(column_name)`
Returns the association reflection for the given column if it exists, otherwise returns nil.

##### Examples
```ruby
Address.association_for(:addressable_id)
```

## Randomable

### Public Methods
The following methods are extended into `ActiveRecord::Base`:

#### `random(total_count = nil)`
Grabs a random record for the model. If you know how many records there are for the model, you can pass it in, otherwise it will be looked up via a db query.

##### Examples
```ruby
User.random
```
```ruby
# if this is used, we should probably write a method for it
count = User.count
random_users = 3.times.collect { User.random(count) }
```

## StiChooseable

### Public Methods
The following methods are available when this concern is included in a model:

#### `sti_chooseable(base_class, *child_classes)`
For times when we have [STI][5] models where it only makes sense for the child models to belong to a particular model. In our application, this is the case with the `boulder` and `route` models - models that `have_one` climb (e.g. an `athlete_climb_log`) should have either a boulder or a route, not both.

##### Examples
```ruby
# athlete_climb_log.rb
extend StiChooseable
has_one :climb # define just one association since it is "one or the other" (as opposed to defining `has_one :boulder` *and* `has_one :route`)
sti_chooseable :climb, :boulder, :route # provide methods like `create_boulder`, `create_route`, etc.
```

## ValidateByReflection
Often times, the appropriate validations can be programmatically determined based on properties of the model and database. This module does that reflection and creates the validators.

### Public Methods
The following methods are extended into `ActiveRecord::Base`:

#### `generate_validations_for(*column_names)`
Inspects the database constraints, indices, associations, and the current set of validators for the model and generates appropriate validations for the given column names. Needs to be called after all custom validations have been defined (best to put it as the last line in your model class definition).

## ValidationInspector
This module inspects the column and reflection definitions and determines what validations should be generated.

### ValidationInspector::Column
The following methods are included in `ActiveRecord::ConnectionAdapters::Column`. In determining what validations should be generated, **they only consider the column's properties** - the caller of these methods should be checking stuff like what validators exists, etc.

`validate_length_args`, `validate_numericality_args`, `validate_presence_args`, and `validate_uniqueness_args` should maybe be moved to private methods.

#### `validate_length_args`
Returns the arguments for an appropriate length validation if

* the column defines a `limit` db constraint
* the column is a string type (default of 255 maximum)
* the column is a text type (default of 20,000 maximum - I haphazardly chose this; we should re-evaluate it and make it configurable)

#### `validate_numericality_args`
Returns the arguments for an appropriate numericality validation for integer, decimal, and float columns.

#### `validate_presence_args`
Returns the arguments for a presence validation if there is a null constraint for the column in the database.

#### `validate_uniqueness_args`
Always returns arguments for a uniqueness validation. This validation should be generated when a unique index exists, but the column doesn't know about the table's indices - the caller of `validation_args` needs to specify that a uniqueness constraint should / should not be generated depending on whether a unique index exists or not. I don't like this aspect of the design.

#### `validation_args(types_to_skip = [])`
Returns an array of the argument arrays needed to pass to `validates` in order to create length, numericality, presence, and uniqueness validations. It might look something like this:

```ruby
[[:email, length: {maximum: 255}], [:email, presence: true]]
```

### ValidationInspector::AssociationReflection
The following methods are included in `ActiveRecord::Reflection::AssociationReflection`. In determining what validations should be generated, **they only consider the reflection's properties** - the caller of these methods should be checking stuff like what validators exists, etc.

#### `validate_presence_args`
Returns the arguments for a presence validation for the association if the inverse of the association can be found (the only time it can't be found is for polymorphic associations).

#### `validate_uniqueness_args`
Returns the arguments for a uniqueness validation for the association. If the association is polymorphic, a scope using the type column will be applied.

#### `validation_args(types_to_skip = [])`
Returns an array of the argument arrays needed to pass to `validates` in order to create length, numericality, presence, and uniqueness validations for the association.

## ValidatorInspector

### Public Methods
The following methods are extended into `ActiveRecord::Base`:

#### `validators_for(column_name)`
Returns an array of validator objects that define validations for the given column name.

#### `validation_types_for(column_name)`
Returns an array of the validation types defined for the given column name.

[1]: https://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns
[2]: http://www.fakingfantastic.com/2010/09/20/concerning-yourself-with-active-support-concern/
[3]: http://www.rubydoc.info/docs/rails/3.0.0/ActiveRecord/Reflection/AssociationReflection
[4]: http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/index_exists%3F
[5]: http://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html
