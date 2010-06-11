class ConfigurationsController < ApplicationController
  def show
    @configuration = Configuration.instance
    authorize! :read, @configuration
  end

  def edit
    @configuration = Configuration.instance
    authorize! :update, @configuration
  end

  def update
    @configuration = Configuration.instance
    authorize! :update, @configuration
    if @configuration.update_attributes(params[:configuration])
      redirect_to(configuration_path, :notice => 'Configuration was successfully updated.')
    else
      render :action => "edit"
    end
  end

end
