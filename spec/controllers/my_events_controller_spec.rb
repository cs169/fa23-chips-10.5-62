require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:valid_attributes) { { name: 'name', county_id: 1, description: 'Description', start_time: Time.now, end_time: Time.now + 1.hour } }
  let(:invalid_attributes) { { name: '', county_id: nil, description: '', start_time: nil, end_time: nil } }

  describe "GET #new" do
    it "assigns a new event as @event" do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "GET #edit" do
    let(:event) { Event.create! valid_attributes }

    it "assigns the requested event as @event" do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, params: { event: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it "redirects to the events list" do
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to(events_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        post :create, params: { event: invalid_attributes }
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, params: { event: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:event) { Event.create! valid_attributes }
    let(:new_attributes) { { name: 'hehe' } }

    context "with valid params" do
      it "updates the requested event" do
        put :update, params: { id: event.id, event: new_attributes }
        event.reload
        expect(event.name).to eq('hehe')
      end

      it "redirects to the events list" do
        put :update, params: { id: event.id, event: new_attributes }
        expect(response).to redirect_to(events_path)
      end
    end

    context "with invalid params" do
      it "assigns the event as @event" do
        put :update, params: { id: event.id, event: invalid_attributes }
        expect(assigns(:event)).to eq(event)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: event.id, event: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:event) { Event.create! valid_attributes }

    it "destroys the requested event" do
      expect {
        delete :destroy, params: { id: event.id }
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to(events_url)
    end
  end
end