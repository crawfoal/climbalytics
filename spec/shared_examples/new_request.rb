# records should either be the symbol that corresponds both the instance variable name used in the controller *and* the method used in the spec to set up the record, or if they are a different name, it should be a hash like this: {instance_variable_name: :spec_setup_method_name}
shared_examples_for 'a basic new request' do |instance_variable_name|
  before :each do
    get :new
  end

  it 'builds a new record' do
    expect(assigns(instance_variable_name)).to be_a_new(controller.controller_name.classify.constantize)
  end

  it 'renders the :new template' do
    expect(response).to render_template :new
  end
end
