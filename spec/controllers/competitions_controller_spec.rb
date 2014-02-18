require 'spec_helper'

describe CompetitionsController do

  # This should return the minimal set of attributes required to create a valid
  # Competition. As you add validations to Competition, be sure to adjust the
  # attributes here as well.
  let(:valid_attributes) { {} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompetitionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:competition) { create(:competition, valid_attributes) }

  describe 'GET index' do
    it 'assigns all competitions as @competitions' do
      get :index, {}, valid_session
      assigns(:competitions).should eq([competition])
    end
  end

  describe 'GET show' do
    it 'assigns the requested competition as @competition' do
      get :show, { id: competition.to_param }, valid_session
      assigns(:competition).should eq(competition)
    end
  end

  describe 'GET new' do
    it 'assigns a new competition as @competition' do
      get :new, {}, valid_session
      assigns(:competition).should be_a_new(Competition)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested competition as @competition' do
      get :edit, { id: competition.to_param }, valid_session
      assigns(:competition).should eq(competition)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Competition' do
        expect {
          post :create, { competition:  valid_attributes }, valid_session
        }.to change(Competition, :count).by(1)
      end

      it 'assigns a newly created competition as @competition' do
        post :create, { competition: valid_attributes }, valid_session
        assigns(:competition).should be_a(Competition)
        assigns(:competition).should be_persisted
      end

      it 'redirects to the created competition' do
        post :create, { competition: valid_attributes }, valid_session
        response.should redirect_to(Competition.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved competition as @competition' do
        # Trigger the behavior that occurs when invalid params are submitted
        Competition.any_instance.stub(:save).and_return(false)
        post :create, { competition: {} }, valid_session
        assigns(:competition).should be_a_new(Competition)
      end

      it 're-renders the "new" template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Competition.any_instance.stub(:save).and_return(false)
        post :create, { competition: {} }, valid_session
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested competition' do
        # Assuming there are no other competitions in the database, this
        # specifies that the Competition created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Competition.any_instance.should_receive(:update)
          .with('these' => 'params')
        put :update, { id: competition.to_param,
                       competition: { 'these' => 'params' } }, valid_session
      end

      it 'assigns the requested competition as @competition' do
        competition = create(:competition, valid_attributes)
        put :update, { id: competition.to_param,
                       competition: valid_attributes }, valid_session
        assigns(:competition).should eq(competition)
      end

      it 'redirects to the competition' do
        competition = create(:competition, valid_attributes)
        put :update, { id: competition.to_param,
                       competition: valid_attributes }, valid_session
        response.should redirect_to(competition)
      end
    end

    describe 'with invalid params' do
      it 'assigns the competition as @competition' do
        # Trigger the behavior that occurs when invalid params are submitted
        Competition.any_instance.stub(:save).and_return(false)
        put :update, { id: competition.to_param,
                       competition: {} }, valid_session
        assigns(:competition).should eq(competition)
      end

      it 're-renders the "edit" template' do
        competition = Competition.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Competition.any_instance.stub(:save).and_return(false)
        put :update, { id: competition.to_param,
                       competition: {} }, valid_session
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested competition' do
      competition # Force creation of competition
      expect { delete :destroy, { id: competition.to_param }, valid_session }
        .to change(Competition, :count).by(-1)
    end

    it 'redirects to the competitions list' do
      delete :destroy, { id: competition.to_param }, valid_session
      expect(response).to redirect_to(competitions_url)
    end
  end
end
