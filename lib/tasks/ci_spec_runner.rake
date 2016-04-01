desc 'Groups all of the reporting and spec tasks that run on a CI environment.'
task ci_spec_runner: [
  :spec,
  'spec:tasks',
  'spec:features',
  'codeclimate:format',
  'coveralls:push'
]
