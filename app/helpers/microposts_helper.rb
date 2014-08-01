module MicropostsHelper
  def no_of_microposts(user)
    pluralize(user.microposts.count,'micropost')
  end
end
