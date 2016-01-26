require 'shared_examples/http_response'

shared_examples_for 'a basic edit request' do |record_method_name, instance_variable_name = nil|
  alias_method :record, record_method_name
  instance_variable_name ||= record_method_name
  before :each do
    get :edit, id: record.id
  end

  it 'assigns the record to the instance variable' do
    expect(assigns(instance_variable_name)).to eq record
  end

  it_has 'a http response', {render: :edit}
end
