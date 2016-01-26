require 'shared_examples/http_response'

shared_examples_for 'a basic create request' do |model_name, attributes_method_name, response_hash = nil, flash_hash = nil|
  alias_method :attributes, attributes_method_name

  let(:klass) { model_name.to_s.classify.constantize }
  let(:http_request_proc) { proc { post :create, {model_name => attributes} } }

  it 'creates a new record' do
    expect { http_request_proc.call }.to change { klass.count }.by(1)
  end

  if response_hash or flash_hash
    it_has 'a http response', response_hash, flash_hash, :http_request_proc
  end

end
