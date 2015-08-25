module SessionsHelper
  def authorize_user
    unless signed_in? && current_user.authorized?(User::ROLE_MEMBER)
      redirect_to sign_in, notice: "You must be signed in to an approved account to access this content"
    end
  end
end
