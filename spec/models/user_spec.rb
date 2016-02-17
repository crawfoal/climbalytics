require 'rails_helper'

describe User do
  describe 'Validations' do
    subject { build(:user) }
    #---------------------------------------------------------------------------
    # Validations from Devise
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('amanda@example.com').for(:email) }
    it { should_not allow_value('foo').for(:email) }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Validations generated from databsase constraints and associations
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_length_of(:current_role).is_at_most(255) }
    #---------------------------------------------------------------------------

    it 'should have 8 validators' do
      expect(User.validators.size).to be 8
    end
  end

  context 'with valid attributes' do
    subject(:user) { create(:user) }
    it { should be_valid }

    it 'accepts nested attributes for a name' do
      user.update(name_attributes: attributes_for(:name))
      expect(user.name).to be_persisted
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
      athlete = create(:user, roles: [:athlete])
      expect(athlete).to be_valid
      expect(athlete).to have_role :athlete
    end
    it 'has a valid setter factory' do
      setter = create(:user, roles: [:setter])
      expect(setter).to be_valid
      expect(setter).to have_role :setter
    end
    describe User::Name do
      let(:user) { create(:user, :with_name) }
      subject(:name) { user.name }

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

describe User::Name do

  #-----------------------------------------------------------------------------
  # Validations generated from databsase constraints and associations
  it { should validate_length_of(:first).is_at_most(255) }
  it { should validate_length_of(:last).is_at_most(255) }
  #-----------------------------------------------------------------------------

end
