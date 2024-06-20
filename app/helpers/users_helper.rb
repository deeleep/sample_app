module UsersHelper
    # This method fetches the Gravatar image for the user
   
    def gravatar_for(user, size: 80 )
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase) # Hash the user's email
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id} ?s= #{ size }" # Create URL for Gravatar image
      image_tag(gravatar_url, alt: user.name, class: "gravatar") # Return HTML tag for the image
    end
end

