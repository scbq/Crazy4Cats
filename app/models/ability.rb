class Ability
  include CanCan::Ability

  def initialize(user)
    # Define default guest permissions (unauthenticated users)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all # Admin puede hacer cualquier cosa
    else
      can :read, :all # Usuarios normales pueden leer todos los recursos
      can :create, Post # Usuarios pueden crear posts
      can [:update, :destroy], Post, user_id: user.id # Solo pueden modificar o eliminar sus propios posts
      can :create, Comment # Usuarios pueden crear comentarios
      can [:update, :destroy], Comment, user_id: user.id # Solo pueden modificar o eliminar sus propios comentarios
    end
  end
end
