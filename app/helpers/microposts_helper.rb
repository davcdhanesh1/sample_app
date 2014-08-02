module MicropostsHelper
  def no_of_feeds(user)
    pluralize(user.feeds.count,'feed')
  end
end
