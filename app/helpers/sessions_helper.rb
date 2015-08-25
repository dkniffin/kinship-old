module SessionsHelper
  def authorize_user(role=User::ROLE_MEMBER)
    if ! signed_in?
      redirect_to root_url, notice: "You must be signed in to access this content"
    elsif current_user.authorized?(role)
      redirect_to :back, notice: "You are not authorized to access this content"
    end
  end
end
