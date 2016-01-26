
require 'rails_helper'

describe User do
  context 'with valid attributes' do
    subject(:user) { create(:user) }
    it { should be_valid }

    it 'accepts nested attributes for a name' do
      user.update(name_attributes: attributes_for(:name))
      expect(user.name).to be_persisted
    end
    it 'accepts nested attributes for an address' do
      user.update(address_attributes: attributes_for(:address).merge(state_id: create(:state).id))
      expect(user.address).to be_persisted
    end
    it 'cannot add a role unless it is already defined' do
      err_msg = user.add_role :undefined_role
      expect(user).to_not have_role :undefined_role
      expect(err_msg).to eq "The role 'undefined_role' was not added for #{user.address_me_as} because the role is not defined."
    end
    it 'cannot grant a role unless it is already defined' do
      err_msg = user.grant :undefined_role
      expect(user).to_not have_role :undefined_role
      expect(err_msg).to eq "The role 'undefined_role' was not added for #{user.address_me_as} because the role is not defined."
    end
    it 'can add a role if it is defined already' do
      define_roles(:defined_role)
      user.add_role :defined_role
      expect(user).to have_role :defined_role
    end

    it 'has a valid athlete factory' do
      athlete = create(:athlete_user)
      expect(athlete).to be_valid
      expect(athlete).to have_role :athlete
    end
    it 'has a valid setter factory' do
      setter = create(:setter_user)
      expect(setter).to be_valid
      expect(setter).to have_role :setter
    end
    it 'destroys address during destruction' do
      user = create(:user_address).addressable
      expect { user.destroy }.to change { user.address.destroyed? }.from(false).to(true)
    end
    describe User::Name do
      subject(:name) { create(:name) }
      let(:user) { name.user }

      it { should be_valid }
      it 'is destroyed when user is destroyed' do
        expect { user.destroy }.to change { user.name.destroyed? }.from(false).to(true)
      end

      describe '#address_me_as' do
        context 'when user has a first name defined' do
          it 'returns the first name' do
            expect(user.address_me_as).to eq name.first
          end
        end
        context 'when user does not has a first name defined' do
          it "returns the user's email" do
            user.name.first = ''
            expect(user.address_me_as).to eq user.email
          end
        end
      end
    end
  end

end
