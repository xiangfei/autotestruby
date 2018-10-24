module MessageHelper
  def broadcastmessage(message, ispublic = true, notify = true)
    message = message.force_encoding("utf-8")
    #message = message.encode("ASCII-8BIT:utf-8", invalid: :replace, undef: :replace, replace: '?')
    if ispublic
      ActionCable.server.broadcast "messages", {message: message, notify: notify}
    else
      ActionCable.server.broadcast current_user.email, {message: message, notify: notify}
    end
  end

  def sendprivatemessage(message, sendemail, displaydiv, usermail, chat = true)
    message = message.force_encoding("utf-8")
    ActionCable.server.broadcast sendemail, {message: message, displaydiv: displaydiv, receiveemail: sendemail, sendemail: usermail, chat: chat}
  end

  def runtestcaselogmessage(message, app  , appname)
    message = message.force_encoding("utf-8")
    ActionCable.server.broadcast current_user.email  , {message: message,  app: app  , appname: appname}
  end
end
