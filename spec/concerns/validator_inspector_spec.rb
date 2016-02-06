require 'rails_helper'

describe ValidatorInspector do
  describe '#validator_digest' do
    context 'for a model that has some validations defined' do
      it 'returns a hash with the validator kinds as keys' do
        expect(User.validator_digest.keys).to include :presence
      end
      it 'returns a hash with an array of attributes for the values' do
        expect(User.validator_digest[:presence]).to include :email
      end
    end
  end
end
