module SessionsHelper
  def authorize_user(role=User::ROLE_MEMBER)
    if ! signed_in?
      redirect_to new_user_session_path, notice: "You must be signed in to access this content"
    elsif ! current_user.authorized?(role)
      redirect_to root_url, notice: "You are not authorized to access this content"
    end
  end
end
