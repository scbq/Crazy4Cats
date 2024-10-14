class Ability
  include CanCan::Ability

  def initialize(user)
    # Usuarios no autenticados (visitantes) solo pueden leer los posts y los comentarios
    if user.nil?
      can :read, Post
      can :read, Comment
    else
      # Usuarios autenticados pueden gestionar sus propios posts y comentarios
      can :manage, Post, user_id: user.id
      can :manage, Comment, user_id: user.id

      # Usuarios autenticados pueden leer todos los posts y comentarios
      can :read, Post
      can :read, Comment

      # Usuarios autenticados pueden dar like y dislike a los posts
      can :like, Post
      can :dislike, Post
    end
  end
end
