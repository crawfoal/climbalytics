shared_examples_for 'a basic delete request' do |response_hash = nil, flash_message_hash = nil|
  let(:klass) { record.class }

  it "deletes the record from the database" do
    expect { delete :destroy, id: record.id }.to change { klass.count }.by(-1)
  end

  if response_hash or flash_message_hash
    describe 'response' do
      before :each do
        delete :destroy, id: record.id
      end

      if (template = response_hash[:render])
        it "renders #{template}" do
          expect(response).to render template
        end
      elsif (action = response_hash[:redirect_to])
        it "redirects to #{action}" do
          expect(response).to redirect_to action
        end
      end

      if flash_message_hash
        it 'displays a flash message' do
          flash_message_hash.each do |type, message|
            expect(flash[type]).to eq message
          end
        end
      end
    end
  end

end
