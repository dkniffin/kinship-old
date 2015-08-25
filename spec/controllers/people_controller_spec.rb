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
    login_user
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
        expect(assigns(:person)).to be_a_new(Person)
      end
    end
    describe "PUT /people/:id" do
      let!(:person) { create(:person) }
      let!(:new_values) { {:first_name => 'Testing'} }
      before { put :update, id: person.id, person: new_values }


      it "responds with the right status code" do
        expect(response).to have_http_status(:ok)
      end
      it "renders the show page" do
        expect(response).to render_template(:show)
      end
      it "updates the person" do
        expect { person.first_name
        }.to change { Person.count }.to(new_values[:first_name])
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







  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin, :no_capybara => true }

  describe "GET show" do
    it "assigns the requested person as @person" do
      person = Person.create! valid_attributes
      get :show, {:id => person.to_param}, valid_session
      expect(assigns(:person)).to eq(person)
    end
  end

  describe "GET new" do
    it "assigns a new person as @person" do
      get :new
      expect(assigns(:person)).to be_a_new(Person)
    end
  end

  describe "GET edit" do
    it "assigns the requested person as @person" do
      person = Person.create! valid_attributes
      get :edit, {:id => person.to_param}, valid_session
      expect(assigns(:person)).to eq(person)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Person" do
        expect {
          post :create, {:person => valid_attributes}, valid_session
        }.to change(Person, :count).by(1)
      end

      it "assigns a newly created person as @person" do
        post :create, {:person => valid_attributes}, valid_session
        expect(assigns(:person)).to be_a(Person)
        expect(assigns(:person)).to be_persisted
      end

      it "redirects to the created person" do
        post :create, {:person => valid_attributes}, valid_session
        expect(response).to redirect_to(Person.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved person as @person" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to receive(:save).and_return(false)
        post :create, {:person => { "first_name" => "invalid value" }}, valid_session
        expect(assigns(:person)).to be_a_new(Person)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to receive(:save).and_return(false)
        post :create, {:person => { "first_name" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested person" do
        person = Person.create! valid_attributes
        # Assuming there are no other people in the database, this
        # specifies that the Person created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        #Person.any_instance.should_receive(:update).with({ "first_name" => "MyString" })

        expect_any_instance_of(Person).to receive(:update).with({ "first_name" => "MyString" })
        put :update, {:id => person.to_param, :person => { "first_name" => "MyString" }}, valid_session
      end

      it "assigns the requested person as @person" do
        person = Person.create! valid_attributes
        put :update, {:id => person.to_param, :person => valid_attributes}, valid_session
        expect(assigns(:person)).to eq(person)
      end

      it "redirects to the person" do
        person = Person.create! valid_attributes
        put :update, {:id => person.to_param, :person => valid_attributes}, valid_session
        expect(response).to redirect_to(person)
      end
    end

    describe "with invalid params" do
      it "assigns the person as @person" do
        person = Person.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to receive(:save).and_return(false)
        put :update, {:id => person.to_param, :person => { "first_name" => "invalid value" }}, valid_session
        expect(assigns(:person)).to eq(person)
      end

      it "re-renders the 'edit' template" do
        person = Person.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to receive(:save).and_return(false)
        put :update, {:id => person.to_param, :person => { "first_name" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested person" do
      person = Person.create! valid_attributes
      expect {
        delete :destroy, {:id => person.to_param}, valid_session
      }.to change(Person, :count).by(-1)
    end

    it "redirects to the people list" do
      person = Person.create! valid_attributes
      delete :destroy, {:id => person.to_param}, valid_session
      expect(response).to redirect_to(people_path)
    end
  end

end
