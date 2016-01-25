shared_examples_for 'a basic index request' do |instance_variable_name|
  before :each do
    get :index
  end

  it 'populates an instance variable with a set of records' do
    records = method(instance_variable_name).call
    expect(assigns(instance_variable_name)).to eq records
  end

  it 'renders the index template' do
    expect(response).to render_template :index
  end
end
