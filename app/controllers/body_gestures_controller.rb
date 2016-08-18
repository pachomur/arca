class BodyGesturesController < ApplicationController
  before_action :set_body_gesture, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  # GET /body_gestures
  # GET /body_gestures.json
  def index
    @body_gestures = BodyGesture.all.paginate(page: params[:page], per_page: 50).order('name ASC')
  end

  # GET /body_gestures/1
  # GET /body_gestures/1.json
  def show
  end

  # GET /body_gestures/new
  def new
    @body_gesture = BodyGesture.new
  end

  # GET /body_gestures/1/edit
  def edit
  end

  # POST /body_gestures
  # POST /body_gestures.json
  def create
    @body_gesture = BodyGesture.new(body_gesture_params)
    respond_to do |format|
      if @body_gesture.save
        format.html { redirect_to @body_gesture, notice: 'body_gesture was successfully created.' }
        format.json { render :show, status: :created, location: @body_gesture }
      else
        format.html { render :new }
        format.json { render json: @body_gesture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /body_gestures/1
  # PATCH/PUT /body_gestures/1.json
  def update
    respond_to do |format|
      if @body_gesture.update(body_gesture_params)
        format.html { redirect_to @body_gesture, notice: 'Body gesture was successfully updated.' }
        format.json { render :show, status: :ok, location: @body_gesture }
      else
        format.html { render :edit }
        format.json { render json: @body_gesture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /body_gestures/1
  # DELETE /body_gestures/1.json
  def destroy
    @body_gesture.destroy
    respond_to do |format|
      format.html { redirect_to body_gestures_url, notice: 'Body gesture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_body_gesture
      @body_gesture = BodyGesture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def body_gesture_params
      params.require(:body_gesture).permit(:name, :image)
    end
end
