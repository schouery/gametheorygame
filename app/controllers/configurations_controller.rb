class ConfigurationsController < ApplicationController
  def show
    @configuration = Configuration.instance
  end

  def edit
    @configuration = Configuration.instance
  end

  def update
    @configuration = Configuration.instance
    if @configuration.update_attributes(params[:configuration])
      redirect_to(configuration_path, :notice => 'Configuration was successfully updated.')
    else
      render :action => "edit"
    end
  end

end
