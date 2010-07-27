module ControllerStub
  def basic_controller_stub
    Configuration.stub(:[]).with(:starting_money).and_return(100)
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1, :facebook_id => 100,
      :admin? => true)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
    controller.stub!(:set_current_user => true)
  end
end