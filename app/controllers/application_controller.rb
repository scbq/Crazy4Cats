class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Requiere autenticación para todas las acciones excepto las del controlador `HomeController`
  before_action :authenticate_user!, unless: :devise_controller?

  # Maneja acceso no autorizado
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "No tienes permiso para realizar esta acción."
  end

  # Redirigir al usuario después de iniciar sesión
  def after_sign_in_path_for(resource)
    posts_path
  end

  # Redirigir al usuario después de cerrar sesión
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # Evitar que los usuarios autenticados accedan a las páginas de login o registro
  before_action :redirect_if_authenticated, if: :devise_controller?

  private

  def redirect_if_authenticated
    if user_signed_in? && (is_a?(Devise::SessionsController) || is_a?(Devise::RegistrationsController))
      redirect_to posts_path, alert: "Ya has iniciado sesión."
    end
  end
end
