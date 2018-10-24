
(function() {
  App.messages = App.cable.subscriptions.create('MessagesChannel', {  
    received: function(data) {
      console.log(data);
      if (data.notify){
       $.smallBox({
	  title:"公有消息",   
     	  content : "<i>" + data.message + "</i>",
          color : "#659265",
          icon : "fa fa-bell shake animated",
          timeout : 4000
        });

      } 
      else{
        $("#content").hide();  
        $("#publicmessage").show();
	$("#realtimelog").append( data.message )
//var messages = $(".realtimelog");
        var messages = document.getElementById('realtimelog');
        var shouldScroll = messages.scrollTop + messages.clientHeight === messages.scrollHeight;
        if (!shouldScroll) {
	  messages.scrollTop = messages.scrollHeight;
	}
        if  (data.message == "broadcastfinish"){
          //$("#realtimelog").html('')
          //$("#publicmessage").hide()
          //$("#content").show();
          $.smallBox({
            title:"公有消息",
            content : "<i>" + "show data finish" + "</i>",
            color : "#659265",
            icon : "fa fa-bell shake animated",
            timeout : 4000
          });

	}
      }
      //$("#messages").removeClass('hidden')
      //return $('#messages').append(this.renderMessage(data));
    },
    connected: function() {
      console.log("con message data")
    },
    disconnected: function() {
      console.log("dis con message data")
    },

    renderMessage: function(data) {
      return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
    }
  });
}).call(this);
