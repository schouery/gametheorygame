require 'spec_helper'
require 'controllers/controller_stub'

describe ConfigurationsController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
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
