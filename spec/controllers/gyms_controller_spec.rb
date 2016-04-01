require 'main_suite_helper'

RSpec.describe GymsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Gym. As you add validations to Gym, be sure to
  # adjust the attributes here as well.

  # I'm sure there is a better way... look at Factory Girl's documentation later...
  # ---> look at the 5th example in this section: http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md#Using_factories
  let(:state) { create(:state) }
  let(:address_attribs) { attributes_for(:address).merge(state_id: state.id) }
  let(:location_attribs) { attributes_for(:location) }
  let(:section_attribs) { attributes_for(:gym_section) }
  let(:valid_attributes) { attributes_for(:gym, location_attributes: location_attribs.merge(address_attributes: address_attribs), gym_sections_attributes: [section_attribs]) }

  let(:invalid_attributes) { attributes_for(:gym, :invalid) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GymsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  login_user

  describe "GET #index" do
    it "assigns all gyms as @gyms" do
      gym = Gym.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:gyms)).to eq([gym])
    end
  end

  describe "GET #show" do
    it "assigns the requested gym as @gym" do
      gym = Gym.create! valid_attributes
      get :show, {:id => gym.to_param}, valid_session
      expect(assigns(:gym)).to eq(gym)
    end
  end

  describe "GET #new" do
    let(:http_request) { -> { get :new, {}, valid_session } }
    it "assigns a new gym as @gym" do
      http_request.call
      expect(assigns(:gym)).to be_a_new(Gym)
    end
    it "builds a new location" do
      http_request.call
      expect(assigns(:gym).location).to be_a_new(Location)
    end
    it "builds a new gym section" do
      http_request.call
      expect(assigns(:gym).gym_sections.first).to be_a_new(GymSection)
    end
  end

  describe "GET #edit" do
    it "assigns the requested gym as @gym" do
      gym = Gym.create! valid_attributes
      get :edit, {:id => gym.to_param}, valid_session
      expect(assigns(:gym)).to eq(gym)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:http_request) { -> { post :create, {:gym => valid_attributes}, valid_session } }
      it "creates a new Gym" do
        expect { http_request.call }.to change(Gym, :count).by(1)
      end
      it "creates a new Location" do
        expect { http_request.call }.to change { Location.count }.by(1)
      end
      it "creates a new GymSection" do
        expect { http_request.call }.to change { GymSection.count }.by(1)
      end

      it "assigns a newly created gym as @gym" do
        http_request.call
        expect(assigns(:gym)).to be_a(Gym)
        expect(assigns(:gym)).to be_persisted
      end
      it "associates the new location with the gym" do
        http_request.call
        expect(assigns(:gym).location).to be_a(Location)
        expect(assigns(:gym).location).to be_persisted
      end
      it "associates the new gym section with the gym" do
        http_request.call
        expect(assigns(:gym).gym_sections.first).to be_a(GymSection)
        expect(assigns(:gym).gym_sections.first).to be_persisted
      end

      it "redirects to the created gym" do
        http_request.call
        expect(response).to redirect_to(Gym.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved gym as @gym" do
        post :create, {:gym => invalid_attributes}, valid_session
        expect(assigns(:gym)).to be_a_new(Gym)
      end

      it "re-renders the 'new' template" do
        post :create, {:gym => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested gym as @gym" do
        gym = Gym.create! valid_attributes
        put :update, {:id => gym.to_param, :gym => valid_attributes}, valid_session
        expect(assigns(:gym)).to eq(gym)
      end

      it "redirects to the gym" do
        gym = Gym.create! valid_attributes
        put :update, {:id => gym.to_param, :gym => valid_attributes}, valid_session
        expect(response).to redirect_to(gym)
      end
    end

    context "with invalid params" do
      it "assigns the gym as @gym" do
        gym = Gym.create! valid_attributes
        put :update, {:id => gym.to_param, :gym => invalid_attributes}, valid_session
        expect(assigns(:gym)).to eq(gym)
      end

      it "re-renders the 'edit' template" do
        gym = Gym.create! valid_attributes
        put :update, {:id => gym.to_param, :gym => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

end
