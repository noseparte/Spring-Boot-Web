var socket;
var socketToken;
var disconnectTime;
$(function() {
  var msgEnabled = getMessageEnabled();
  if(msgEnabled){
	// Initialize variables
	  var connected = false;
	  var username = getMessageUser();
	  //var socket = io('ws://localhost:3000/sys-msg');
	  socket = io(getMessageServer());
	  
	  
	  // Whenever the server emits 'new message', update the chat body
	  socket.on('new message', function (data) {
		showMessage(data);
		//readMessage(data);
	  });
	  
	  socket.on('heartBeat', function (data) {
		  //通过心跳记录最后运行时间
		  disconnectTime = data.runtime;
	  });
	  
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
	  });socket.on('error',function(){
		  //发送提示消息
		  console.log('错误发生，并且无法被其他事件类型所处理');
	  });
	  socket.on('message',function(){
		  //发送提示消息
		  console.log('同服务器端message事件');
	  });
	  socket.on('anything',function(){
		  //发送提示消息
		  console.log('同服务器端anything事件');
	  });
	  socket.on('reconnect_failed',function(){
		  //发送提示消息
		  console.log('重连失败');
	  });
	  socket.on('reconnect',function(){
		  //发送提示消息
		  console.log('重连成功');
		  socket.emit('user reconnect', {'username':username,'token':socketToken,'disconnectTime':disconnectTime});
		  
	  });
	  socket.on('reconnecting',function(){
		  //发送提示消息
		  console.log('正在重连');
	  });
	  socket.on('token',function(token){
		  //首次连接返回token
		  socketToken = token;
	  });
	  
	  socket.emit('add user', {'username':username,'token':socketToken});
  }else{
	  console.log('message config msgEnabled:'+msgEnabled);
  }	
});


