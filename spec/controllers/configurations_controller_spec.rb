require 'spec_helper'

describe ConfigurationsController do

  before(:each) do
    Configuration.stub(:[]).with(:starting_money).and_return(100)
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1, :admin? => true)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
  end

  def mock_configuration(stubs={})
    @mock_configuration ||= mock_model(Configuration, stubs)
  end

  describe "GET show" do
    it "assigns the requested configuration as @configuration" do
      Configuration.stub(:instance => mock_configuration)
      get :show
      assigns[:configuration].should equal(mock_configuration)
    end
  end

  describe "GET edit" do
    it "assigns the requested configuration as @configuration" do
      Configuration.stub(:instance => mock_configuration)
      get :edit
      assigns[:configuration].should equal(mock_configuration)
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested configuration" do
        Configuration.should_receive(:instance).and_return(mock_configuration)
        mock_configuration.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :configuration => {:these => 'params'}
      end

      it "assigns the requested configuration as @configuration" do
        Configuration.stub(:instance => mock_configuration(:update_attributes => true))
        put :update
        assigns[:configuration].should equal(mock_configuration)
      end

      it "redirects to the configuration" do
        Configuration.stub(:instance => mock_configuration(:update_attributes => true))
        put :update
        response.should redirect_to(configuration_url)
      end
    end

    describe "with invalid params" do
      it "updates the requested configuration" do
        Configuration.should_receive(:instance).and_return(mock_configuration)
        mock_configuration.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :configuration => {:these => 'params'}
      end

      it "assigns the configuration as @configuration" do
        Configuration.stub(:instance => mock_configuration(:update_attributes => false))
        put :update
        assigns[:configuration].should equal(mock_configuration)
      end

      it "re-renders the 'edit' template" do
        Configuration.stub(:instance => mock_configuration(:update_attributes => false))
        put :update
        response.should render_template('edit')
      end
    end

  end

end
