class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # Redirigimos a los posts solo si el usuario está autenticado Y se accede directamente
    redirect_to posts_path if user_signed_in? && request.path == root_path
  end
end
