class TrashesController < ApplicationController
  # GET /trashes
  # GET /trashes.xml
  def index
    @trashes = Trash.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trashes }
    end
  end

  # GET /trashes/1
  # GET /trashes/1.xml
  def show
    @trash = Trash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trash }
    end
  end

  # GET /trashes/new
  # GET /trashes/new.xml
  def new
    @trash = Trash.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trash }
    end
  end

  # GET /trashes/1/edit
  def edit
    @trash = Trash.find(params[:id])
  end

  # POST /trashes
  # POST /trashes.xml
  def create
    @trash = Trash.new(params[:trash])

    respond_to do |format|
      if @trash.save
        flash[:notice] = 'Trash was successfully created.'
        format.html { redirect_to(@trash) }
        format.xml  { render :xml => @trash, :status => :created, :location => @trash }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trash.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trashes/1
  # PUT /trashes/1.xml
  def update
    @trash = Trash.find(params[:id])

    respond_to do |format|
      if @trash.update_attributes(params[:trash])
        flash[:notice] = 'Trash was successfully updated.'
        format.html { redirect_to(@trash) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trash.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trashes/1
  # DELETE /trashes/1.xml
  def destroy
    @trash = Trash.find(params[:id])
    @trash.destroy

    respond_to do |format|
      format.html { redirect_to(trashes_url) }
      format.xml  { head :ok }
    end
  end
end
