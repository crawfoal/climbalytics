require 'shared_examples/http_response'

shared_examples_for 'a basic index request' do |records_method_name, instance_variable_name = nil|
  alias_method :records, records_method_name

  before :each do
    get :index
  end

  it 'populates an instance variable with a set of records' do
    expect(assigns(instance_variable_name || records_method_name)).to eq records
  end

  it_has 'a http response', {render: :index}
end
