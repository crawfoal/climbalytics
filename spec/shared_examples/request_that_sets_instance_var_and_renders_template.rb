# you must set up the http_request_proc to use this

shared_examples_for 'a request that sets an instance variable and renders a template' do |instance_variable_name, template_name, resource_name = nil|

  resource_name ||= instance_variable_name

  before :each do
    http_request_proc.call
  end

  it "assigns the requested resource to @#{instance_variable_name}" do
    expect(assigns(instance_variable_name)).to eq method(resource_name).call
  end

  it "renders the :#{template_name} template" do
    expect(response).to render_template template_name
  end

end
