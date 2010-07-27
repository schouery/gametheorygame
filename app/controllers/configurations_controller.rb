#Controller used to show and edit system configurations
class ConfigurationsController < ApplicationController
  #Assigns @configuration as the instance of Configuration.
  #Used for showing the current configuration.
  def show
    @configuration = Configuration.instance
    authorize! :read, @configuration
  end
  
  #Assigns @configuration as the instance of Configuration.
  #Used to edit the configuration.
  def edit
    @configuration = Configuration.instance
    authorize! :update, @configuration
  end

  #Updates the (only) instance of Configuration and redirects to
  #configuration_path
  def update
    @configuration = Configuration.instance
    authorize! :update, @configuration
    if @configuration.update_attributes(params[:configuration])
      redirect_to(configuration_path,
        :notice => 'Configuration was successfully updated.')
    else
      render :action => "edit"
    end
  end

end
