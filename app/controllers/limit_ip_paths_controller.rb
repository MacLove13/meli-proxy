class LimitIpPathsController < ApplicationController
  before_action :set_limit_ip_path, only: %i[ show edit update destroy ]

  # GET /limit_ip_paths or /limit_ip_paths.json
  def index
    @limit_ip_paths = LimitIpPath.all
  end

  # GET /limit_ip_paths/1 or /limit_ip_paths/1.json
  def show
  end

  # GET /limit_ip_paths/new
  def new
    @limit_ip_path = LimitIpPath.new
  end

  # GET /limit_ip_paths/1/edit
  def edit
  end

  # POST /limit_ip_paths or /limit_ip_paths.json
  def create
    @limit_ip_path = LimitIpPath.new(limit_ip_path_params)

    respond_to do |format|
      if @limit_ip_path.save
        format.html { redirect_to @limit_ip_path, notice: "Limit ip path was successfully created." }
        format.json { render :show, status: :created, location: @limit_ip_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @limit_ip_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /limit_ip_paths/1 or /limit_ip_paths/1.json
  def update
    respond_to do |format|
      if @limit_ip_path.update(limit_ip_path_params)
        format.html { redirect_to @limit_ip_path, notice: "Limit ip path was successfully updated." }
        format.json { render :show, status: :ok, location: @limit_ip_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @limit_ip_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /limit_ip_paths/1 or /limit_ip_paths/1.json
  def destroy
    @limit_ip_path.destroy
    respond_to do |format|
      format.html { redirect_to limit_ip_paths_url, notice: "Limit ip path was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_limit_ip_path
      @limit_ip_path = LimitIpPath.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def limit_ip_path_params
      params.require(:limit_ip_path).permit(:ip, :path, :max_requests_hour, :max_requests_day)
    end
end
