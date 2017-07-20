var socket;
var socketToken;
var disconnectTime;
var popup_alarm;
var elemen_alarmt;
function init_alarm(){
  var alarmRtEnabled = getAlarmEnabled();
  if(alarmRtEnabled){
	// Initialize variables
	  var connected = true;
	  var username = getAlarmUser();
//	  var socket = io('ws://192.168.1.185:3001/alarm-msg');
	  socket = io(getAlarmServer());
	  
	  // Whenever the server emits 'new message', update the chat body
	  socket.on('dtsAlarm', function (data) {
		showAlarm(data,"dts");
		//处理报警
		//console.log('dtsAlarm:'+data);
	  });
	  
	  // Whenever the server emits 'new message', update the chat body
	  socket.on('dvsAlarm', function (data) {
		showAlarm(data,"dvs");
		//处理报警
		//console.log('dvsAlarm:'+data);
	  });
	  socket.on('methaneAlarm', function (data) {
			showAlarm(data,"methane");
			//处理报警
			//console.log('dtsAlarm:'+data);
		  });
	  socket.on('heartBeat', function (data) {
		  //通过心跳记录最后运行时间
		  disconnectTime = data.runtime;
	  });
	  
	  socket.on('connect',function(){
		  //发送提示消息
		  console.log('连接成功' + new Date());
	  });
	  socket.on('connecting',function(){
		  //发送提示消息
		  console.log('正在连接' + new Date());
	  });
	  socket.on('disconnect',function(){
		  //发送提示消息
		  console.log('服务器连接断开' + new Date());
	  });
	  socket.on('connect_failed',function(){
		  //发送提示消息
		  console.log('连接失败' + new Date());
	  });socket.on('error',function(){
		  //发送提示消息
		  console.log('错误发生，并且无法被其他事件类型所处理' + new Date());
	  });
	  socket.on('message',function(){
		  //发送提示消息
		 // console.log('同服务器端message事件');
	  });
	  socket.on('anything',function(){
		  //发送提示消息
		  //console.log('同服务器端anything事件');
	  });
	  socket.on('reconnect_failed',function(){
		  //发送提示消息
		  console.log('重连失败' + new Date());
	  });
	  socket.on('reconnect',function(){
		  //发送提示消息
		  console.log('重连成功' + new Date());
		  socket.emit('user reconnect', {'username':username,'token':socketToken,'disconnectTime':disconnectTime});
		  
	  });
	  socket.on('reconnecting',function(){
		  //发送提示消息
		  console.log('正在重连' + new Date());
	  });
	  socket.on('token',function(token){
		  //首次连接返回token
		  socketToken = token;
	  });
	  
	  socket.emit('add user', {'username':username,'token':socketToken});
  }else{
	 // console.log('message config alarmEnabled:'+alarmRtEnabled);
  }	
}

$(function() {
	setTimeout("init_alarm();",2000);
});

