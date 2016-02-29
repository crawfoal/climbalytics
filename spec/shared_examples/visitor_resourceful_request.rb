# assumes that there is a factory with the same name as the resource
shared_examples_for 'a controller that requires user authentication for resourceful, CRUD actions' do |resource_name|
  let(:resource) { create(resource_name) }
  let(:resources) { create(resource_name, 3) }

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
        expect(response).to redirect_to new_user_account_session_path
      end
    end
  end

end
