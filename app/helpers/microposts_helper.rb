module MicropostsHelper
  def no_of_ideas(user)
    pluralize(user.ideas.count,'idea')
  end
end
