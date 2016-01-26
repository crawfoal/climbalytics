RSpec.configure do |config|
  config.alias_it_should_behave_like_to :it_has, 'has'
end

shared_examples_for 'a http response' do |response_hash, flash_hash = nil, http_request_method_name = nil|
  if http_request_method_name
    alias_method :http_request_proc, http_request_method_name

    before :each do
      http_request_proc.call
    end
  end

  subject {response}

  if ( template = response_hash[:render] )
    it { should render_template template }
  elsif ( action = response_hash[:redirect_to] )
    if action.respond_to? :call
      it { should redirect_to action.call }
    else
      it { should redirect_to action }
    end
  end

  if flash_hash and not flash_hash.empty?
    it 'displays a flash message' do
      flash_hash.each do |type, message|
        expect(flash[type]).to eq message
      end
    end
  end
end
