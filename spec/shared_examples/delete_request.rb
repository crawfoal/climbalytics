require 'shared_examples/http_response'

shared_examples_for 'a basic delete request' do |record_method_name, response_hash = nil, flash_hash = nil|
  alias_method :record, record_method_name
  let(:klass) { record.class }
  let(:http_request_proc) { proc { delete :destroy, id: record.id } }

  it "deletes the record from the database" do
    expect { http_request_proc.call }.to change { klass.count }.by(-1)
  end

  if response_hash or flash_hash
    it_has 'a http response', response_hash, flash_hash, :http_request_proc
  end

end
