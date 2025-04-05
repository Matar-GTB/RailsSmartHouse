class Admin::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin_user
  
    def index
      @users_count      = User.count
      @devices_count    = Device.count
      @active_devices   = Device.where(active: true).count
      @inactive_devices = Device.where(active: false).count
      @recent_users     = User.order(created_at: :desc).limit(5)
    end
  end
  