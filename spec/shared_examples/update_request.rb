shared_examples_for 'a basic update request' do |record_method_name, update_attributes, flash_message_hash = nil|
  let(:record) { method(record_method_name).call }
  before :each do
    patch :update, id: record.id, record_method_name => update_attributes
  end

  it 'persists the updates in the database', :focus do
    record.reload
    update_attributes.each do |key, value|
      expect(record.send(key)).to eq value
    end
  end

  it 'redirects to the show template' do
    expect(response).to redirect_to(assigns(record_method_name))
  end

  if flash_message_hash
    it 'displays a flash message' do
      flash_message_hash.each do |type, message|
        expect(flash[type]).to eq message
      end
    end
  end
end
