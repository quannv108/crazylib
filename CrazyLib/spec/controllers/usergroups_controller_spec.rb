require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe UsergroupsController do

  # This should return the minimal set of attributes required to create a valid
  # Usergroup. As you add validations to Usergroup, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsergroupsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all usergroups as @usergroups" do
      usergroup = Usergroup.create! valid_attributes
      get :index, {}, valid_session
      assigns(:usergroups).should eq([usergroup])
    end
  end

  describe "GET show" do
    it "assigns the requested usergroup as @usergroup" do
      usergroup = Usergroup.create! valid_attributes
      get :show, {:id => usergroup.to_param}, valid_session
      assigns(:usergroup).should eq(usergroup)
    end
  end

  describe "GET new" do
    it "assigns a new usergroup as @usergroup" do
      get :new, {}, valid_session
      assigns(:usergroup).should be_a_new(Usergroup)
    end
  end

  describe "GET edit" do
    it "assigns the requested usergroup as @usergroup" do
      usergroup = Usergroup.create! valid_attributes
      get :edit, {:id => usergroup.to_param}, valid_session
      assigns(:usergroup).should eq(usergroup)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Usergroup" do
        expect {
          post :create, {:usergroup => valid_attributes}, valid_session
        }.to change(Usergroup, :count).by(1)
      end

      it "assigns a newly created usergroup as @usergroup" do
        post :create, {:usergroup => valid_attributes}, valid_session
        assigns(:usergroup).should be_a(Usergroup)
        assigns(:usergroup).should be_persisted
      end

      it "redirects to the created usergroup" do
        post :create, {:usergroup => valid_attributes}, valid_session
        response.should redirect_to(Usergroup.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved usergroup as @usergroup" do
        # Trigger the behavior that occurs when invalid params are submitted
        Usergroup.any_instance.stub(:save).and_return(false)
        post :create, {:usergroup => {}}, valid_session
        assigns(:usergroup).should be_a_new(Usergroup)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Usergroup.any_instance.stub(:save).and_return(false)
        post :create, {:usergroup => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested usergroup" do
        usergroup = Usergroup.create! valid_attributes
        # Assuming there are no other usergroups in the database, this
        # specifies that the Usergroup created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Usergroup.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => usergroup.to_param, :usergroup => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested usergroup as @usergroup" do
        usergroup = Usergroup.create! valid_attributes
        put :update, {:id => usergroup.to_param, :usergroup => valid_attributes}, valid_session
        assigns(:usergroup).should eq(usergroup)
      end

      it "redirects to the usergroup" do
        usergroup = Usergroup.create! valid_attributes
        put :update, {:id => usergroup.to_param, :usergroup => valid_attributes}, valid_session
        response.should redirect_to(usergroup)
      end
    end

    describe "with invalid params" do
      it "assigns the usergroup as @usergroup" do
        usergroup = Usergroup.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Usergroup.any_instance.stub(:save).and_return(false)
        put :update, {:id => usergroup.to_param, :usergroup => {}}, valid_session
        assigns(:usergroup).should eq(usergroup)
      end

      it "re-renders the 'edit' template" do
        usergroup = Usergroup.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Usergroup.any_instance.stub(:save).and_return(false)
        put :update, {:id => usergroup.to_param, :usergroup => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested usergroup" do
      usergroup = Usergroup.create! valid_attributes
      expect {
        delete :destroy, {:id => usergroup.to_param}, valid_session
      }.to change(Usergroup, :count).by(-1)
    end

    it "redirects to the usergroups list" do
      usergroup = Usergroup.create! valid_attributes
      delete :destroy, {:id => usergroup.to_param}, valid_session
      response.should redirect_to(usergroups_url)
    end
  end

end
