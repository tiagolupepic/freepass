module AdminAuthenticator
  def authenticate!
    redirect_to(routes.new_auth_path) unless session[:admin].present?
  end

  def login(admin)
    session[:admin] = admin
  end

  def logout!
    session[:admin] = nil
  end
end
