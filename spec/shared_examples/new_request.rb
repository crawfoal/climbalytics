require 'shared_examples/http_response'

shared_examples_for 'a basic new request' do |instance_variable_name|
  before :each do
    get :new
  end

  it 'builds a new record' do
    expect(assigns(instance_variable_name)).to be_a_new(controller.controller_name.classify.constantize)
  end

  it_has 'a http response', {render: :new}
end
