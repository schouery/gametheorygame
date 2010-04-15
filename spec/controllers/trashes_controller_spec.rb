require 'spec_helper'

describe TrashesController do

  def mock_trash(stubs={})
    @mock_trash ||= mock_model(Trash, stubs)
  end

  describe "GET index" do
    it "assigns all trashes as @trashes" do
      Trash.stub(:find).with(:all).and_return([mock_trash])
      get :index
      assigns[:trashes].should == [mock_trash]
    end
  end

  describe "GET show" do
    it "assigns the requested trash as @trash" do
      Trash.stub(:find).with("37").and_return(mock_trash)
      get :show, :id => "37"
      assigns[:trash].should equal(mock_trash)
    end
  end

  describe "GET new" do
    it "assigns a new trash as @trash" do
      Trash.stub(:new).and_return(mock_trash)
      get :new
      assigns[:trash].should equal(mock_trash)
    end
  end

  describe "GET edit" do
    it "assigns the requested trash as @trash" do
      Trash.stub(:find).with("37").and_return(mock_trash)
      get :edit, :id => "37"
      assigns[:trash].should equal(mock_trash)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created trash as @trash" do
        Trash.stub(:new).with({'these' => 'params'}).and_return(mock_trash(:save => true))
        post :create, :trash => {:these => 'params'}
        assigns[:trash].should equal(mock_trash)
      end

      it "redirects to the created trash" do
        Trash.stub(:new).and_return(mock_trash(:save => true))
        post :create, :trash => {}
        response.should redirect_to(trash_url(mock_trash))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved trash as @trash" do
        Trash.stub(:new).with({'these' => 'params'}).and_return(mock_trash(:save => false))
        post :create, :trash => {:these => 'params'}
        assigns[:trash].should equal(mock_trash)
      end

      it "re-renders the 'new' template" do
        Trash.stub(:new).and_return(mock_trash(:save => false))
        post :create, :trash => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested trash" do
        Trash.should_receive(:find).with("37").and_return(mock_trash)
        mock_trash.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :trash => {:these => 'params'}
      end

      it "assigns the requested trash as @trash" do
        Trash.stub(:find).and_return(mock_trash(:update_attributes => true))
        put :update, :id => "1"
        assigns[:trash].should equal(mock_trash)
      end

      it "redirects to the trash" do
        Trash.stub(:find).and_return(mock_trash(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(trash_url(mock_trash))
      end
    end

    describe "with invalid params" do
      it "updates the requested trash" do
        Trash.should_receive(:find).with("37").and_return(mock_trash)
        mock_trash.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :trash => {:these => 'params'}
      end

      it "assigns the trash as @trash" do
        Trash.stub(:find).and_return(mock_trash(:update_attributes => false))
        put :update, :id => "1"
        assigns[:trash].should equal(mock_trash)
      end

      it "re-renders the 'edit' template" do
        Trash.stub(:find).and_return(mock_trash(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested trash" do
      Trash.should_receive(:find).with("37").and_return(mock_trash)
      mock_trash.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the trashes list" do
      Trash.stub(:find).and_return(mock_trash(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(trashes_url)
    end
  end

end
