# Testing with RSpec

## Isolating Expensive and "Dangerous" Tests
Feature tests are well known to be much slower than other tests. Our data generators modify the factories, and we don't those changes to affect our tests. These are two examples of spec sets that we don't want to run when "all" specs run. To achieve this, we exclude them in our `.rspec` file:

```
--exclude-pattern "spec/{data_generators,features}/**/*_spec.rb"
```

Now, when rspec is run either via `rspec` or `rake spec`, specs in the `data_generators` and `features` folders will not run. We can run those specs separately by supplying a directory to the `rspec`, or via `rake spec:data_generators` and `rake spec:features` which are defined in `lib/tasks/test_suites.rake`.

We could have used tags for this, however this approach has two benefits. First, we don't need to tag every example group in those folders. Second, and more importantly, we don't need to modify our Guardfile. The Guardfile was already set to run specs with the command `bundle exec rspec`, and it specifies which specs to run by providing a path to the file or folder containing the specs that need to be run - which is one of the ways we can run our isolated spec groups.

## RSpec Configurations
The `rails_helper.rb` configuration file got too big, so I started breaking out configurations into separate files. They are in `spec/support/configurations`, and the helpers that you would normally find in `spec/support` are now in `spec/support/helpers`.
