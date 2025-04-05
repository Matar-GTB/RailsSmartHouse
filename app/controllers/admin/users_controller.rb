class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin_user
  
    def index
      @users = User.all.order(:created_at)
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "Utilisateur créé avec succès."
        redirect_to admin_users_path
      else
        render :new
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if params[:user][:password].blank?
        params[:user].extract!(:password, :password_confirmation)
      end
      if @user.update(user_params)
        flash[:notice] = "Profil utilisateur mis à jour."
        redirect_to admin_users_path
      else
        render :edit
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      if @user == current_utilisateur
        flash[:alert] = "Vous ne pouvez pas supprimer votre propre compte."
        redirect_to admin_users_path
      else
        @user.destroy
        flash[:notice] = "Utilisateur supprimé."
        redirect_to admin_users_path
      end
    end
  
    private
  
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :points)
      end
  end
  