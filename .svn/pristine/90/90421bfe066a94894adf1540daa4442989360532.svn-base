var socket;

function init_alarm(){
//  var socket = io('ws://192.168.199.153:3001/alarm-msg');
	
	
	
	
  var socket = io(getMessageServer());
  
 
  socket.on('connect',function(){
          //发送提示消息
          console.log('连接成功');
  });
  socket.on('connecting',function(){
      //发送提示消息
      console.log('正在连接');
  });
  socket.on('disconnect',function(){
      //发送提示消息
      console.log('服务器连接断开');
  });
  socket.on('connect_failed',function(){
      //发送提示消息
      console.log('连接失败');
  });
  socket.on('error',function(){
      //发送提示消息
      console.log('错误发生，并且无法被其他事件类型所处理');
  });

  socket.on('reconnect_failed',function(){
          //发送提示消息
          console.log('重连失败');
  });
  socket.on('reconnect',function(){
      //发送提示消息
      console.log('重连成功');
      
  });
  socket.on('reconnecting',function(){
      //发送提示消息
      console.log('正在重连');
  });

  socket.on('msg',function(msg){
     parseMsg(msg);
  });

  socket.emit('registBoard','board connected');

}

$(function() {
    setTimeout("init_alarm();",1);
});



