class SessionsController < ApplicationController
  skip_before_action :authorized!, only: [:new, :create, :create_auth_user]

  def new; end

  def create
    reset_session
    @user = User.find_by(email: session_params[:email])

    respond_to do |format|
      if @user && @user.authenticate(session_params[:password])
        log_in(@user)
        format.html { 
          redirect_to '/dashboard', notice: "Welcome Back #{current_user.first_name} #{current_user.last_name}" 
        }
      else
        format.html {render '/login', status: :unprocessable_entity}
      end
    end
  end

  def create_auth_user
    auth = request.env["omniauth.auth"]
    begin
      respond_to do |format|
        if (User.find_by_provider_and_uid(auth["provider"], auth["uid"]))
          @auth_user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
        else
          @auth_user = User.new
          @auth_user.provider = auth["provider"]
          @auth_user.uid = auth["uid"]
          @auth_user.first_name = auth["info"]["first_name"]
          @auth_user.last_name = auth["info"]["last_name"]
          @auth_user.email = auth["info"]["email"]
          @auth_user.image = auth["info"]["image"]
          @auth_user.password = "ASP#{Date.today.strftime("%Y")[2..3]}" + "#{rand.to_s[2..6]}"
          @auth_user.save!
        end
        session[:user_id] = @auth_user.id
        format.html { 
          redirect_to '/dashboard', notice: "Logged in as #{current_user.first_name} #{current_user.last_name}" 
        }
      end
    rescue StandardError
      redirect_to '/login', notice: 'App Error'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login', notice: 'Logged out!'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
