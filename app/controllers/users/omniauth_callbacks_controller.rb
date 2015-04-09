class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def facebook_async
    @user = User.from_omniauth_async(params)

    if @user.persisted?
      puts "Good, it persisted!"
      sign_in(:user, @user)
      render :js => "console.log('Logged in as " + current_user.email + " by devise!');"
    else
      puts "Something went wrong :( user wasnt created."
      session["devise.facebook_data"] = params
      render :js => "console.log('User was not created... :(');"
    end
  end
end
