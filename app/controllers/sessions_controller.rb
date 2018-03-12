class SessionsController < Clearance::SessionsController
  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    # if: previously already logged in with OAuth
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    # else: user logs in with OAuth for the first time
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # you are expected to have a path that leads to a page for editing user details
      @next = root_url
      @notice = "User created"
    end

    sign_in(user)
    redirect_to root_path, :notice => @notice
  end

  def user_sign_in
    @user = User.new
    render template: "sessions/user_sign_in"
  end

  def user_login_success
    byebug

    @user = authenticate(params)
    sign_in(@user) do |status|
      if status.success?
        @user 
        redirect_to "/"
      else
        flash[:notice] = "Sorry. You are not allowed to perform this action."
      end
    end
  end

  def provider_sign_in
    @provider = Provider.new
    render template: "sessions/provider_sign_in"
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end