class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    create
  end

  private

    def create
      auth_params = request.env["omniauth.auth"]
      provider = auth_params.provider

      authentication = AuthIdentity.where(uid: auth_params.uid, provider: provider).first
      if authentication
        sign_in_with_existing_authentication(authentication)
      elsif user_signed_in?
        create_authentication_and_sign_in(auth_params, current_user)
      else
        create_user_and_authentication_and_sign_in(auth_params, provider)
      end
    end

    def sign_in_with_existing_authentication(authentication)
      flash[:notice] = 'Signed in successfully!'
      sign_in_and_redirect(:user, authentication.user)
    end

    def create_authentication_and_sign_in(auth_params, user)
      flash[:notice] = 'Authentication added. You are now signed in!'
      AuthIdentity.create_from_omniauth(auth_params, user)

      sign_in_and_redirect(:user, user)
    end

    def create_user_and_authentication_and_sign_in(auth_params, provider)
      user = User.create_from_omniauth(auth_params)
      if user.valid?
        flash[:notice] = 'Registration Successful. You are now signed in!'
        create_authentication_and_sign_in(auth_params, user)
      else
        flash[:error] = user.errors.full_messages.first
        redirect_to new_user_registration_url
      end
    end
end
