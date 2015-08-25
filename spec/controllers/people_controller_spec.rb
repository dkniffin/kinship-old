require 'spec_helper'

describe PeopleController, :type => :controller do
  context "when not logged in" do
    describe "GET /people" do
      before { get :index }
      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET /people/:id" do
      let!(:person) { create(:person) }
      before { get :show, id: person.id }

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET /people/new" do
      before { get :new }

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "POST /people" do
      let(:valid_params) { attributes_for(:person) }

      it "redirects to login page" do
        post :create, person: valid_params
        expect(response).to redirect_to(new_user_session_path)
      end

      it "doesn't create a new person" do
        expect { post :create, person: valid_params
        }.to_not change { Person.count }
      end
    end
    describe "GET /people/:id/edit" do
      let!(:person) { create(:person) }
      before { get :edit, id: person.id }

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "PUT /people/:id" do
      let!(:person) { create(:person) }
      let!(:new_values) { attributes_for(:person) }
      before { put :update, id: person.id, person: new_values }

      it "redirects to login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "DELETE /people/:id" do
      let!(:person) { create(:person) }

      it "redirects to login page" do
        delete :destroy, id: person.id
        expect(response).to redirect_to(new_user_session_path)
      end
      it "doesn't delete the person" do
        expect { delete :destroy, id: person.id
        }.to_not change { Person.count }
      end
    end
  end
  context "when logged in" do
    login(:user)
    describe "GET /people" do
      before { get :index }
      it "responds with the right status code" do
        expect(response).to have_http_status(:ok)
      end
      it "renders the show page" do
        expect(response).to render_template(:index)
      end
    end
    describe "GET /people/:id" do
      let!(:person) { create(:person) }
      before { get :show, id: person.id }

      it "responds with the right status code" do
        expect(response).to have_http_status(:ok)
      end
      it "renders the show page" do
        expect(response).to render_template(:show)
      end
      it "assigns the requested person as @person" do
        expect(assigns(:person)).to eq(person)
      end
    end
    describe "GET /people/new" do
      before { get :new }

      it "responds with the right status code" do
        expect(response).to have_http_status(:ok)
      end
      it "renders the show page" do
        expect(response).to render_template(:new)
      end
      it "assigns a new person as @person" do
        expect(assigns(:person)).to be_a_new(Person)
      end
    end
    describe "POST /people" do
      let(:valid_params) { attributes_for(:person) }

      it "responds with the right status code" do
        post :create, person: valid_params
        expect(response).to have_http_status(:found)
      end
      it "creates a new person" do
        expect { post :create, person: valid_params
        }.to change { Person.count }.by(1)
      end
    end
    describe "GET /people/:id/edit" do
      let!(:person) { create(:person) }
      before { get :edit, id: person.id }

      it "responds with the right status code" do
        expect(response).to have_http_status(:ok)
      end
      it "renders the show page" do
        expect(response).to render_template(:edit)
      end
      it "assigns the requested person as @person" do
        expect(assigns(:person)).to eq(person)
      end
    end
    describe "PUT /people/:id" do
      let!(:person) { create(:person) }
      let!(:new_values) { {:first_name => 'Testing'} }

      it "responds with the right status code" do
        put :update, id: person.id, person: new_values
        expect(response).to have_http_status(:found)
      end
      it "updates the person" do
        expect { put :update, id: person.id, person: new_values
        }.to change { person.reload.first_name }.from(person.first_name).to(new_values[:first_name])
      end
    end
    describe "DELETE /people/:id" do
      let!(:person) { create(:person) }

      it "responds with the right status code" do
        expect(response).to have_http_status(:ok)
      end
      it "deletes the person" do
        expect {  delete :destroy, id: person.id
        }.to change { Person.count }.by(-1)
      end
    end
  end
end
