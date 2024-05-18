class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorized!, except: [:create, :new]
  load_and_authorize_resource except: [:create, :new]

  def index
    @user = current_user
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)


    respond_to do |format|
      if @user.save
        log_in(@user)
        format.html { 
          redirect_to '/dashboard', notice: "Welcome #{current_user.first_name} #{current_user.last_name}" 
        }
      else
        format.html {render 'users/new', status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to "/dashboard", notice: "User not Updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/dashboard", notice: "User Deleted" }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :balance, :payment_date, :address, :image, :phone_number, :uid, :provider, :meter_number, :amount, :role, :password, :password_confirmation)
  end
end
