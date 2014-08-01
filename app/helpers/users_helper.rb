module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url,alt: 'pic unavailaible',class: 'gravatar')
  end

  def no_of_microposts(user)
    pluralize(user.microposts.count,'micropost')
  end
end
