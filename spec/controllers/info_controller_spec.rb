require 'spec_helper'
require 'controllers/controller_stub'

describe InfoController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end

  it "should use InfoController" do
    controller.should be_an_instance_of(InfoController)
  end

end
