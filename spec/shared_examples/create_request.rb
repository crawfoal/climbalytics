shared_examples_for 'a basic create request' do |model_name, response_hash, flash_hash|
  let(:attributes_method_name) { model_name.to_s + '_attribs' }
  let(:klass) { model_name.to_s.classify.constantize }
  let(:http_request_proc) { Proc.new { post :create, {model_name => method(attributes_method_name).call} } }

  it 'creates a new record' do
    expect { http_request_proc.call }.to change { klass.count }.by(1)
  end

  if response_hash or flash_hash
    describe 'response' do
      before :each do
        http_request_proc.call
      end
      subject { response }

      if ( template = response_hash[:render] )
        it { should render template }
      elsif ( action = response_hash[:redirect_to] )
        if action.respond_to? :call
          it { should redirect_to action.call }
        else
          it { should redirect_to action }
        end
      end

      if flash_hash
        it 'displays a flash message' do
          flash_hash.each do |type, message|
            expect(flash[type]).to eq message
          end
        end
      end
    end
  end

end
