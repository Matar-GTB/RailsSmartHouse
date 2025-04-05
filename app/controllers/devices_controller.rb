class DevicesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_device, only: [:show, :edit, :update, :destroy]
    before_action :ensure_complex_user, only: [:new, :create, :edit, :update]
    before_action :ensure_admin_user, only: [:destroy]
  
    def index
      @devices = Device.all
      @devices = @devices.search(params[:query]) if params[:query].present?
      if params[:active].present?
        active_flag = ActiveModel::Type::Boolean.new.cast(params[:active])
        @devices = @devices.filter_by_active(active_flag)
      end
      @devices = @devices.order(:name)
    end
  
    def show
    end
  
    def new
      @device = Device.new
    end
  
    def create
      @device = Device.new(device_params)
      if @device.save
        current_utilisateur.increment!(:points, 5)
        current_utilisateur.check_level_up!
        flash[:notice] = "Objet \"#{@device.name}\" créé avec succès."
        redirect_to @device
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @device.update(device_params)
        current_utilisateur.increment!(:points, 2)
        current_utilisateur.check_level_up!
        flash[:notice] = "Objet \"#{@device.name}\" mis à jour."
        redirect_to @device
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @device.destroy
      flash[:notice] = "Objet supprimé."
      redirect_to devices_path
    end
  
    private
  
      def set_device
        @device = Device.find(params[:id])
      end
  
      def device_params
        params.require(:device).permit(:name, :category, :location, :description, :value, :active)
      end
  
      def ensure_complex_user
        unless current_utilisateur && (current_utilisateur.role == "complexe" || current_utilisateur.role == "admin")
          flash[:alert] = "Accès réservé aux utilisateurs avancés."
          redirect_to devices_path
        end
      end
  end
  