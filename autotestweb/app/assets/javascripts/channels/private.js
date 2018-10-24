
(function() {
  App.messages = App.cable.subscriptions.create('PrivateChannel', {  
    received: function(data) {
      console.log(data);
      if (data.notify){
       $.smallBox({
          title:"私有消息",
     	  content : "<i>" + data.message + "</i>",
          color : "#3276B1",
          icon : "fa fa-bell fadeInRight animated",
          //number : "2",
          timeout : 4000
        });

      } 
      else if (data.chat){
       
        var message = data.message;
	var displaydiv = data.displaydiv;
	var sendemail = data.sendemail;
        var chatboxdivid = "#" + displaydiv;
        var receiveemail =  data.receiveemail;	
        $(chatboxdivid).chatbox({id: displaydiv, 
	  user:{key : sendemail},
	  title : sendemail ,
	  messageSent : function(id, user, msg) { 
            $.get("/sendmessage?message=" + msg + "&sendemail=" + sendemail + "&displaydiv=" + displaydiv , function(result){
	      $(chatboxdivid).chatbox("option", "boxManager").addMsg(receiveemail, msg);
	    });
	  }
        });
	$(chatboxdivid).chatbox("option", "boxManager").addMsg(sendemail, message);
        if ( $(chatboxdivid).hasClass("initi")) {
	}
	else{
	   $(chatboxdivid).addClass("initi"); 
	}
	$(chatboxdivid).closest(".ui-chatbox").show(); 

      } 
      else if (data.app) {
        //$("#content").hide();
        //$("#deploymessage").show();
        //$("#"+  data.app  + "app").append( data.message )
        // var messages = document.getElementById(data.app  + "app");
        try {
          var messages = document.getElementById(data.app  + "app");
	  var shouldScroll = messages.scrollTop + messages.clientHeight === messages.scrollHeight;
          $("#content").hide();
          $("#deploymessage").show();  
          $("#"+  data.app  + "app").append( data.message )
          if (!shouldScroll) {
	    messages.scrollTop = messages.scrollHeight;
          }
	}
        catch (e) {
          //console.log(e)
          $("#content").show();
	  $("#deploymessage").hide();

	}	
        if (data.message == "broadcastfinish"){
          //后台广播测试用例执行完成，前端不需要处理
          // $("#content").show();
          // $("#deploymessage").hide();
          //$.smallBox({
          //  title:"私有消息",
          //  content : "<i>" + "测试用例" +  data.appname + "执行完成" + "</i>",
          //  color : "#3276B1",
          //  icon : "fa fa-bell fadeInRight animated",
            //number : "2",
          //  timeout : 4000
          //});

        }

      }
      else{
        $("#content").hide();  
        $("#privatemessage").show();
      	$("#privaterealtimelog").append( data.message )
        var messages = document.getElementById('privaterealtimelog');
        var shouldScroll = messages.scrollTop + messages.clientHeight === messages.scrollHeight;
	if (!shouldScroll) {
	  messages.scrollTop = messages.scrollHeight;
	}

        if (data.message == "broadcastfinish"){
          //$("#privaterealtimelog").html('')
          //$("#privatemessage").hide()
          //$("#content").show();
          $.smallBox({
            title:"私有消息",
            content : "<i>" + "show data finish" + "</i>",
            color : "#3276B1",
            icon : "fa fa-bell fadeInRight animated",
            //number : "2",
            timeout : 4000
          });

        }
      }

		  
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
