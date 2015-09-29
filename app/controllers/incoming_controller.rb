class IncomingController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

  def create
   params.inspect
  def create
    # Check if user is nil, if so, create and save a new user
    parsed_email = name_and_email_from( params[:sender] )
    name = parsed_email.display_name.present? ? parsed_email.display_name : ''
    email = parsed_email.address
    
    if email
      user = User.find_by( email: email )
      if user.nil?
        user = User.new(name: name , email: email, password: "helloworld", password_confirmation: "helloworld") 
        user.skip_confirmation!
        user.save!
      end
    end
    
    # Check if the topic is nil, if so, create and save a new topic
    title = params[:subject]
    if user && title
      topic = user.topics.find_or_create_by( title: title )
    end 

    # Now that you're sure you have a valid user and topic, build and save a new bookmark 
    url = params["body-plain"]
    if user && topic && url
      bookmark = Bookmark.create(url: url, topic: topic)
      bookmark.save!
    end

    head 200
  end
  
private 

  def name_and_email_from( email_from_field )
    raw_addresses = Mail::AddressList.new( email_from_field )
    raw_addresses.addresses[0]
  end
    head 200
  end
end