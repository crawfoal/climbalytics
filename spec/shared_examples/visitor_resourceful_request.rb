# assumes that there is a factory with the same name as the resource
shared_examples_for 'a controller that has resourceful routes that requires user authentication' do |resource_name|
  let(:resource) { build_stubbed(resource_name) }
  let(:resources) { build_stubbed_list(resource_name, 3) }

  before :each do
    allow(SetterClimbLog).to receive(:all) { resources }
    allow(SetterClimbLog).to receive(:find) { resource }
  end

  {show: :get, index: :get, create: :post, new: :get, edit: :get, update: :patch, destroy: :delete}.each do |action, http_method|
    context "when a visitor requests #{http_method.upcase} ##{action}" do
      it "redirects to sign in page" do
        case action
        when :index, :new
          method(http_method).call(action)
        when :create
          method(http_method).call(action, resource_name => attributes_for(resource_name))
        when :update
          method(http_method).call(action,{ id: resource.id, resource_name => attributes_for(resource_name)})
        else
          method(http_method).call(action, id: resource.id)
        end
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
