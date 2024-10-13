class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Require authentication for all actions by default
  before_action :authenticate_user!

  # Handle unauthorized access
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "No tienes permiso para realizar esta acción."
  end

  # Redirect user after signing in
  def after_sign_in_path_for(resource)
    root_path
  end

  # Redirect user after signing out
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
