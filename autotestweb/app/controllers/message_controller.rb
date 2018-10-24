class MessageController < ApplicationController
  include MessageHelper

  def sendmessage
    message = params[:message]
    sendemail = params[:sendemail]
    displaydiv = params[:displaydiv]
    puts params
    sendprivatemessage(message, sendemail, displaydiv, current_user.email, chat = true)

    head :ok
  end
end
