require 'shared_examples/http_response'

shared_examples_for 'a basic update request' do |record_method_name, update_attributes, flash_hash = nil|

  alias_method :record, record_method_name

  before :each do
    patch :update, id: record.id, record_method_name => update_attributes
  end

  it 'persists the updates in the database', :focus do
    record.reload
    update_attributes.each do |key, value|
      expect(record.send(key)).to eq value
    end
  end

  it_has 'a http response', {redirect_to: record_method_name}, flash_hash
end
