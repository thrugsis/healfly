class SessionsController < Clearance::SessionsController
  # include ClearanceModule

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
    @previous_page = URI(request.referer).path
    render template: "sessions/user_sign_in"
  end

  def user_login_success

      @user = authenticate(params)
      sign_in(@user) do |status|
        if status.success?
          @user 
          redirect_to @previous_page
        else
          flash[:notice] = "There is no record of your email or password"
          render :new
        end
      end
  end

  def destroy
    sign_out
    redirect_to URI(request.referer).path
  end

  def provider_sign_in
    @provider = Provider.new
    render template: "sessions/provider_sign_in"
  end

  private

  def user_params
    params.require(:session).permit(:username, :password)
  end
  #NO LONGER USING - WAS FOR CUSTOM ROUTES /sign_in/user & /sign_in/provider
  # def user_login_success

  #     @user = authenticate(params)
  #     sign_in(@user) do |status|
  #       if status.success?
  #         @user 
  #         redirect_to "/"
  #       else
  #         flash[:notice] = "There is no record of your email or password"
  #         render :new
  #       end
  #     end
  # end

  # def destroy
  #   sign_out
  #   redirect_to URI(request.referer).path
  # end

  # def provider_sign_in
  #   @provider = Provider.new
  #   render template: "sessions/provider_sign_in"
  # end

  # private

  # def user_params
  #   params.require(:session).permit(:username, :password)
  # end
end