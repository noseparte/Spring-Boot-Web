/*
--- 
fn: NPPILY
desc: NPPluginSDK中间层
time: 2013.09.04 10:20:00
version: v2015.01.15.001 Beta.
author:
    - zenghx
    - huzw
remark: 
    - for NPPInterlayer.js 
...
*/
var NPPILY = 
{
    publishType : "public", 
	
	version : "v2015.01.15.001 Beta",
	
	lastNCVersion : "7.2.15.0504",
	
	agt : navigator.userAgent.toLowerCase(), 
	
    browserType : "IE", // - IE | Chrome | FireFox | Other
    Connections : new NPPUtils.Hash(), // - 存储所有连接信息
    WindowContainers : new NPPUtils.Hash(), // - 存储所有窗口信息	
	// - puid reg
	puidRex: /^[A-Za-z0-9]+$/i,
    // - 整数 reg 	
    intRex: /^-?\d+$/,
	
    /*
    *    fn    :    NPPILY.PluginHtml
    *    Des    :    Create Plugin Object
    *    Date:    2013.09.04
    *    @author zenghx
    */
    // - 插件对象
    Plug : 
    {
        inited : false, nc : null, wnd : null, wa : null, // - 插件容器
        boxDomId : "NPP_nppluginsbox", Html : 
        {
            nc : "<OBJECT id=\"@id\" name=\"@name\" type=\"application/x-nc7plugin\" style=\"width:0px;height:0px;border:0px solid red;\"></OBJECT>", 
            wnd : "<OBJECT id=\"@id\" name=\"@name\" type=\"application/x-pwplugin\" style=\"width:0px;height:0px;border:0px solid #FFFFFF;\"></OBJECT>",
			wa : "<OBJECT id=\"@id\" name=\"@name\" type=\"application/x-waplugin\" style=\"width:0px;height:0px;border:0px solid #FFFFFF;\"></OBJECT>",
            get : function (objName) 
            {
                switch (objName) 
                {
                    case "nc":
                        return this.nc;
                        break;
                    case "wnd":
                        return this.wnd;
                        break;
                    case "wa":
                        return this.wa;
                        break;
                    default:
                        return "";
                        break;
                }
            },
            end : true 
        },
        // - 温馨提示
        Error : 
        {
            domid : "NPP_nppWarmTipBox", active : false, pluginFile : "MediaPlugin7.exe", html : "",
            tip : function (html, errorCode) 
            {
				try
				{
					var fn = "NPPILY.Plug.Error.tip";
					
					if (this.active == false)
					{
						NPPUtils.Log(fn, "warm tip active false~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
					}
					
					if (!document.getElementById(this.domid)) 
					{
						var warmbox = document.createElement("DIV");
						warmbox.setAttribute("id", this.domid);
						warmbox.style.zIndex = "99999";
						warmbox.style.position = "fixed";
						warmbox.style.width = "100%";
						warmbox.style.height = "100%";
						warmbox.style.top = "0";
						warmbox.style.left = "0";
						warmbox.style.filter = "Alpha(Opacity=85)";
						warmbox.style.filter.MozOpacity = "0.8";
						warmbox.style.filter.Opacity = "0.8";
						warmbox.style.opacity = "0.85";
						warmbox.style.backgroundColor = "#C3D2EF";
						warmbox.style.color = "#990011";
						warmbox.style.fontSize = "14px";
						warmbox.style.textAlign = "left";
						warmbox.style.lineHeight = "180%";
						document.getElementsByTagName("BODY").item(0).appendChild(warmbox);
					}
					if (document.getElementById(this.domid)) 
					{
						var html = this.html || html || NPPILY.Enum["warmTip"][NPPILY.language];
						html = html.replace(/(#\(0\))/, this.pluginFile);
						
						switch (errorCode)
						{
							case NrcapError.NRCAP_ERROR_NC_NOT_LAST_VERSION :
								html = NPPILY.Enum["warmTip"]["NCNotLastVersion"][NPPILY.language];
								html = html.replace(/(#\(0\))/, this.pluginFile).replace(/(#\{PLUGIN_VERSION\})/, NPPILY.lastNCVersion);
								break;
						}				
						
						document.getElementById(this.domid).innerHTML = html;
						this.show();
					}
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				catch(e) {
					NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
           	 		return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_THREAD);	
				}
            },
            show : function () 
            {
                if (document.getElementById(this.domid)) {
                    document.getElementById(this.domid).style.display = "block";
                }
            },
            hide : function () 
            {
                if (document.getElementById(this.domid)) 
                {
                    document.getElementById(this.domid).style.display = "none";
                    document.getElementById(this.domid).parentNode.removeChild(document.getElementById(this.domid));
                }
            },
            end : true 
        },
        end : true 
    },
    /*
    ---
    fn: Init 
    desc: 初始化插件 
    author:
        - zenghx  
    time: 2013.09.04 
	mdftime: 2014.03.31
    returns: 
        - NrcapError 
    params: 
        - initParam(NPPILY.Struct.InitParamStruct) 初始化参数 
    ... 
    */
    Init : function (initParam)
    {
        try 
        {	
            var fn = "NPPILY.Init";
			
			if (NPPILY.Plug.inited != false)
			{
				NPPUtils.Log(fn, "NPPILY plugins had inited success~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
			}
			
            if (!initParam || !initParam instanceof NPPILY.Struct.InitParamStruct) 
			{
                initParam = new NPPILY.Struct.InitParamStruct();
            }
            // - 判断浏览器类型
            var _agt = NPPILY.agt || navigator.userAgent.toLowerCase();
            if (_agt.search("msie") != - 1 || _agt.search("trident") != - 1) {
                NPPILY.browserType = NPPILY.Enum.BrowserType.IE;
            }
            else if (_agt.search("chrome") != - 1) {
                NPPILY.browserType = NPPILY.Enum.BrowserType.Chrome;
            }
            else if (_agt.search("firefox") != - 1) {
                NPPILY.browserType = NPPILY.Enum.BrowserType.FireFox;
            }
            else {
                NPPILY.browserType = NPPILY.Enum.BrowserType.Other;
            }
            // - 初始化调试对象
            NPPILY.Debug.Init(initParam);
            // - 语言风格
            var _language = initParam.language || NPPILY.language;
            if (!NPPILY.Enum.LanguageType[_language]) {
                _language = NPPILY.Enum.LanguageType.zh_CN;
            }
			NrcapError.language = NPPILY.language = _language;
            
			// - 温馨提示处理
			NPPILY.Plug.Error.active = initParam.warmTip.active || false;
			NPPILY.Plug.Error.pluginFile = initParam.warmTip.pluginFile || "MediaPlugin7.exe";
			NPPILY.Plug.Error.html = initParam.warmTip.html || "";
			
            // - 检测插件是否加载完成
            var nc = NPPILY.Plug.Html.get("nc").replace(/(@id)|(@name)/g, "NPPILYNC");
            var wnd = NPPILY.Plug.Html.get("wnd").replace(/(@id)|(@name)/g, "NPPILYWND");
			var wa = NPPILY.Plug.Html.get("wa").replace(/(@id)|(@name)/g, "NPPILYWA");
			
            if (!document.getElementById(NPPILY.Plug.boxDomId)) 
            {
                var _objn3box = document.createElement("DIV");
                _objn3box.setAttribute("id", NPPILY.Plug.boxDomId);
                _objn3box.setAttribute("attention", "For np sdk private using, be sure won't remove it manually...");
                document.getElementsByTagName("body").item(0).appendChild(_objn3box);
            }
            else {
                var _objn3box = document.getElementById(NPPILY.Plug.boxDomId);
            }
            var plugins = [nc, wnd, wa];
            _objn3box.innerHTML = plugins.join("");
            if (typeof document.getElementById("NPPILYNC").Initialize == "undefined") 
            {
                NPPILY.Plug.Error.tip();
                NPPUtils.Log(fn, "NPPILY load nc error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_LOADPLUG_NC);
            }
            if (typeof document.getElementById("NPPILYWND").GetWindow == "undefined") 
            {
                NPPILY.Plug.Error.tip();
                NPPUtils.Log(fn, "NPPILY load wnd error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_LOADPLUG_WND);
            }
			if (typeof document.getElementById("NPPILYWA").DebugSwitch == "undefined")
			{
				NPPILY.Plug.Error.tip();
				NPPUtils.Log(fn, "NPPILY load wa error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_LOADPLUG_WA);
			}
				
            NPPILY.Plug.nc = document.getElementById("NPPILYNC");
            NPPILY.Plug.wnd = document.getElementById("NPPILYWND");
            NPPILY.Plug.wa = document.getElementById("NPPILYWA");
			
			// 判断NC插件版本
			if (NPPILY.Plug.nc.version != this.lastNCVersion)
			{
				NPPILY.Plug.Error.tip(null, NrcapError.NRCAP_ERROR_NC_NOT_LAST_VERSION);
                NPPUtils.Log(fn, "NPPILY load nc error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_NC_NOT_LAST_VERSION);
			}
			
            var operator = NPPIF.Initialize(NPPILY.Plug.nc);
            if (operator.rv == NrcapError.NRCAP_SUCCESS) 
            {
                NPPILY.Plug.inited = true;
				// - 初始化Folder对象
				NPPILY.Folder.Init();
                NPPUtils.Log(fn, "NPPILY plugins inited success~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
            }
            else
            {
                NPPUtils.Log(fn, "NPPILY plugins inited failed~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_UNINITIALIZED);
            }
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
        }
        catch (e) 
        {
            NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_THREAD);
        }
    },
    /*
    ---
    fn: UnLoad 
    desc: 页面卸载 
    author:
        - zenghx  
    time: 2013.09.04 
    returns: 
        - NrcapError 
    ... 
    */
    UnLoad : function () 
    {
        try 
        {
            var fn = "NPPILY.UnLoad";
            if (NPPILY.Plug.inited == true) 
            {
				if (typeof NPPUtils.Timer != "undefined" && typeof NPPUtils.Timer.Stop != "undefined")
				{
					NPPUtils.Timer.Stop();
				}
				
                var _connKeys = [];
                if (NPPILY.Connections && typeof NPPILY.Connections.keys == "function") 
                {
                    _connKeys = NPPILY.Connections.keys();
                }
                for (var i = 0; i < _connKeys.length; i++) {
                    // - 断开连接
                    NPPILY.DisConnection(_connKeys[i]);
                }
				
                if (NPPILY.Plug.nc) {
					NPPILY.Folder.UnLoad();
					NPPILY.RecordQR_Clear();
					NPPILY.NCNotifyManager.Clear();
                    NPPIF.Terminate(NPPILY.Plug.nc);
                    NPPILY.Plug.nc = null;
                    NPPILY.Plug.wnd = null;
					NPPILY.Plug.wa = null;
					NPPILY.WindowContainers = new NPPUtils.Hash();
                }
				if (document.getElementById(NPPILY.Plug.boxDomId))
				{
					document.getElementById(NPPILY.Plug.boxDomId).innerHTML = "";	
				}
                NPPILY.Plug.inited = false;
            }
            else {
                NPPUtils.Log(fn, "NPPILY not inited~");
            }
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
        }
        catch (e) 
        {
            NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_UNLOAD_NRCAPPLUG_FAILED);
        }
    },
    /*
    ---
    fn: Connect 
    desc: 新建一个连接对象，保存在Connections组里 
    author:
        - zenghx  
    time: 2013.09.04 
    returns: 
        - conn (NPPILY.Struct.ConnectionStruct)
    params: 
        - connParam(NPPILY.Struct.ConnParamStruct) 连接参数 
    ... 
    */
    Connect : function (connParam)
    {

        try
        {
            var fn = "NPPILY.Connect";
            if (!NPPILY.Plug.inited) 
            {
                NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
            }
            if (!connParam || !connParam instanceof NPPILY.Struct.ConnParamStruct)
			{
                connParam = new NPPILY.Struct.ConnParamStruct();
            }
            // - 检测某个连接地址是否已经存在
            NPPILY.Connections = NPPILY.Connections || new NPPUtils.Hash();
            var _connKeys = NPPILY.Connections.keys();
            for (var i = 0; i < _connKeys.length; i++) 
            {
				var _connId = _connKeys[i],
					_connStruct = NPPILY.Connections.get(_connId);
					 
                if (_connStruct.connParam.path == connParam.path) 
                {
					if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
					{
						NPPUtils.Log(fn, "connect connecting~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING, _connId);
					}
					else if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connected)
					{
						NPPUtils.Log(fn, "connection has built~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTED, _connId);
					}
					else
					{
						NPPUtils.Log(fn, "connect already~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTIONID_ALREADY, _connId);
					}
                }
            }
            // - 生成一个连接ID
            var doMore = false, connectId = "", $_Generate = function () 
            {
                connectId = new Date().getTime() + "" + parseInt(Math.random() * (9999 - 1000 + 1) + 1000);
            };
            do 
            {
                $_Generate();
                if (connectId && NPPUtils.Array.indexOf(_connKeys, connectId) != - 1) 
				{
                    doMore = true;
                    setTimeout(function () 
                    {
                        doMore = false;
                    }, 100);
                }
                else {
                    doMore = false;
                }
            }
            while (doMore);
            if (!connectId) 
			{
                $_Generate();
            }
            var _bfix = connParam.bFixCUIAddress = !!(connParam.bFixCUIAddress == true) ? 1 : 0;
            var _connStruct = new NPPILY.Struct.ConnectionStruct( connectId, connParam );
			_connStruct.nc = NPPILY.Plug.nc;
			_connStruct.ncName = NPPILY.Plug.nc.id || NPPILY.Plug.nc.name || "";
           
            // - 正在连接
            _connStruct.status = NPPILY.Enum.ConnectionStatus.Connecting;
			
            // - 记录连接信息
            NPPILY.Connections.set(connectId, _connStruct);
			
            var operator = NPPIF.Connect(_connStruct.nc, _connStruct.connParam);
            if (operator.rv == NrcapError.NRCAP_SUCCESS) 
            {
                _connStruct.status = NPPILY.Enum.ConnectionStatus.Connected;
                _connStruct.session = operator.response;
				
				// - 获取平台类型
				var operator = NPPILY.GetPlatformType(connectId);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					_connStruct.connType = operator.response;
				}
				// - 获取用户连接ID（CUID）
				var operator = NPPILY.GetCUSessionID(connectId);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					_connStruct.CUID = operator.response;
				}
				// - 获取系统名称
				var operator = NPPILY.GetSystemName(connectId);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					_connStruct.systemName = operator.response;
				}
				// - 获取用户优先级
				var operator = NPPILY.GetUserPriority(connectId);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					_connStruct.userPriority = operator.response;
				}
				// - 获取子域
				var operator = NPPILY.GetDomainRoad(connectId); 
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					_connStruct.domainRoad = operator.response;
				}
				
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, connectId);
            }
            else
            {
                _connStruct.status = NPPILY.Enum.ConnectionStatus.Failed;
                NPPUtils.Log(fn, "connect failed");
				NPPILY.DisConnection(connectId);
                return new NPPILY.Struct.ReturnValueStruct(operator.rv);
            }
        }
        catch (e)
        {
            NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
        }
    },
	// - 获取登录的平台类型
	GetPlatformType : function (connectId)
	{
		var operator = NPPILY.NPPSDKCommon.GetNCResponse(connectId, "GetPlatformType");
		if (operator.rv == NrcapError.NRCAP_SUCCESS)
		{
			operator.response = NPPILY.Enum.ConnectionType[(operator.response == 0 ? "Server" : "Device")];
		}
		return operator;
	},
	// - 获取用户连接ID（CUID）
	GetCUSessionID : function (connectId)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, "GetCUSessionID");
	},
	// - 获取平台名称
	GetSystemName : function (connectId)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, "GetSystemName");
	},
	// - 获取用户优先级
    GetUserPriority : function (connectId) 
    {
        return NPPILY.NPPSDKCommon.GetNCResponse(connectId, "GetPriority");
    },
	// - 获取子域
	GetDomainRoad : function (connectId)
	{
		var operator = NPPILY.NPPSDKCommon.GetNCResponse(connectId, "GetSubDomain"); 
		if (operator.rv == NrcapError.NRCAP_SUCCESS)
		{
			var subdm = [];
			for (var i = 0; i < operator.response.length; i++)
			{
				subdm.push(NPPUtils.UTF8toUnicode(operator.response[i]));	
			}
			operator.response = subdm;	
		}
		return operator;
	},
	
    /*
    ---
    fn: DisConnection 
    desc: 断开一个连接对象，从Connections组里清除
    author:
        - zenghx  
    time: 2013.09.04 
    returns: 
        - NrcapError 
    params: 
        - connectId 连接ID 
    ... 
    */
    DisConnection : function (connectId)
    {
        try
        {
            var fn = "NPPILY.DisConnection";
            if (!NPPILY.Plug.inited) 
            {
                NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
            	return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
            }
            if (!connectId || !NPPILY.Connections.get(connectId)) 
			{
                NPPUtils.Log(fn, "connectId error~");
            	return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
            }
            else 
            {
                var _connStruct = NPPILY.Connections.get(connectId);
                // NPPUtils.Log(fn, _connStruct.session);
                if (_connStruct instanceof NPPILY.Struct.ConnectionStruct) 
                {
                    if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Idle && _connStruct.session) 
                    {
						// - 清空喊话或对讲信息
						NPPILY.CallTalkControl.Clear(connectId);
						
						// - 停止下载信息
						NPPILY.Download.Clear(connectId);
						
						// - 停止视频
						if(NPPILY.WindowContainers instanceof NPPUtils.Hash) 
						{
							NPPILY.WindowContainers.each
							(
							 	function(item) 
								{
									var winObj = item.value.window;
									
									if(winObj && winObj instanceof NPPILY.Struct.WindowStruct) 
									{
										if (winObj.status.playvideoing)
										{
											NPPILY.StopVideo(winObj);
										}
										else if (winObj.status.playvoding)
										{
											NPPILY.StopVod(winObj);
										}
									} 
								}
							);
						}
						
                        NPPIF.DisConnection(_connStruct.nc, _connStruct.session);
                       	
                        _connStruct.session = null;
                        _connStruct.status = NPPILY.Enum.ConnectionStatus.Idle;
                    }
					
                    NPPILY.Connections.unset(connectId);
                }
            }
			
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
        }
        catch (e) { 
            NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
    },
	
	/*
	---
	fn: NCNotifyManager
	time: 2013.09.10
	author:
		- huzw
	remark:
		- 管理NC的绑定事件信息
	...
	*/
	NCNotifyManager : 
	{
		Store : new NPPUtils.Hash(),
		
		/*
		---
		fn : Clear
		desc : 清空事件
		time : 2013.11.06
		author : 
			- huzw
		remark :
			- 在NPPILY.UnLoad时调用一次即可
		...
		*/
		Clear : function ()
		{
			try
			{
				var fn = "NPPILY.NCNotifyManager.Clear";
				
				if (!NPPILY.Plug.inited) 
				{
					NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
				}
				
				if (NPPILY.NCNotifyManager.Store && NPPILY.NCNotifyManager.Store instanceof NPPUtils.Hash)
				{
					NPPILY.NCNotifyManager.Store.each
					(
					 	function(item, index)
						{
							if (NPPILY.Plug.nc != null)
							{
								NPPIF.DetachObjectEvent(NPPILY.Plug.nc, item.value.name, item.value.callback);	
							}
						}
					);
					
					NPPILY.NCNotifyManager.Store = new NPPUtils.Hash();
				}
				
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		/*
		---
		params:	
			- name(NPPILY.Enum.NCObjectNotify)
			- callbach(function name) 回调函数
		...
		*/
		Add : function (name, callback)
		{
			try
			{
            	var fn = "NPPILY.NCNotifyManager.Add";
				
				if (!NPPILY.Plug.inited) 
				{
					NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
				}
				
				if (!callback || typeof callback != "function")
				{
					NPPUtils.Log(fn, "callback error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);		
				}
				
				var found = false;
				for (var key in NPPILY.Enum.NCObjectNotify)
				{
					var node = NPPILY.Enum.NCObjectNotify[key];
					if (node == name)
					{
						found = true;
						break;
					}
				}
				
				if (!name || !found)
				{
					NPPUtils.Log(fn, "name undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
				} 
				 
				if (!NPPILY.NCNotifyManager.Store.get(name))
				{	
					var evtCallBack = function(args1, args2, args3, args4) 
					{
						try
						{
							var _ncnStruct;
							switch(name)
							{
								case NPPILY.Enum.NCObjectNotify.event_notify :
								 	_ncnStruct = new NPPILY.Struct.NCObjectNotifyStruct
									(
										name, 
										args1, 
										null, 
										args2,
										(args3 ? eval("("+args3+")") : "")
									);
									break;
								case NPPILY.Enum.NCObjectNotify.stream_status_notify :
									_ncnStruct = new NPPILY.Struct.NCObjectNotifyStruct
									(
										name, 
										args1, 
										args2, 
										args3, 
										(args4 ? eval("("+args4+")") : "")
									);
									break;
								case NPPILY.Enum.NCObjectNotify.gps_data_notify :
									_ncnStruct = new NPPILY.Struct.NCObjectNotifyStruct
									(
										name, 
										args1, 
										null, 
										null, 
										(args2 ? eval("("+args2+")") : "")
									); 
									break;
								case NPPILY.Enum.NCObjectNotify.copy_file_notify :
									var args4 = args4 < 0 ? -1 : args4;
									_ncnStruct = new NPPILY.Struct.NCObjectNotifyStruct
									(
										name,
										null,
										null,
										null,
										{
											localFilePath: args1,
											currentBytes: args2,
											currentTime: args3,
											status: args4,
											statusDesc: NPPILY.Enum.RecordQRCopyFileStatusDesc[args4][NPPILY.language]
										}
									);
									break;
							}
							if (typeof _ncnStruct != "undefined") {
								callback(_ncnStruct);	
							}
						}
						catch(ee) {
							NPPUtils.Log("NPPILY.NCNotifyManager->evtCallBack", "excp error = " + ee.message + "::" + ee.name);
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);	
						} 
					};
					
					var operator = NPPIF.AttachObjectEvent(NPPILY.Plug.nc, name, evtCallBack);
					
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						// - 把绑定的信息记录下来
						NPPILY.NCNotifyManager.Store.set
						(
							name, 
							{
								key : name,
								callback : evtCallBack || function() {},
								active : true
							}
						);
					}
					else
					{
						NPPUtils.Log(fn, "add error, name = " + name);
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);		
					}
				}
				
            	return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS); 
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		// - 移除绑定事件
		Remove : function (name /*, callback */)
		{
			try
			{
            	var fn = "NPPILY.NCNotifyManager.Remove";
				
				if (!NPPILY.Plug.inited) 
				{
					NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
				}
				
				var found = false;
				for (var key in NPPILY.Enum.NCObjectNotify)
				{
					var node = NPPILY.Enum.NCObjectNotify[key];
					if (node == name)
					{
						found = true;
						break;
					}
				}
				
				if (!name || !found)
				{
					NPPUtils.Log(fn, "name undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
				} 
				
				if (NPPILY.NCNotifyManager.Store.get(name))
				{		
					var _ncevtNode = NPPILY.NCNotifyManager.Store.get(name);
					if (_ncevtNode.key == name && typeof _ncevtNode.callback == "function")
					{
						var operator = NPPIF.DetachObjectEvent(NPPILY.Plug.nc, name, _ncevtNode.callback);
					
						if (operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							// - 把绑定的信息移除
							NPPILY.NCNotifyManager.Store.remove(name); 
						}
						else
						{
							NPPUtils.Log(fn, "remove error, name = " + name);
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);		
						}
					} 
				}
				
            	return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS); 
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		// - 更新绑定事件
		Update : function (name, callback)
		{
			try
			{
            	var fn = "NPPILY.NCNotifyManager.Update";
				 
				var operator = NPPILY.NCNotifyManager.Remove(name);
				if (operator.rv != NrcapError.NRCAP_SUCCESS)
				{
					return operator;
				}
				
				return NPPILY.NCNotifyManager.Add(name, callback);
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		end : true
	},
	
	/*
	---
	fn: ForkResource
	desc: 获取或构建设备（子）资源
	author:
		- huzw
	time: 2013.09.05
	returns: 
		- succ <response: Array(...)>
		- error NrcapError
	params: 
		- connectId(string) 连接ID
		- forkLevel(NPPILY.Enum.ForkResourceLevel) 构建资源级别
		- offset(uint) 分页查询开始索引
		- count(unit) 分页查询每次最大个数
		- domainRoad(string) 子域名称（根平台使用""或null）
		- customParams(object) 自定义参数
	remark:
		- customParams => 
		{
			PUID(string) 设备PUID
			PUIDSets(string|array) 设备PUID列表
		}
		其中：customParams.PUID存在时，customParams.PUIDSets不可用
		- 直连设备时，可以只传值connectId即可；亦可以传入connectId, ..., customParams._HANDLE或PUID
		- offset, count在forkLevel=NPPILY.Enum.ForkResourceLevel.nppForkPUInfo时有效，其他查询可以取0或null
	...
	*/
	ForkResource : function(connectId, forkLevel, offset, count, domainRoad, customParams) 
	{
		try 
		{
            var fn = "NPPILY.ForkResource";
			
			if (!NPPILY.Plug.inited)
            {
                NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
            }
            
			if (!connectId || !NPPILY.Connections.get(connectId)) {
                NPPUtils.Log(fn, "connectId error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
            }
            else 
            {
				var _connStruct = NPPILY.Connections.get(connectId);
				
				if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
				{ 
                	NPPUtils.Log(fn, "login or session error~");
                	return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
				}
				
				// - 判断是直连还是服务器平台
				if (_connStruct.connType == NPPILY.Enum.ConnectionType.Device)
				{
					// - 直连设备时只能获取一个PU资源信息
					forkLevel = NPPILY.Enum.ForkResourceLevel.nppForkOnePUInfo;	
				}
				
				var offset = offset || 0, 
					count = count || 0,
					domainRoad = domainRoad || "",
					customParams = customParams || {};
				
				switch (forkLevel) 
				{
					// - PU节点信息
					case NPPILY.Enum.ForkResourceLevel.nppForkPUInfo:
						
						var operator = NPPIF.ForkPUListEx(_connStruct.nc, _connStruct.session, domainRoad, offset, count);
						var _punodeStructArr = new Array();
							
						if (operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							operator.response = operator.response || [];
							if (operator.response.constructor != Array)
							{
								operator.response = [operator.response];
							}
							
							for (var i = 0; i < operator.response.length; i++)
							{
								var pu = operator.response[i];
								
								var pns = new NPPILY.Struct.PUNodeStruct();
								pns.puid = pu.PUID;
								pns.resType = pu.Type;
								pns.resIdx = "0";
								pns.name = NPPUtils.UTF8toUnicode(pu.Name);
								pns.description = NPPUtils.UTF8toUnicode(pu.Description);
								pns.enable = pu.Enable;
								pns.online = pu.Online;
								pns.immitted = pu.Immitted;
								pns.modelName = NPPUtils.UTF8toUnicode(pu.Model);
								pns.modelType = pu.ModelType;
								pns.manufactrueID = pu.ProducerID;
								pns.hardwareVersion = pu.HardwareVersion;
								pns.softwareVersion = pu.SoftwareVersion;
								pns.deviceID = pu.DeviceID;
								pns.latitude = pu.Latitude;
								pns.longitude = pu.Longitude;
								pns._HANDLE = pu.Handle;
								pns.childResource = (pu.ChildRes || []);
 
								_punodeStructArr.push(pns);
							}
						}
						
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, _punodeStructArr);
						break;
					
					// - PU子资源信息
					case NPPILY.Enum.ForkResourceLevel.nppForkPUResourceInfo:
						
						var _punodeStructArr = new Array(),
							_puInfoSets = new Array(),
							_isPUHandle = false;
 						
						_puInfoSets = customParams._HANDLE || customParams._HANDLESets || new Array();
						if (_puInfoSets.constructor != Array)
						{
							_puInfoSets = [_puInfoSets];	
						}
						if (_puInfoSets.length > 0) 
						{
							_isPUHandle = true;	
						}
						else 
						{
							_puInfoSets = customParams.PUID || customParams.PUIDSets || new Array();
							if (_puInfoSets.constructor != Array)
							{
								_puInfoSets = [_puInfoSets];
							}
						}
							
						for (var i = 0; i < _puInfoSets.length; i++)
						{ 
							if (_isPUHandle)
							{
								var _puHandle = _puInfoSets[i];	
							}
							else
							{
								// - 获取对应的_HANDLE
								var operator = NPPIF.ForkOnePU(_connStruct.nc, _connStruct.session, _puInfoSets[i]);
								if(operator.rv != NrcapError.NRCAP_SUCCESS) 
								{
									NPPUtils.Log(fn, "1:) get handle error -> " + NrcapError.Detail(operator.rv, true) + ", obj -> " + _puInfoSets[i]);
									continue; 		
								}
								var _puHandle = operator.response;
							}
							
							if (customParams._returnMode !== "whole") 
							{
								var _punodeStruct = new NPPILY.Struct.PUNodeStruct();
							}
							else
							{
								var _punodeStruct = NPPILY.NPPSDKCommon.ForkInfoByPUHandle
								(
									connectId, 
									_puHandle
								);
								if (!_punodeStruct || !_punodeStruct instanceof NPPILY.Struct.PUNodeStruct) {
									continue;
								}
							}
							
							// - 获取子资源
							var operator = NPPIF.ForkPUResourceEx(_connStruct.nc, _puHandle);
							
							if (operator.rv == NrcapError.NRCAP_SUCCESS && operator.response === "") {
								operator = NPPIF.ForkPUResourceEx(_connStruct.nc, _puHandle);	
							}
								
							if (operator.rv != NrcapError.NRCAP_SUCCESS) 
							{ 	
								NPPUtils.Log(fn, "2:) get handle error -> " + NrcapError.Detail(operator.rv, true) + ", obj -> " + _puHandle);
								return operator;
							}
							else 
							{
								operator.response = operator.response || [];
								if (operator.response.constructor != Array)
								{
									operator.response = [operator.response];
								}
								
								for (var j = 0; j < operator.response.length; j++)
								{
									var child = operator.response[j];
									
									var prns = new NPPILY.Struct.PUResourceNodeStruct();
									prns.type = child.Type;
									prns.idx = child.Index;
									prns.name = NPPUtils.UTF8toUnicode(child.Name);
									prns.description = NPPUtils.UTF8toUnicode(child.Description);
									prns.enable = child.Enable;
									prns._HANDLE = child.Handle;
									
									_punodeStruct.childResource.push(prns);
								}
							}
							
							_punodeStructArr.push(_punodeStruct);
							
						} // end for i
						
						if (customParams._returnMode !== "whole")
						{
							var _puresStructArr = [];
							
							for(var k = 0; k < _punodeStructArr.length; k++) {
								var pns = _punodeStructArr[k].childResource || [];
								if (pns && pns.length > 0) {
									_puresStructArr.push(pns);
								}
							}
							
							return new NPPILY.Struct.ReturnValueStruct
							(
								NrcapError.NRCAP_SUCCESS, 
								(_puresStructArr.length == 1 ? _puresStructArr[0] : _puresStructArr)
							);
						}
						else
						{
							return new NPPILY.Struct.ReturnValueStruct
							(
								NrcapError.NRCAP_SUCCESS, 
								_punodeStructArr || new Array()
							);
						}
						break;
						
					// - 一个PU节点资源信息
					case NPPILY.Enum.ForkResourceLevel.nppForkOnePUInfo:
					
						var _puHandle = customParams._HANDLE || "";
						
						var puid = customParams.PUID || "";
						
						// - 直连设备时，不传puid时，由于ForkOnePU的puid是空的，将调用配置命令自行获取puid
						if (_connStruct.connType == NPPILY.Enum.ConnectionType.Device)
						{
							if (!puid)
							{
								var operator = NPPILY.ST_GetPUID(connectId, puid);
								if (operator.rv == NrcapError.NRCAP_SUCCESS)
								{
									puid = operator.response || "";	
									_puHandle = "";
								}
							}
						}
						
						if (!_puHandle) 
						{
							var operator = NPPIF.ForkOnePU(_connStruct.nc, _connStruct.session, puid);
							if(operator.rv != NrcapError.NRCAP_SUCCESS) 
							{
                				NPPUtils.Log(fn, "3:) get handle error -> " + NrcapError.Detail(operator.rv, true) + ", obj -> " + puid);
								return operator; 	
							}
							_puHandle = operator.response;
						}
						
						var _punodeStruct = NPPILY.NPPSDKCommon.ForkInfoByPUHandle
						(
							connectId, 
							_puHandle
						);
						
						if (_punodeStruct && _punodeStruct instanceof NPPILY.Struct.PUNodeStruct) 
						{
							// - 直连设备时，使能和在线置为1
							if (_connStruct.connType == NPPILY.Enum.ConnectionType.Device)
							{
								_punodeStruct.enable = "1";
								_punodeStruct.online = "1";
							}
							
							// - 获取子资源
							var operator = NPPIF.ForkPUResourceEx(_connStruct.nc, _puHandle);
							
							if (operator.rv == NrcapError.NRCAP_SUCCESS && operator.response === "") {
								operator = NPPIF.ForkPUResourceEx(_connStruct.nc, _puHandle);	
							}
							
							if (operator.rv != NrcapError.NRCAP_SUCCESS) 
							{ 	
								NPPUtils.Log(fn, "4:) get handle error -> " + NrcapError.Detail(operator.rv, true) + ", obj -> " + _puHandle);
								return operator;
							}
							else 
							{
								operator.response = operator.response || [];
								if (operator.response.constructor != Array)
								{
									operator.response = [operator.response];
								}
								
								for (var j = 0; j < operator.response.length; j++)
								{
									var child = operator.response[j];
									
									var prns = new NPPILY.Struct.PUResourceNodeStruct();
									prns.type = child.Type;
									prns.idx = child.Index;
									prns.name = NPPUtils.UTF8toUnicode(child.Name);
									prns.description = NPPUtils.UTF8toUnicode(child.Description);
									prns.enable = child.Enable;
									prns._HANDLE = child.Handle;
									
									_punodeStruct.childResource.push(prns);
								}
							}
						}
						
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, _punodeStruct || null);
						break;
						
					default:
                		NPPUtils.Log(fn, "forkLevel unknown error~");
                		return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						break;
						
				} // - end switch 
				
				NPPUtils.Log(fn, "fork resource error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
			}
		}
		catch(e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	

	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: 获取特定PUID的资源信息 @huzw 2015.05.07 add
    * ........................................................................................................
    **/
	QueryPUIDRes : function (connectId, puidSets/*puid1,puid2,...,puidn*/)
	{
		try
		{
			var fn = "NPPILY.QueryPUIDRes";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			if (typeof puidSets == "undefined" || !puidSets)
			{
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
	            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
			}
			
			var cs = NPPILY.Connections.get(connectId);
			
			var puRes = {};
			
			var operator = NPPIF.QueryPUIDRes(cs.nc, cs.session, puidSets);
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				if (operator.response != null && typeof operator.response == "object")
				{
					if (operator.response.constructor != Array)
					{
						operator.respones = [operator.response];
					}
					for (var i = 0; i < operator.response.length; i++)
					{
						var child = operator.response[i];
						
						if (child && child.PUID)
						{
							if (typeof puRes[child.PUID] == "undefined")
							{
								puRes[child.PUID] = [];
							}
							puRes[child.PUID].push({
								puid: child.PUID,
								type: child.Type,
								idx: child.Idx,
								name: child.Name,
								online: child.Online,
								enable: child.Enable,
								description: child.Description
							});
						}
					}
				}
			}

            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, puRes || {});
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	}, 
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: 获取特定PUID的资源信息 @huzw 2015.05.07 add
    * ........................................................................................................
    **/
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: Logic Group Resource
    * ........................................................................................................
    **/
	/*
    ---
    fn: GetLogicGroups
    desc: 获取逻辑分组
    author:
    	- huzw
    time: 2013.11.15
    returns:
    	- succ <response: Array(NPPILY.Struct.LogicGroupStruct)>
    params:
		- connectId(string) * 连接ID
    ... 
    */
	GetLogicGroups : function (connectId)
	{
		try
		{
			var fn = "NPPILY.GetLogicGroups";
			
			if (!NPPILY.Plug.inited)
            {
                NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
            }
			if (!connectId || !NPPILY.Connections.get(connectId)) {
                NPPUtils.Log(fn, "connectId error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
            }
            else 
            {
				var _connStruct = NPPILY.Connections.get(connectId);
				
				if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
				{ 
                	NPPUtils.Log(fn, "login or session error~");
                	return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
				}
				
				var requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryLogicGroupInfo"/></Msg>';
				// - 发送平台命令请求响应
				var operator = NPPIF.TransCustomMessage(_connStruct.nc, _connStruct.session, requestXML);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					var _lgsArray = [];
								
					if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
					{
						var _response = (new XML.ObjTree()).parseXML(operator.response);
						if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && typeof _response.Msg.Cmd.NUErrorCode != "undefined" && _response.Msg.Cmd.NUErrorCode != "0")
						{
							// - 返回具体的NUErrorCode错误码
							operator.rv = _response.Msg.Cmd.NUErrorCode || -1;
						}
						else if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && _response.Msg.Cmd.LogicGroup) 
						{
							LogicGroup = _response.Msg.Cmd.LogicGroup || [];
							if (typeof LogicGroup == "object")
							{
								if (LogicGroup.constructor != Array)
								{
									LogicGroup = [LogicGroup];	
								}
								for (var i = 0; i < LogicGroup.length; i++)
								{
									_lgsArray.push
									(
									 	new NPPILY.Struct.LogicGroupStruct
										(
										 	LogicGroup[i].Index, 
											LogicGroup[i].Name, 
											LogicGroup[i].LastRefreshTime, 
											LogicGroup[i].RefreshInterval
										)
									);	
								}
							}
						}
					}
					operator.response = _lgsArray; 
				}
				return operator;
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: GetLogicGroupNodes
    desc: 获取逻辑分组子节点
	author:
		- huzw
	time: 2013.11.15
	returns:
		- succ <response: Array(NPPILY.Sruct.LogicGroupNodeStruct)>
	params:
		- connectId(string) * 连接ID
		- options(object) * 可选参数
		{
			logicGroupIndex(uint<NPPILY.Struct.LogicGroupStruct:index>) * 逻辑分组索引
			logicGroupNodeIndex(uint) 逻辑分组节点索引，缺省为0
			offset(uint) 分页查询开始条数，缺省为0
			count(uint) 分页查询最大条数，缺省为4294967295（一个较大的数值）
			fetchMode(string) 获取模式，缺省为step（递归分部获取） | once（一次性获取全部节点）
		}
	remark:
		- 获取逻辑分组节点或节点下节点
    	- logicGroupNodeIndex表示当前节点（父节点），根节点的父节点索引为0，即缺省获取逻辑分组直接子节点
		- fetchMode = 'step'时，如果logicGroupNodeIndex属性存在，就获取这个节点下面的节点，不递归。如果不存在此属性，则获取所有节点
		- fetchMode = 'once'时，无论logicGroupNodeIndex存不存在，则获取logicGroupIndex下面的所有节点
		- count 默认为一个足够大的数，但是如果节点过大的话，建议配合offset进行分页获取
	...
	*/
	GetLogicGroupNodes : function (connectId, options)
	{
		try
		{
			var fn = "NPPILY.GetLogicGroupNodes";
			if (!connectId || !NPPILY.Connections.get(connectId)) {
                NPPUtils.Log(fn, "connectId error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
            }
            else 
            {
				var o = options || {};
				if (typeof o.logicGroupIndex == "undefined" || !NPPILY.intRex.test(o.logicGroupIndex))
				{
					NPPUtils.Log(fn, "o.logicGroupIndex error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR); 
				}
				
				var _connStruct = NPPILY.Connections.get(connectId);
				
				var xmlParam = '<LogicGroup Index="'+(Number(o.logicGroupIndex)||0)+'" ';
				
				o.logicGroupNodeIndex = typeof o.logicGroupNodeIndex != "undefined" && !isNaN(o.logicGroupNodeIndex) ? Number(o.logicGroupNodeIndex) : 0;
				o.offset = typeof o.offset != "undefined" && !isNaN(o.offset) ? Number(o.offset) : 0;
				o.count = typeof o.count != "undefined" && !isNaN(o.count) ? Number(o.count) : 4294967295;
				
				if ((o.fetchMode = o.fetchMode || "step") == "step")
				{
					xmlParam += ' NodeIndex="'+o.logicGroupNodeIndex+'" ';
				}
				
				xmlParam += ' Offset="'+o.offset+'" Count="'+o.count+'" />';
				
				var requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryLogicGroupNode">'+xmlParam+'</Cmd></Msg>';
				
				// - 发送平台命令请求响应
				var operator = NPPIF.TransCustomMessage(_connStruct.nc, _connStruct.session, requestXML);
				
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					var _lgnsArray = [];
								
					if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
					{
						var _response = (new XML.ObjTree()).parseXML(operator.response);
						if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && typeof _response.Msg.Cmd.NUErrorCode != "undefined" && _response.Msg.Cmd.NUErrorCode != "0")
						{
							// - 返回具体的NUErrorCode错误码
							operator.rv = _response.Msg.Cmd.NUErrorCode || -1;
						}
						else if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && _response.Msg.Cmd.Node) 
						{
							Node = _response.Msg.Cmd.Node || [];
							if (typeof Node == "object")
							{
								if (Node.constructor != Array)
								{
									Node = [Node];	
								}
								for (var i = 0; i < Node.length; i++)
								{
									_lgnsArray.push
									(
									 	new NPPILY.Struct.LogicGroupNodeStruct
										(
										 	Node[i].Index, 
											Node[i].Name, 
											Node[i].ParentNode_Index
										)
									);	
								}
							}
						}
					}
					operator.response = _lgnsArray; 
				}
				
				return operator;
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: GetLogicGroupResource
    desc: 获取逻辑分组节点下资源
	author:
		- huzw
	time: 2013.11.15
	returns:
		- succ <response: Array(NPPILY.Sruct.LogicGroupResourceStruct)>
	params:
		- connectId(string) * 连接ID
		- options(object) * 可选参数
		{
			logicGroupIndex(uint<NPPILY.Struct.LogicGroupStruct:index>) * 逻辑分组索引
			logicGroupNodeIndex(uint) 逻辑分组节点索引，缺省为0
			offset(uint) 分页查询开始条数，缺省为0
			count(uint) 分页查询最大条数，缺省为4294967295（一个较大的数值）
			fetchMode(string) 获取模式，缺省为step（递归分部获取） | once（一次性获取全部节点）
		}
	remark:
		- 获取逻辑分组节点或节点下节点资源
   		- 约定节点下的资源只有摄像头，没有PU以及其他资源，但为了扩然依然保留Res.Type属性
    	- logicGroupNodeIndex表示当前节点（父节点），根节点的父节点索引为0，即缺省获取逻辑分组直接子节点资源
		- fetchMode = 'step'时，如果logicGroupNodeIndex属性存在，就获取这个节点下面的节点资源，不递归。如果不存在此属性，则获取所有节点资源
		- fetchMode = 'once'时，无论logicGroupNodeIndex存不存在，则获取logicGroupIndex下面的所有节点资源
		- count 默认为一个足够大的数，但是如果节点过大的话，建议配合offset进行分页获取
	...
	*/
	GetLogicGroupResource : function (connectId, options)
	{
		try
		{
			var fn = "NPPILY.GetLogicGroupResource";
			if (!connectId || !NPPILY.Connections.get(connectId)) {
                NPPUtils.Log(fn, "connectId error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
            }
            else 
            {
				var o = options || {};
				if (typeof o.logicGroupIndex == "undefined" || !NPPILY.intRex.test(o.logicGroupIndex))
				{
					NPPUtils.Log(fn, "o.logicGroupIndex error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR); 
				}
				
				var _connStruct = NPPILY.Connections.get(connectId);
				
				var xmlParam = '<LogicGroup Index="'+(Number(o.logicGroupIndex)||0)+'" ';
				
				o.logicGroupNodeIndex = typeof o.logicGroupNodeIndex != "undefined" && !isNaN(o.logicGroupNodeIndex) ? Number(o.logicGroupNodeIndex) : 0;
				o.offset = typeof o.offset != "undefined" && !isNaN(o.offset) ? Number(o.offset) : 0;
				o.count = typeof o.count != "undefined" && !isNaN(o.count) ? Number(o.count) : 4294967295;
				
				if ((o.fetchMode = o.fetchMode || "step") == "step")
				{
					xmlParam += ' NodeIndex="'+o.logicGroupNodeIndex+'" ';
				}
				
				xmlParam += ' Offset="'+o.offset+'" Count="'+o.count+'" />';
				
				var requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryLogicGroupResource">'+xmlParam+'</Cmd></Msg>';
				
				// - 发送平台命令请求响应
				var operator = NPPIF.TransCustomMessage(_connStruct.nc, _connStruct.session, requestXML);
				
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					var _lgrsArray = [];
								
					if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
					{
						var _response = (new XML.ObjTree()).parseXML(operator.response);
						if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && typeof _response.Msg.Cmd.NUErrorCode != "undefined" && _response.Msg.Cmd.NUErrorCode != "0")
						{
							// - 返回具体的NUErrorCode错误码
							operator.rv = _response.Msg.Cmd.NUErrorCode || -1;
						}
						else if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && _response.Msg.Cmd.Res) 
						{
							Res = _response.Msg.Cmd.Res || [];
							if (typeof Res == "object")
							{
								if (Res.constructor != Array)
								{
									Res = [Res];	
								}
								for (var i = 0; i < Res.length; i++)
								{
									_lgrsArray.push
									(
									 	new NPPILY.Struct.LogicGroupResourceStruct
										(
										 	Res[i].PUID, 
											Res[i].Type, 
											Res[i].Idx, 
											Res[i].Name, 
											Res[i].Description, 
											Res[i].Enable, 
											Res[i].ParentNode_Index
										)
									);	
								}
							}
						}
					}
					operator.response = _lgrsArray; 
				}
				
				return operator;
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
            return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: Logic Group Resource
    * ........................................................................................................
    **/
	/*
	---
	fn: PTZ
	desc: 云台操作对象
	time: 2013.09.09
	author: 
		- huzw
	...
	*/
	PTZ : 
	{
		/*
		---
		fn: Control
		desc: 云台控制
		author: 
			- huzw
		time: 2013.09.09
		params: 
			- connectId(string) 连接ID
			- puid(string) 设备PUID
			- ptzIndex(string) PTZ资源索引
			- direction(NPPILY.Enum.PTZDirection)
			- options(object)
				{
					degree(unit) 转动角度，可不传，默认为0（选传）	
					secondaryDevNo(uint) 辅助设备编号（选传）
					presetPosNo(unit) 预置位编号（选传）
					presetPosName(string) 预置位名称（选传）
				}
		remark:
			- options属性取值说明
			=> 	degree(unit) 云台上下左右转动时选择传入
			=> 	secondaryDevNo(uint) 操作辅助设备时选择传入，不可为空
			=> 	presetPosNo(unit) 操作预置位时选择传入，不可为空
				presetPosName(string) 操作设置预置位时选择传入，不可为空
				
			- <SDK> options._HANDLE云台资源句柄
		...
		*/
		Control : function(connectId, puid, ptzIndex, direction, options) 
		{
			try
			{
				var fn = "NPPILY.PTZ.Control";
			 
				if (!NPPILY.Plug.inited) 
				{
					NPPUtils.Log(fn, "NPPILY.Plug.inited failed~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_NRCAPPLUG_FAILED);
				}
				
				if (!connectId || !NPPILY.Connections.get(connectId)) {
					NPPUtils.Log(fn, "connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				else 
				{
					if (!puid || !NPPILY.puidRex.test(puid))
					{
						NPPUtils.Log(fn, "puid error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
					}
					if (typeof ptzIndex == "undefined" || !NPPILY.intRex.test(ptzIndex))
					{
						NPPUtils.Log(fn, "ptzIndex error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR); 
					}
					if (!direction)
					{
						NPPUtils.Log(fn, "direction error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR); 
					}
					
					var options = options || {};
					
					var _connStruct = NPPILY.Connections.get(connectId);
					
					if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
					{ 
						NPPUtils.Log(fn, "login or session error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					}
					
					var operator, _ptzHandle;
					if (options._HANDLE) 
					{
						_ptzHandle = options._HANDLE;	
					}
					else 
					{
						// - 获取资源句柄
						var _operator = NPPILY.NPPSDKCommon.GetHandle
						(
							connectId, 
							puid,
							NPPILY.Enum.PuResourceType.PTZ,
							ptzIndex
						);
						if (_operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							_ptzHandle = _operator.response;	
						}
						else
						{
							NPPUtils.Log(fn, "get handle error~");
							return _operator;	
						}
					}
					
					switch (direction)
					{ 
						case NPPILY.Enum.PTZDirection.turnleft :
						case NPPILY.Enum.PTZDirection.turnright :
						case NPPILY.Enum.PTZDirection.turnup :
						case NPPILY.Enum.PTZDirection.turndown : 
							operator = NPPIF.PTZControl(_connStruct.nc, _ptzHandle, direction, (options.degree || 0)); 
							break;
						case NPPILY.Enum.PTZDirection.startsecondarydev :
						case NPPILY.Enum.PTZDirection.stopsecondarydev :
							if (typeof options.secondaryDevNo == "undefined")
							{ 
								NPPUtils.Log(fn, "options.secondaryDevNo error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
							}
							operator = NPPIF.PTZControl(_connStruct.nc, _ptzHandle, direction, options.secondaryDevNo);
							break;  
						case NPPILY.Enum.PTZDirection.movetopresetpos :
							if (typeof options.presetPosNo == "undefined")
							{ 
								NPPUtils.Log(fn, "options.presetPosNo error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
							}
							operator = NPPIF.PTZControl(_connStruct.nc, _ptzHandle, direction, options.presetPosNo);
							break;  
						case NPPILY.Enum.PTZDirection.setpresetpos :
							if (typeof options.presetPosNo == "undefined" || typeof options.presetPosName == "undefined")
							{ 
								NPPUtils.Log(fn, "options.presetPosNo error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
							}
							operator = NPPIF.PTZControl(_connStruct.nc, _ptzHandle, direction, options.presetPosNo, options.presetPosName);
							break;
						default : 
							operator = NPPIF.PTZControl(_connStruct.nc, _ptzHandle, direction); 
							break;
					}
					// NPPUtils.Log(fn, operator);
					if (operator.rv != NrcapError.NRCAP_SUCCESS) 
					{
						NPPUtils.Log(fn, "ptz control error = " + NrcapError.Detail(operator.rv, true));
						return new NPPILY.Struct.ReturnValueStruct((NPPILY.Debug.debug ? operator.rv : NrcapError.NRCAP_FAILED));	
					} 
					
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				} 
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			} 
		},
		
		end : true
	},  
	/*
	---
	fn: NPPSDKCommon
	desc: 内部公共对象
	time: 2013.09.09
	author: 
		- huzw
	...
	*/
	NPPSDKCommon : 
	{
		/*
		---
		fn: NPPSDKCommon
		desc: 获取（资源）句柄
		time: 2013.09.09
		author: 
			- huzw
		returns:
			- succ 设备或资源句柄
			- error NrcapError
		params:
			- connectId(string) * 连接ID
			- puid(string) * 设备PUID
			- resType(NPPILY.Enum.PuResourceType) 资源类型（可省略）
			- resIndex(uint) 资源索引（可省略）
		remark:
			- 传入puid时，获取设备句柄
			- 传入puid, resType, resIndex获取资源句柄
		...
		*/
		GetHandle : function(connectId, puid, resType, resIndex)
		{
			try 
			{
				var fn = "NPPILY.NPPSDKCommon.GetHandle";
				
				if (!connectId || !NPPILY.Connections.get(connectId)) {
					NPPUtils.Log(fn, "connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				else 
				{    
					if (!puid || !NPPILY.puidRex.test(puid))
					{
						NPPUtils.Log(fn, "puid error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
					}
					
					var _usPUHandle;
					if (!resType && (typeof resIndex == "undefined" || resIndex == null || isNaN(resIndex)))
					{
						_usPUHandle = true;	
					}
					else
					{
						_usPUHandle = false;
						 
						if (!NPPILY.intRex.test(resIndex))
						{
							NPPUtils.Log(fn, "resIndex error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR); 
						}	
					}
					
					var _connStruct = NPPILY.Connections.get(connectId);
					
					if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
					{ 
						NPPUtils.Log(fn, "login or session error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					
					var _operator = NPPIF.ForkOnePU
					(
					 	_connStruct.nc, 
						_connStruct.session, 
						puid
					);
					
					if (_operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						_puHandle = _operator.response;
					}
					else
					{
						return _operator;
					} 
					
					if (_usPUHandle)
					{
						if (_operator.response === "00000000")
						{
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_HANDLE_NOTEXIST, _puHandle);	
						} 
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, _puHandle);
					}
					else
					{
						var _operator = NPPIF.ForkPUResource
						(
						 	_connStruct.nc, 
							_puHandle
						); 
						
						if (_operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							if (_operator.response === "00000000")
							{
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_HANDLE_NOTEXIST, _operator.response);	
							} 
							var _operator = NPPIF.GetResourceHandleFromPUHandle
							(
							 	_connStruct.nc, 
								_puHandle, 
								resType, 
								resIndex
							);
							
							if (_operator.rv == NrcapError.NRCAP_SUCCESS)
							{
								if (_operator.response === "00000000")
								{
									return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_HANDLE_NOTEXIST, _operator.response);	
								} 
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, _operator.response);
							}
							else
							{
								return _operator;
							} 
						}	
						else
						{ 
							return _operator;
						} 
					} 
				}
			}
			catch(e)
			{ 
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			} 
		},
		
		// - 设备是否在线
		PUIsOnline : function(connectId, puid)
		{
			try
			{
				var fn = "NPPILY.NPPSDKCommon.PUIsOnline";
				if (!connectId || !NPPILY.Connections.get(connectId)) {
					NPPUtils.Log(fn, "connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				var operator = NPPILY.NPPSDKCommon.GetHandle(connectId, puid);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					var _puHandle = operator.response; 
					
					var _connStruct = NPPILY.Connections.get(connectId);
					
					if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
					{ 
						NPPUtils.Log(fn, "login or session error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					
					var _operator = NPPIF.GetResourceUsable(_connStruct.nc, _puHandle); 
					
					if (_operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						if (_operator.response != 1) {
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PU_OFFLINE, _puHandle || null);
						}
					}
				}
				else
				{
					if (operator.rv == NrcapError.NRCAP_ERROR_HANDLE_NOTEXIST)
					{
						return operator;	
					}
					if (operator.rv == NrcapError.NRCAP_NU_ERROR_OBJNOTEXIST)
					{
						return operator;
					}
				}
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, (typeof _puHandle != "undefined" ? _puHandle : null));
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		// - 获取设备信息节点
		ForkInfoByPUHandle : function(connectId, _puHandle)
		{
			try
			{
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					return null;	
				}
				
				if(!_puHandle)
				{
					return null;
				}
				else 
				{
					var _infors = 
					[{
						_method: "GetPUID", _property: "puid", _value: "" 		 
					}, {
						_method: "", _property: "resType", _value: NPPILY.Enum.PuResourceType.SELF, _active: false 		 
					}, {
						_method: "", _property: "resIdx", _value: 0, _active: false 		 
					}, {
						_method: "GetResourceName", _property: "name", _value: "" 		 
					}, {
						_method: "GetResourceDesc", _property: "description", _value: "" 		 
					}, {
						_method: "GetResourceEnable", _property: "enable", _value: "" 		 
					}, {
						_method: "GetResourceUsable", _property: "online", _value: "" 		 
					}, {
						_method: "", _property: "immitted", _value: 1, _active: false 		 
					}, {
						_method: "GetPUModel", _property: "modelName", _value: "" 		 
					}, {
						_method: "GetPUType", _property: "modelType", _value: "" 		 
					}, {
						_method: "GetPUProducerID", _property: "manufactrueID", _value: "" 		 
					}, {
						_method: "GetPUHardwareVersion", _property: "hardwareVersion", _value: "" 		 
					}, {
						_method: "GetPUSoftwareVersion", _property: "softwareVersion", _value: "" 		 
					}, {
						_method: "GetPUDeviceID", _property: "deviceID", _value: "" 		 
					}, {
						_method: "GetPULatitude", _property: "latitude", _value: "" 		 
					}, {
						_method: "GetPULongitude", _property: "longitude", _value: "" 		 
					}, {
						_method: "", _property: "_HANDLE", _value: _puHandle, _active: false 		 
					}];
					
					var _connStruct = NPPILY.Connections.get(connectId),
						_punodeStruct = new NPPILY.Struct.PUNodeStruct(),
						_errorFlag = false;
					 
					for(var i = 0; i < _infors.length; i++) 
					{ 	
						var _infor = _infors[i];
						 
						if(_infor._active !== false)
						{
							if(typeof NPPIF[_infor._method] != "undefined")
							{
								var _operator = NPPIF[_infor._method](_connStruct.nc, _puHandle);
								if(_operator.rv == NrcapError.NRCAP_SUCCESS)
								{
									_infor._value = _operator.response;
								}
								else 
								{
									_errorFlag = true;
									break;
								}
							} 
						}
						if(typeof _punodeStruct[_infor._property] != "undefined") 
						{
							_punodeStruct[_infor._property] = _infor._value;
						} 
					}
					
					return _errorFlag == true ? null : _punodeStruct; 
				} 
			}
			catch(e) {
				return null;	
			}  
		},
		
		// - 获取设备资源信息节点
		ForkInfoByPUResHandle : function(connectId, _resHandle)
		{
			try
			{
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					return null;	
				}
				
				if(!_resHandle)
				{
					return null;
				}
				else 
				{ 
					var _infors = 
					[{
						_method: "GetResourceType", _property: "type", _value: "" 		 
					}, {
						_method: "GetResourceIndex", _property: "idx", _value: "" 		 
					}, {
						_method: "GetResourceName", _property: "name", _value: "" 		 
					}, {
						_method: "GetResourceDesc", _property: "description", _value: "" 		 
					}, {
						_method: "GetResourceEnable", _property: "enable", _value: "" 		 
					}, {
						_method: "", _property: "_HANDLE", _value: _resHandle, _active: false
					}];
					
					var _connStruct = NPPILY.Connections.get(connectId),
						_puresStruct = new NPPILY.Struct.PUResourceNodeStruct(),
						_errorFlag = false;
					 
					for(var i = 0; i < _infors.length; i++) 
					{ 	
						var _infor = _infors[i];
						 
						if(_infor._active !== false)
						{
							if(typeof NPPIF[_infor._method] != "undefined")
							{
								var _operator = NPPIF[_infor._method](_connStruct.nc, _resHandle);
								if(_operator.rv == NrcapError.NRCAP_SUCCESS)
								{
									_infor._value = _operator.response;
								}
								else 
								{
									_errorFlag = true;
									break;
								}
							} 
						}
						if(typeof _puresStruct[_infor._property] != "undefined") 
						{
							_puresStruct[_infor._property] = _infor._value;
						} 
					}
					
					return _errorFlag == true ? null : _puresStruct;
				} 
			}
			catch(e) {
				return null;	
			} 
		},
		
		// - 获取NC请求响应
		GetNCResponse : function (connectId, _method /* , ?... */ )
		{
			try
			{
				var fn = "NPPILY.NPPSDKCommon.GetNCResponse";
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId not exist~");	
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				if (!_method) {
					NPPUtils.Log(fn, "_method error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
				}
				
				var _connStruct = NPPILY.Connections.get(connectId);
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connected)
				{
					var _argsArr = new Array(_method, _connStruct.nc);
					
					var _args = arguments || [], 
						_argslen = _args.length,
						_customParams = _args[_argslen - 1],
						_HANDLE = null;
						
					if (_argslen >= 3)
					{
						if (typeof _customParams == "object" && typeof _customParams._HANDLE != "undefined") {
							_HANDLE	= _customParams._HANDLE;
						}
						else
						{	
							// - 设备是否在线
							var isOnline_operator = NPPILY.NPPSDKCommon.PUIsOnline
							(
								connectId, 
								_args[2]
							);
							if (isOnline_operator.rv == NrcapError.NRCAP_ERROR_PU_OFFLINE)
							{
								NPPUtils.Log(fn, "operator failed, pu not online~");
								return isOnline_operator;	
							}
							// - 获取对应的资源句柄
							var handle_operator = NPPILY.NPPSDKCommon.GetHandle
							(
								connectId, 
								_args[2],
								(_argslen >= 5 ? (_args[3] || null) : null),
								(_argslen >= 5 && typeof _args[4] != "undefined" && !isNaN(_args[4]) ? _args[4] : null)
							);
							if (handle_operator.rv == NrcapError.NRCAP_SUCCESS)
							{
								_HANDLE	= handle_operator.response;
							}
							else
							{
								NPPUtils.Log(fn, "handle_operator error~");
								return handle_operator;
							}
						}
					}
					else
					{
						_HANDLE = _connStruct.session || null;		
					}
					if (_HANDLE != null)
					{
						_argsArr.push(_HANDLE);
					}
					  
					for (var i = 2; i < _argslen; i++)
					{
						if (typeof _args[i] != "undefined")
						{
							if (_argslen == 4 && i == 3)
							{
								_argsArr.push(_args[i]);	
							}
							else if (_argslen > 5 && i >= 5) {
								_argsArr.push(_args[i]);		
							}
						}
					}
					
					var operator = new NPPILY.Struct.ReturnValueStruct();
					
					// - 如果NPPIF中没有对应接口，那么使用公共接口
					if (typeof NPPIF[_argsArr[0]] != "undefined")
					{
						operator =  NPPIF[_argsArr[0]].apply
						(
							NPPIF[_argsArr[0]],
							_argsArr.slice(1)
						);
					}
					else
					{
						// - 获取NC响应
						operator = NPPIF.Common.GetNCResponse.apply
						(
							NPPIF.Common.GetNCResponse, 
							_argsArr
						);	
					}
					
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						if (typeof _customParams == "object" && typeof _customParams.returnType != "undefined" && _customParams.returnType.toLowerCase() == "json")
						{
							if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
							{
								operator.response = (new XML.ObjTree()).parseXML(operator.response);	
							}
						}
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "hav't connected~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
				}
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);	
			}
		},
		
		end : true
	},
	
	/*
    ---
    fn: CreateWindow 
    desc: 创建窗口
    author:
        - zenghx
		- huzw
    time: 2013.09.05 -> 2013.09.26 -> 2013.10.18
	mdftime: 2015.01.13
    returns: 
		- succ <response: Object(NPPILY.Struct.WindowStruct)>
    params: 
		- connectId(string) 连接ID 
        - containerOrId(dom element | dom id) 窗口插件容器或ID
		- windowType(NPPILY.Enum.WindowType) 窗口类型
		- windowEvent(NPPILY.Struct.WindowEventStruct) 绑定窗口事件
		- customParams(object) 自定义参数
    ... 
    */
	CreateWindow : function(connectId, containerOrId, windowType, windowEvent, customParams)
	{
		try
		{
			var fn = "NPPILY.CreateWindow";
			
			if (!connectId || !NPPILY.Connections.get(connectId)) 
			{
                NPPUtils.Log(fn, "connectId error~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
            }
			var container = null;
			if (typeof containerOrId == "object" && typeof containerOrId.id != "undefined")
			{
				container = containerOrId;	
			}
			else
			{
				if (typeof containerOrId == "undefined" || containerOrId == null || !document.getElementById(containerOrId))
				{	
					NPPUtils.Log(fn, "containerOrId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
				}
				
				container = document.getElementById(containerOrId);
			}
			
			var t_wndname = container.id + "_wnd"; 
			
			container.innerHTML = NPPILY.Plug.Html.get("wnd").replace(/(@id)|(@name)/g, t_wndname);
			
			if (!container.firstChild && container.firstChild.id != t_wndname && !document.getElementById(t_wndname))
			{
				NPPUtils.Log(fn, "include wnd plugin error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			
			var wnd = container.firstChild || document.getElementById(t_wndname);
			 
			var options = {
				container : container,
				wnd : wnd,
				type : windowType || NPPILY.Enum.WindowType.VIDEO,
				connectId : connectId,
				customParams : typeof customParams == "object" ? customParams : {}
			};
			var winObj = new NPPILY.Struct.WindowStruct(options);
			
			winObj["NPP_wndObjects"] = {};
			
			wnd.style.border = "0";
			wnd.style.width = "100%";
			wnd.style.height = "100%";
			
			// - 获取窗口插件句柄
			var operator = NPPIF.GetWindowHandle(winObj.wnd);
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				winObj.wndHandle = operator.response;
				
				winObj["NPP_wndObjects"]["wndHandle"] = operator.response;
				winObj["NPP_wndObjects"]["org_wndHandle"] = operator.response;
			}
			
			if (!winObj || !winObj instanceof NPPILY.Struct.WindowStruct) 
			{
                NPPUtils.Log(fn, "wnd create failed~");
                return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INIT_WINDOW_FAILED);
            }
			
			// - 初始化绑定窗口事件
			NPPILY.WindowAttachEvent.Init(winObj, windowEvent);
			
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, winObj);
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	 
	/*
    ---
    fn: WindowAttachEvent
    desc: 绑定窗口事件
    author:
        - huzw  
    time: 2013.09.26
	*/
	WindowAttachEvent : 
	{
		/*
		---
		fn: Init
		desc: 初始化绑定窗口事件
		mdf: huzw 2015.01.13
		returns: 
			- Object(NPPILY.Struct.ReturnValueStruct)
		params: 
			- winObj(NPPILY.Struct.WindowStruct) 窗口信息结构实例
			- windowEvent(NPPILY.Struct.WindowEventStruct) 窗口绑定事件结构实例
		remark:
			- 对winObj重复覆盖绑定windowEvent，可以随时调用此函数
		*/
		Init: function(winObj, windowEvent)
		{
			try
			{
				var fn = "NPPILY.WindowAttachEvent.Init";
				
				if (!winObj || !winObj instanceof NPPILY.Struct.WindowStruct || typeof winObj.wnd == "undefined")
				{
					NPPUtils.Log(fn, "winObj error~");
                	return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
				}
				
				if (!windowEvent || !windowEvent instanceof NPPILY.Struct.WindowEventStruct)
				{
					windowEvent = new NPPILY.Struct.WindowEventStruct();	
				}
				
				// - 记录原始事件信息
				winObj.wnd["NPP_originalWindowEvent"] = windowEvent;
				
				// - 把有用的信息记录到winObj.NPP_wndObjects对象下面
				winObj["NPP_wndObjects"]["NPP_originalWindowEvent"] = windowEvent;
				
				var _SELF = NPPILY.WindowAttachEvent;
						
				// - 注册绑定的事件
				var _DW_ATTACH_EVENT = function (_evtObjItem, _evt_cb)
				{
					if (_evtObjItem.status == true)
					{	
						var name = _evtObjItem.name;
						var callback = _evt_cb || _evtObjItem.callback;
						
						var _name = "_" + name.toUpperCase();
						var _callback = function ()
						{ 
							var _argsArr = new Array(winObj);
							for (var i = 0; i < arguments.length; i++)
							{
								_argsArr.push(arguments[i]);	
							}
							
							switch(name)
							{
								case "lbtn_click" :
									_SELF.Fire_lbtn_click.apply(_SELF, _argsArr);
									break; 
								case "select_rect" :
									_SELF.Fire_select_rect.apply(_SELF, _argsArr);
									break;
								
								// - 云台控制（拖拽、鼠标滚轮）事件
								case "drag_up" :
								case "drag_down" :
								case "drag_left" :
								case "drag_right" :
								case "drag_stop" :
								case "mouse_wheel_scroll_forward" :
								case "mouse_wheel_scroll_backward" : 
								case "mouse_wheel_scroll_stop" :
									var _action;
									if (name == "drag_up") {
										_action = "drag_up";
									}
									else if (name == "drag_down") {
										_action = "drag_down";
									}
									else if (name == "drag_left") {
										_action = "drag_left";
									}
									else if (name == "drag_right") {
										_action = "drag_right";
									}
									else if (name == "drag_stop") {
										_action = "drag_stop";
									}
									else if (name == "mouse_wheel_scroll_forward") {
										_action = "mws_forward";
									}
									else if (name == "mouse_wheel_scroll_backward") {
										_action = "mws_backward";
									}
									else {
										_action = "mws_stop";
									}
									_argsArr.splice(0, 0, _action);
									_SELF.Fire_PTZControl.apply(_SELF, _argsArr);
									break;
									
								case "full_screen_window_show" :
									_SELF.Fire_fsw_show.apply(_SELF, _argsArr);
									break;
								case "full_screen_window_hide" :
									_SELF.Fire_fsw_hide.apply(_SELF, _argsArr);
									break;
								case "redraw_window" :
									_SELF.Fire_redraw_window.apply(_SELF, _argsArr);
									break;
								case "menu_command" :
									_argsArr.splice(2, 0, callback);
									_SELF.Fire_menu_command.apply(_SELF, _argsArr);
									break;
							}
							
							if (name != "menu_command")
							{
								if (typeof callback == "function")
								{
									callback.apply(callback, _argsArr.slice(1));	
								}
							}
						};
						
						if (typeof winObj.wnd[_name] != "undefined") {
							// - 移除已经注册的事件
							NPPIF.DetachObjectEvent(winObj.wnd, name, winObj.wnd[_name]);
						} 
						// - 绑定事件
						NPPIF.AttachObjectEvent(winObj.wnd, name, _callback);
						
						winObj.wnd[_name] = _callback;
					} 
				};
				
				for (var _key in windowEvent) 
				{
					// - 使用闭包
					(function(key) {
						if (typeof windowEvent[key] != "undefined")
						{
							// - 云台控制事件单独处理
							if (key == "ptz_control") {
								if (windowEvent[key].status == true)
								{
									for (var __key in windowEvent[key])
									{
										// - 使用闭包
										(function(k) {	  
											if (typeof windowEvent[key][k] == "object" && typeof windowEvent[key][k].status != "undefined")
											{
												_DW_ATTACH_EVENT(windowEvent[key][k], windowEvent[key].callback);
											}
										})(__key);	
									}
								}
							}
							else {
								_DW_ATTACH_EVENT(windowEvent[key]);
								
								// - 绑定自定义右键菜单项
								if (key == "menu_command" && typeof windowEvent[key] == "object" && windowEvent[key].status == true)
								{									
									winObj.wnd["NPP_b_MENU_COMMAND"] = 1;
									winObj["NPP_wndObjects"]["NPP_b_MENU_COMMAND"] = 1;
									
									var _customMenus = windowEvent[key].menu;
									if (typeof winObj.wnd["NPP_customMenus"] != "undefined")
									{
										// -  清除所有菜单项
										NPPIF.DeleteAllMenuItem(winObj.wnd);
									}
									winObj.wnd["NPP_customMenus"] = {}; // [keyCode] -> key, text
									winObj["NPP_wndObjects"]["NPP_customMenus"] = {};
									
									// - 追加（添加）窗口右键菜单项
									NPPILY.WindowAttachEvent.AppendMenuCommand(winObj, _customMenus);
								}
								else
								{
									winObj.wnd["NPP_b_MENU_COMMAND"] = 0;
									winObj["NPP_wndObjects"]["NPP_b_MENU_COMMAND"] = 0;
								}
							} 
						}
					})(_key);
				}
				
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},

		/**
		* --------------------------------------------------------------------------------------------------------
		*    - s - remark: 自定义窗口右键菜单项控制（SDK内部使用）
		* ........................................................................................................ 
		**/
		__Sdk_MenuCommandCtl : function(_action, _winObj, _customMenus /*, bRedraw */)
		{
			try 
			{
				var fn = "NPPILY.WindowAttachEvent.__Sdk_MenuCommandCtl -> " + _action;
				
				if (typeof _winObj == "undefined" || typeof _winObj.wnd == "undefined" 
					|| typeof _winObj.wnd["NPP_b_MENU_COMMAND"] == "undefined" || !_winObj.wnd["NPP_b_MENU_COMMAND"])
				{
					var npp_bmc = _winObj["NPP_wndObjects"]["NPP_b_MENU_COMMAND"];
					
					if (typeof npp_bmc == "undefined" || !npp_bmc) {
						NPPUtils.Log(fn, "_objWnd | wnd | NPP_b_MENU_COMMAND(disabled right click menu_command) error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					}
				}
				
				switch (_action)
				{
					case "append":
						if (typeof _customMenus != "object")
						{
							NPPUtils.Log(fn, "_customMenus error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						if (_customMenus.constructor != Array) {
							_customMenus = [_customMenus];	
						}
						 
						_winObj.wnd["NPP_customMenus"] = _winObj.wnd["NPP_customMenus"] || {};
						
						for (var i = 0; i < _customMenus.length; i++) 
						{
							var item = _customMenus[i];
							if (typeof item.key == "undefined" || typeof item.text == "undefined")
								continue;
								
							var _keyExist = false,
								_keyCodeNew = 0;
								
							if (typeof _winObj.wnd["NPP_customMenus"] != "undefined")
							{
								for (var _keyCode in _winObj.wnd["NPP_customMenus"])
								{
									var _menuItem = _winObj.wnd["NPP_customMenus"][_keyCode];
									if (_menuItem.key == item.key && (NPPUtils.Array.indexOf(["-", "separator", "split"], item.key) == -1))
									{
										_keyExist = true;
										break;
									}
									else
									 	_keyCodeNew++;
								}
							}
							// alert(_keyExist + "::" + _keyCodeNew + "::" + item.key + "::" + item.text);
							if (!_keyExist)
							{
								var mode = (NPPUtils.Array.indexOf(["-", "separator", "split"], item.key) != -1) ? 0x800 : 0;
								var operator = NPPIF.AppendMenuItem(_winObj.wnd, mode, _keyCodeNew, item.text);
								if (operator.rv == NrcapError.NRCAP_SUCCESS)
								{
									if (typeof _winObj.wnd["NPP_customMenus"][_keyCodeNew] == "undefined")
									{ 
										_winObj.wnd["NPP_customMenus"][_keyCodeNew] = 
										{
											key : item.key,
											text : item.text
										}; 
									} 
								}
							} 
						}
						
						_winObj["NPP_wndObjects"]["NPP_customMenus"] = _winObj.wnd["NPP_customMenus"];
						
						break;
					case "update":
						if (typeof _customMenus != "object")
						{
							NPPUtils.Log(fn, "_customMenus error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						
						// - equals bRedraw
						if (typeof arguments[3] != "undefined" && arguments[3] == 1) 
						{
							// -  清除所有菜单项
							NPPIF.DeleteAllMenuItem(_winObj.wnd);
							_winObj.wnd["NPP_customMenus"] = {}; // [keyCode] -> key, text
							
							// - 追加（添加）窗口右键菜单项
							NPPILY.WindowAttachEvent.__Sdk_MenuCommandCtl("append", _winObj, _customMenus);
						}
						else
						{
							if (_customMenus.constructor != Array) {
								_customMenus = [_customMenus];	
							}
							
							_winObj.wnd["NPP_customMenus"] = _winObj.wnd["NPP_customMenus"] || {};
							
							for (var i = 0; i < _customMenus.length; i++) 
							{
								var item = _customMenus[i];
								if (typeof item.key == "undefined" || typeof item.text == "undefined")
									continue;
								
								var _keyExist = false,
									_keyCodeNew = 0;
								
								if (typeof _winObj.wnd["NPP_customMenus"] != "undefined")
								{
									for (var _keyCode in _winObj.wnd["NPP_customMenus"])
									{
										var _menuItem = _winObj.wnd["NPP_customMenus"][_keyCode];
										if (_menuItem.key == item.key && (NPPUtils.Array.indexOf(["-", "separator", "split"], item.key) == -1))
										{
											// - 更新text
											if (item.text)
											{
												_menuItem.text = item.text;
											}
											_keyExist = true;
											break;
										}
										
										_keyCodeNew++;
									}
								}
								
								if (!_keyExist)
								{
									_winObj.wnd["NPP_customMenus"][_keyCodeNew] = 
									{
										key : item.key,
										text : item.text
									};
								} 
							}
														
							var _customMenusNewArrayCache = [];
							
							for (var _keyCode in _winObj.wnd["NPP_customMenus"])
							{
								var _menuItem = _winObj.wnd["NPP_customMenus"][_keyCode];
								
								_customMenusNewArrayCache.push
								({
									key : _menuItem.key, 
									text : _menuItem.text 
								});
							}
							
							NPPUtils.Log(fn, "Update custom menus -> " + _customMenusNewArrayCache);
							
							// -  清除所有菜单项
							NPPIF.DeleteAllMenuItem(_winObj.wnd);
							_winObj.wnd["NPP_customMenus"] = {}; // [keyCode] -> key, text
							
							// - 追加（添加）窗口右键菜单项
							NPPILY.WindowAttachEvent.__Sdk_MenuCommandCtl("append", _winObj, _customMenusNewArrayCache);
							
						} 
						break;
					case "remove":
						var _isRemoveAll = false;
						
						var _customMenus = _customMenus || [];
						if (typeof _customMenus == "object" && _customMenus.constructor != Array)
						{
							_customMenus = [_customMenus];
						}
						if (_customMenus.length <= 0)
						{
							_isRemoveAll = true;
						}
						
						if (_isRemoveAll)
						{
							// -  清除所有菜单项
							NPPIF.DeleteAllMenuItem(_winObj.wnd);
							_winObj.wnd["NPP_customMenus"] = {}; // [keyCode] -> key, text
						}
						else 
						{
							var _customMenusNewArrayCache = [];
							
							for (var _keyCode in _winObj.wnd["NPP_customMenus"])
							{
								var _menuItem = _winObj.wnd["NPP_customMenus"][_keyCode];
								
								var _keyDelExist = false;
								
								for (var i = 0; i < _customMenus.length; i++) 
								{
									var item = _customMenus[i];
									if (typeof item.key == "undefined")
										continue;
									
									if (_menuItem.key == item.key)
									{
										if (NPPUtils.Array.indexOf(["-", "separator", "split"], item.key) == -1)
										{	 
											_keyDelExist = true;
											break;
										}
										else 
										{
											if (typeof item.text != "undefined" && _menuItem.text == item.text)
											{
												_keyDelExist = true;
												break;
											} 
										} 
									}
								}
								
								if (!_keyDelExist)
								{
									_customMenusNewArrayCache.push
									({
										key : _menuItem.key, 
										text : _menuItem.text 
									});	
								}
							} // end for _keyCode
							
							NPPUtils.Log(fn, "Remove then update custom menus -> " + _customMenusNewArrayCache);
							
							// -  清除所有菜单项
							NPPIF.DeleteAllMenuItem(_winObj.wnd);
							_winObj.wnd["NPP_customMenus"] = {}; // [keyCode] -> key, text
							
							// - 追加（添加）窗口右键菜单项
							NPPILY.WindowAttachEvent.__Sdk_MenuCommandCtl("append", _winObj, _customMenusNewArrayCache);
						}
						break;
				}
				
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		/*
		---
		fn : AppendMenuCommand
		desc : 追加（添加）窗口右键菜单项
		time : 2013.10.08
		author : 
			- huzw
		...
		*/
		AppendMenuCommand : function(winObj, customMenus)
		{
			return this.__Sdk_MenuCommandCtl.call(this.__Sdk_MenuCommandCtl, "append", winObj, customMenus);
		},/*
		---
		fn : UpdateMenuCommand
		desc : 更新窗口右键菜单项
		time : 2013.10.08
		author : 
			- huzw
		remark :
			- bRedraw(bool::0) 是否重新绘制（1、true是，0、false否）
			- if bRedraw = 1, then removing all menus 1st, appending all menus 2nd 
		...
		*/
		UpdateMenuCommand : function(winObj, customMenus, bRedraw /* = 0 */)
		{
			return this.__Sdk_MenuCommandCtl.call(this.__Sdk_MenuCommandCtl, "update", winObj, customMenus, (bRedraw || 0));
		},/*
		---
		fn : RemoveMenuCommand
		desc : 剔除窗口右键菜单项
		time : 2013.10.08
		author : 
			- huzw
		remark :
			- 如果customMenus存在，那么匹配key进行删除
			- 对["-", "separator", "split"]之一，将根据匹配text进行删除，如{key: "-", text: "split_1"}，将删除split_1对应的分割线
		...
		*/
		RemoveMenuCommand : function(winObj, customMenus)
		{
			return this.__Sdk_MenuCommandCtl.call(this.__Sdk_MenuCommandCtl, "remove", winObj, customMenus);
		},
		/**
		* --------------------------------------------------------------------------------------------------------
		*    - e - remark: 自定义窗口右键菜单项控制
		* ........................................................................................................ 
		**/
		
		// - 左键单击
		Fire_lbtn_click : function (winObj, x, y)
		{
			NPPUtils.Log("Fire_lbtn_click", "xPos ->" + x + ", yPos -> " + y);
		},
		// - 选择矩形框
		Fire_select_rect : function (winObj, x, y, m, n)
		{
			NPPUtils.Log("Fire_select_rect", x + "," + y + "," + m + "," + n);
		},
		
		// - 响应云台控制（拖拽、鼠标滚轮）事件
		Fire_PTZControl : function(_action, winObj)
		{
			try
			{
				var fn = "NPPILY.WindowAttachEvent.Fire_PTZControl";
				
				if (winObj.wnd && winObj.status && winObj.status.playvideoing)
				{	
					var _direction;
					switch (_action)
					{
						// - 向上拖拽
						case "drag_up" :
							_direction = NPPILY.Enum.PTZDirection.turnup;
							break; 
						// - 向下拖拽
						case "drag_down" :
							_direction = NPPILY.Enum.PTZDirection.turndown;
							break;
						// - 向左拖拽 
						case "drag_left" :
							_direction = NPPILY.Enum.PTZDirection.turnleft;
							break;
						// - 向右拖拽 
						case "drag_right" :
							_direction = NPPILY.Enum.PTZDirection.turnright;
							break;
						// - 停止拖拽 
						case "drag_stop" :
							_direction = NPPILY.Enum.PTZDirection.stopturn;
							break; 
						// - 鼠标滚轮向前
						case "mws_forward" :
							_direction = NPPILY.Enum.PTZDirection.zoomin;
							break; 
						// - 鼠标滚轮向后
						case "mws_backward" :
							_direction = NPPILY.Enum.PTZDirection.zoomout;
							break; 
						// - 停止鼠标滚轮
						case "mws_stop" :
							_direction = NPPILY.Enum.PTZDirection.stopzoom;
							break; 
					}	
				}
				// - 发送云台命令
				var operator = NPPILY.PTZ.Control
				(
					winObj.connectId,
					winObj.params.puid,
					winObj.params.idx,
					_direction,	
					{}
				);
				
				if (NPPILY.Debug.debug)
				{
					NPPUtils.Log(fn, "_action -> " + _action + ", _direction - > " + _direction + ", operator ->" + NrcapError.Detail(operator.rv, true));
				}
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		// - 显示全屏
		Fire_fsw_show : function (winObj, _newWinHandle)
		{
			try
			{
				var fn = "NPPILY.WindowAttachEvent.Fire_fsw_hide";
				
				if (winObj && winObj.wnd && (winObj.status.playvideoing || winObj.status.playvoding) && typeof _newWinHandle != "undefined") 
				{
					winObj.status.isfullscreening = true;
					winObj.wnd["NPP_tmpWinHandle"] = _newWinHandle;
					return NPPIF.SetPlayWindow(NPPILY.Plug.nc, winObj.params.ivStreamHandle, _newWinHandle);	
				}
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		// - 停止全屏
		Fire_fsw_hide : function (winObj, _oldWinHandle)
		{
			try
			{
				var fn = "NPPILY.WindowAttachEvent.Fire_fsw_hide";
				
				if (winObj && winObj.wnd && (winObj.status.playvideoing || winObj.status.playvoding) && typeof _oldWinHandle != "undefined") 
				{
					winObj.status.isfullscreening = false;
					winObj.wnd["NPP_tmpWinHandle"] = _oldWinHandle;
					return NPPIF.SetPlayWindow(NPPILY.Plug.nc, winObj.params.ivStreamHandle, _oldWinHandle);	
				}
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		// - 重绘窗口
		Fire_redraw_window : function (winObj)
		{
			try
			{
				var fn = "NPPILY.WindowAttachEvent.Fire_redraw_window";
				
				if (winObj && winObj.wnd) {
					if (winObj.status.playvideoing || winObj.status.playvoding)
					{
						NPPIF.RedrawLastImage(NPPILY.Plug.nc, winObj.params.ivStreamHandle);
					}
					else
					{
						// - 设置是否重绘背景标志
						NPPIF.SetEraseBkgndFlag(winObj.wnd, 0);
					}
				}
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		// - 自定义右键菜单
		Fire_menu_command : function (winObj, _keyCode, _callback)
		{
			try
			{
				var fn = "NPPILY.WindowAttachEvent.Fire_menu_command";
				
				// NPPUtils.Log(fn, "_keyCode -> " + _keyCode);
				 
				if (winObj && winObj.wnd && typeof winObj.wnd["NPP_customMenus"] != "undefined" /* && (winObj.status.playvideoing || winObj.status.playvoding) */)
				{ 
					if (typeof winObj.wnd["NPP_customMenus"][_keyCode] != "undefined")
					{
						var item = winObj.wnd["NPP_customMenus"][_keyCode];
						
						NPPUtils.Log(fn, "_keyCode -> " + _keyCode + ", item.key -> " + item.key + ", item.text -> " + item.text);
						
						if (typeof _callback == "function")
						{
							_callback(item.key);	
						}
					}
				}
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		end : true
	},
	
	/*
	---
	fn : WindowControlMode
	desc : 窗口控制模式对象
	time : 2013.10.14
	author :
		- huzw
	...
	*/
	WindowControlMode :
	{
		get : function(objWnd)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, ((objWnd && objWnd.wnd) ? (objWnd.wnd["NPP_controlMode"] || 0) : 0));
		},
		/*
		---
		params :
			- objWnd(NPPILY.Struct.WindowStruct) 窗口结构
			- value(uint) 控制模式信号量（0表示拖拽，1表示框选，框选模式时不会全屏）
		...
		*/
		set : function(objWnd, value)
		{
			try
			{
				var fn = "NPPILY.WindowControlMode.set";
				
				if (objWnd && objWnd.wnd)
				{
					var value = (value || 0) != 1 ? 0 : 1;
					var operator = NPPIF.SetControlMode(objWnd.wnd, value);
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						objWnd.wnd["NPP_controlMode"] = value;
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "objWnd wnd not exist~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
				}
			}
			catch(e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		}
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: Mask Control 2014.01.20
    * ........................................................................................................
    **/
	// - 是否使能掩码，窗口控制模式也要同时设定
	EnableMask : function (objWnd, bValue)
	{
		return NPPILY.__Sdk_MaskCtl
		(
		 	"EnableMask", 
			{
				objWnd : (objWnd || null),
				bValue : ((bValue || 0) != 1 ? 0 : 1)
			}
		);
	},
	// - 点击掩码
	MaskClick : function (objWnd, x, y)
	{
		return NPPILY.__Sdk_MaskCtl
		(
		 	"MaskClick", 
			{
				objWnd : (objWnd || null),
				x : (x || 0),
				y : (y || 0)
			}
		);
	},
	// - 选择掩码区域
	MaskSelectRect : function (objWnd, bx, by, ex, ey)
	{
		return NPPILY.__Sdk_MaskCtl
		(
		 	"MaskSelectRect", 
			{
				objWnd : (objWnd || null),
				bx : (bx || 0),
				by : (by || 0),
				ex : (ex || 0),
				ey : (ey || 0)
			}
		);
	},
	/*
	---
	fn : GetMask
	desc : 获取掩码
	returns :
		- response(Array<198个十进制数值>)
	params : 
		- objWnd(NPPILY.Struct.WindowStruct) 窗口信息结构
	...
	*/
	GetMask : function (objWnd)
	{
		return NPPILY.__Sdk_MaskCtl
		(
		 	"GetMask", 
			{
				objWnd : (objWnd || null)
			}
		);
	},
	/*
	---
	fn : SetMask
	desc : 设置掩码
	params : 
		- objWnd(NPPILY.Struct.WindowStruct) 窗口信息结构
		- maskList(Array) 掩码数组，198个十进制数值
	...
	*/
	SetMask : function (objWnd, maskList)
	{
		return NPPILY.__Sdk_MaskCtl
		(
		 	"SetMask", 
			{
				objWnd : (objWnd || null),
				maskList : (maskList || [])
			}
		);
	},
	__Sdk_MaskCtl : function (action, options)
	{
		try
		{
			var fn = "NPPILY.__Sdk_MaskCtl";
			 
			var options = options || {};
			
			if (options.objWnd && options.objWnd.wnd)
			{
				if (!options.objWnd.connectId || !NPPILY.Connections.get(options.objWnd.connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR); 
				}
				var _connStruct = NPPILY.Connections.get(options.objWnd.connectId);
				
				if (options.objWnd.wnd && (options.objWnd.status.playvideoing || options.objWnd.status.playvoding))
				{
					switch (action)
					{
						case "EnableMask" :
							return NPPIF.EnableMask(_connStruct.nc, options.objWnd.params.ivStreamHandle, options.bValue);
							break;
						case "MaskClick" :
							return NPPIF.MaskClick(_connStruct.nc, options.objWnd.params.ivStreamHandle, options.x, options.y);
							break;
						case "MaskSelectRect" :
							return NPPIF.MaskSelectRect(_connStruct.nc, options.objWnd.params.ivStreamHandle, options.bx, options.by, options.ex, options.ey);
							break;
						case "GetMask" :
							return NPPIF.GetMask(_connStruct.nc, options.objWnd.params.ivStreamHandle);
							break;
						case "SetMask" :
							return NPPIF.SetMask(_connStruct.nc, options.objWnd.params.ivStreamHandle, options.maskList);
							break;
					} 
				}
				else
				{
					NPPUtils.Log(fn, "window no playing~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY); 
				}
			}
			else
			{
				NPPUtils.Log(fn, "objWnd wnd not exist~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}	
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: Mask Control 2014.01.20
    * ........................................................................................................
    **/
	/*
    ---
    fn: PlayVideo 
    desc: 播放视频
    author:
        - zenghx  
    time: 2013.09.05 
    returns: 
		- NrcapError
    params: 
		- connectId	(string) 连接ID
        - objWnd (NPPILY.Struct.WindowStruct) 窗口对象
		- puid (string) 设备ID 
		- idx (string) 视频资源索引
		- streamType (string) 流类型
		- customParams (object) 自定义参数
    ... 
    */
	PlayVideo : function (connectId, objWnd, puid, idx, streamType, customParams) 
	{
		try
		{
			var fn = "NPPILY.PlayVideo";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId not exist~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			
			if (objWnd && objWnd.wnd)
			{
				var _connStruct = NPPILY.Connections.get(connectId);
				
				if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				if (!puid || !NPPILY.puidRex.test(puid)) 
				{
					NPPUtils.Log(fn, "puid error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
				}
				if (isNaN(idx) || !NPPILY.intRex.test(idx)) 
				{
					NPPUtils.Log(fn, "idx error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR);
				}
				
				var streamType = streamType || NPPILY.Enum.NrcapStreamType.REALTIME;
				
				// - 检测设备是否在线
				var operator = NPPILY.NPPSDKCommon.PUIsOnline(connectId, puid);
				if (operator.rv == NrcapError.NRCAP_ERROR_PU_OFFLINE) 
				{
					NPPUtils.Log(fn, "pu not online error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PU_OFFLINE);	
				}
				
				var customParams = customParams || {};
				
				var _ivHandle;
				
				// - 视频对应的资源句柄
				if (customParams._HANDLE) {
					_ivHandle = customParams._HANDLE;
				}
				else {
					var operator = NPPILY.NPPSDKCommon.GetHandle
					(
						connectId,
						puid,
						NPPILY.Enum.PuResourceType.VideoIn,
						idx
					);
					
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						_ivHandle = operator.response;
					}
					else
					{
						NPPUtils.Log(fn, "get iv handle error~");
						return operator;
					}
				}
				
				var operator = NPPIF.StartStreamPlay(_connStruct.nc, _ivHandle, streamType, objWnd.wndHandle);
				if (operator.rv != NrcapError.NRCAP_SUCCESS) 
				{
					return new NPPILY.Struct.ReturnValueStruct(operator.rv);
				}
				
				objWnd.connectId = connectId;
				objWnd.params.puid = puid;
				objWnd.params.idx = idx;
				objWnd.params.streamType = streamType;
				
				objWnd.wnd["NPP_transcodeStreamPlaying"] = false;
				objWnd["NPP_wndObjects"]["NPP_transcodeStreamPlaying"] = false;
 
				objWnd.params.ivStreamHandle = operator.response;
				objWnd.status.playvideoing = true;
				
				// - 设置是否重绘背景标志
				NPPIF.SetEraseBkgndFlag(objWnd.wnd, 1);
				
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS); 
			}
			else {
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
    ---
    fn: PlayTranscodeVideo 
    desc: 播放平台转码视频
    author:
        - huzw  
    time: 2014.02.18
    params: 
		- connectId	(string) 连接ID
        - objWnd (NPPILY.Struct.WindowStruct) 窗口对象
		- puid (string) 设备ID 
		- idx (string) 视频资源索引 
    ... 
    */
	PlayTranscodeVideo : function (connectId, objWnd, puid, idx, alg, resolution, bitRate, frameRate)
	{
		try
		{
			var fn = "NPPILY.PlayTranscodeVideo";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId not exist~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			
			if (objWnd && objWnd.wnd)
			{
				var _connStruct = NPPILY.Connections.get(connectId);
				
				if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				
				if (!puid || !NPPILY.puidRex.test(puid)) 
				{
					NPPUtils.Log(fn, "puid error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
				}
				if (isNaN(idx) || !NPPILY.intRex.test(idx)) 
				{
					NPPUtils.Log(fn, "idx error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR);
				}
				if (typeof alg == "undefined" || alg == null || typeof resolution == "undefined" || resolution == null || typeof bitRate == "undefined" || bitRate == null || typeof frameRate == "undefined" || frameRate == null)
				{
					NPPUtils.Log(fn, "alg | resolution | bitRate | frameRate error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
				}
				// - 检测设备是否在线
				var operator = NPPILY.NPPSDKCommon.PUIsOnline(connectId, puid);
				if (operator.rv == NrcapError.NRCAP_ERROR_PU_OFFLINE) 
				{
					NPPUtils.Log(fn, "pu not online error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PU_OFFLINE);	
				}
				var handle_operator = NPPILY.NPPSDKCommon.GetHandle
				(
					connectId,
					puid,
					NPPILY.Enum.PuResourceType.VideoIn,
					idx
				);
				if (handle_operator.rv != NrcapError.NRCAP_SUCCESS)
				{
					return handle_operator;
				}
				else
				{
					var play_operator = NPPIF.StartTranscodeStreamPlay
					(
						_connStruct.nc,
						handle_operator.response,
						alg,
						resolution,
						bitRate,
						frameRate,
						objWnd.wndHandle
					);
					if (play_operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						objWnd.connectId = connectId;
						objWnd.params.puid = puid;
						objWnd.params.idx = idx;
						
						objWnd.params.alg = alg;
						objWnd.params.resolution = resolution;
						objWnd.params.bitRate = bitRate;
						objWnd.params.frameRate = frameRate;
						
						// - 流类型置为转码流
						objWnd.params.streamType = NPPILY.Enum.NrcapStreamType.TRANSCODE; 
						// - 记录转码播放
						objWnd.wnd["NPP_transcodeStreamPlaying"] = true;
						objWnd["NPP_wndObjects"]["NPP_transcodeStreamPlaying"] = true;
						
						objWnd.params.ivStreamHandle = play_operator.response;
						objWnd.status.playvideoing = true;
						
						// - 设置是否重绘背景标志
						NPPIF.SetEraseBkgndFlag(objWnd.wnd, 1);	
					}
					return play_operator;
				}
			}
			else
			{
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
    ---
    fn: StopVideo 
    desc: 停止播放
    author:
        - zenghx
		- huzw
    time: 2013.09.06
	mdftime: 2015.02.26
    returns: 
        - NrcapError
    params: 
        - objWnd (NPPILY.Struct.WindowStruct)        // - 窗口对象
    ... 
    */
	StopVideo : function (objWnd)
	{
		try
		{
			var fn = "NPPILY.StopVideo";
			if (objWnd) 
			{
				var connectId = objWnd.connectId;
				if (connectId && NPPILY.Connections.get(connectId)) 
				{
					var cs = NPPILY.Connections.get(connectId);
					if (cs.status != NPPILY.Enum.ConnectionStatus.Connected) 
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					
					if (typeof objWnd.wnd == "undefined" || !objWnd.wnd)
					{
						NPPUtils.Log(fn, "objWnd.wnd not exist, rv -> " + NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
					}
					
					if (objWnd.status.playvideoing) 
					{
						var ivStreamHandle = objWnd.params.ivStreamHandle;
						var iaStreamHandle = objWnd.params.iaStreamHandle;
						
						if (objWnd.status.playaudioing)
						{	
							NPPIF.StopStreamPlay(cs.nc, iaStreamHandle);
						}
						if (objWnd.status.recording)
						{
							NPPIF.StopRecord(cs.nc, ivStreamHandle);
						}						
						
						if (objWnd.status.isfullscreening)
						{
							NPPIF.ExitFullScreen(objWnd.wnd);
						}
						
						NPPIF.StopStreamPlay(cs.nc, ivStreamHandle);
						
						objWnd.connectId = null;
						objWnd.status.playvideoing = false;
						objWnd.status.playaudioing = false;
						objWnd.status.recording = false;
						objWnd.status.isddrawing = false;
						objWnd.status.isfullscreening = false;
						objWnd.params.puid = null;
						objWnd.params.idx = 0;
						objWnd.params.ivStreamHandle = "";
						objWnd.params.iaStreamHandle = "";
					}
					
					// - 设置是否重绘背景标志
					NPPIF.SetEraseBkgndFlag(objWnd.wnd, 0);
						
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else
				{
					NPPUtils.Log(fn, "connectId not exist");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn : ResizeWindowDimension
	desc : 改变视频窗口插件宽高
	time : 2014.01.08
	author :
		- huzw
	params : 
		- objWnd(NPPILY.Struct.WindowStruct) 窗口信息结构
		- width(uint|string|percent) 宽度，数值或字符串或百分比如0 | 50px | 50em | 100%，缺省为0
		- height(uint|string|percent) 高度，数值或字符串或百分比如0 | 50px | 50em | 100%，缺省为0
	remark :
		- 实时视频与点播回放均支持
		- 传的是不带单位的数值，将会在后面增加px后缀设置
	...
	*/
	ResizeWindowDimension : function (objWnd, width, height)
	{
		try
		{
			var fn = "NPPILY.ResizeWindowDimension";
			
			if (objWnd && objWnd.wnd) 
			{
				var width = String(width || 0).toLowerCase(),
					height = String(height || 0).toLowerCase();
				
				if (width.search("%") == -1 && width.search("px") == -1 && width.search("em") == -1) {
					width += "px";
				}
				if (height.search("%") == -1 && height.search("px") == -1 && height.search("em") == -1) {
					height += "px";
				}
				
				objWnd.wnd.style.width = width;
				objWnd.wnd.style.height = height;
				
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);	
			}
			else
			{
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);	
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	/*
    ---
    fn: PlayAudio 
    desc: 开启、停止播放实时视频伴音
    author:
        - zenghx
		- huzw
    time: 2013.09.06
	mdftime: 2014.02.25
    returns: 
        - NrcapError
    params: 
        - objWnd(NPPILY.Struct.WindowStruct)        // - 窗口对象
		- customParams(object) 自定义参数
		{
			_HANDLE(HANDLE) 音频资源句柄	
		}
    ... 
    */
	PlayAudio : function (objWnd, customParams) 
	{
		try
		{
			var fn = "NPPILY.PlayAudio";
			
			if (objWnd && objWnd.wnd) 
			{
				var connectId = objWnd.connectId;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
					
				var _connStruct = NPPILY.Connections.get(connectId),
					customParams = customParams || {},
					puid = objWnd.params.puid,
					streamType = objWnd.params.streamType || NPPILY.Enum.NrcapStreamType.REALTIME,
					resIAIdx = objWnd.params.idx || customParams.idx || 0,
					resIAHandle = customParams._HANDLE || null;
				
				if (objWnd.wnd["NPP_transcodeStreamPlaying"] == true ||
					objWnd["NPP_wndObjects"]["NPP_transcodeStreamPlaying"] == true)
				{
					streamType = NPPILY.Enum.NrcapStreamType.REALTIME;	
				}
				
				if (!puid || !NPPILY.puidRex.test(puid)) 
				{
					NPPUtils.Log(fn, "puid error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
				}
				if (isNaN(resIAIdx) || !NPPILY.intRex.test(resIAIdx)) 
				{
					NPPUtils.Log(fn, "idx error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR);
				}
				
				if (objWnd.status && objWnd.status.playvideoing)
				{
					if (objWnd.status.playaudioing)
					{
						var iaStreamHandle = objWnd.params.iaStreamHandle;
						if (iaStreamHandle) {
							NPPIF.StopStreamPlay(_connStruct.nc, iaStreamHandle);
						}
						objWnd.params.iaStreamHandle = "";
						objWnd.status.playaudioing = false;
					}
					else
					{
						// - 视频对应的资源句柄
						if (!resIAHandle) 
						{
							var operator = NPPILY.NPPSDKCommon.GetHandle
							(
								connectId,
								puid,
								NPPILY.Enum.PuResourceType.AudioIn,
								resIAIdx
							);
							
							if (operator.rv == NrcapError.NRCAP_SUCCESS)
							{
								resIAHandle = operator.response;
							}
							else
							{
								NPPUtils.Log(fn, "get ia handle error~");
								return operator;
							}
						}
						var operator = NPPIF.StartStreamPlay
						(
							_connStruct.nc, 
							resIAHandle, 
							streamType, 
							(objWnd.wnd["NPP_tmpWinHandle"] || objWnd.wndHandle)
						);
						
						if (operator.rv != NrcapError.NRCAP_SUCCESS) 
						{
							return new NPPILY.Struct.ReturnValueStruct(operator.rv);
						}
						
						objWnd.params.iaStreamHandle = operator.response;
						objWnd.status.playaudioing = true;
					}
						
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else
				{
					NPPUtils.Log(fn, "playvideoing false");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}
			}
			else 
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: 撤销及恢复绑定窗口 @huzw 2015.01.15
    * ........................................................................................................
    **/
	/*
	---
	fn: DiscardWindow
	desc: 撤销窗口
	author: 
		- huzw
    returns: 
        - Object(NPPILY.Struct.ReturnValueStruct)
	params:
		- objWnd(NPPILY.Struct.WindowStruct) 窗口对象
	...
	*/
	DiscardWindow : function(objWnd)
	{
		try
		{
			var fn = "NPPILY.DiscardWindow";
			
			if (objWnd && objWnd.wnd) 
			{
				var connectId = objWnd.connectId;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				
				var operator = new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				
				if (objWnd && objWnd.params.ivStreamHandle)
				{
					operator = NPPIF.SetPlayWindow(NPPILY.Plug.nc, objWnd.params.ivStreamHandle, "");
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						try {
							// 移除wnd插件实例元素
							if (typeof objWnd.wnd.parentNode != "undefined") {
								objWnd.wnd.parentNode.removeChild(objWnd.wnd);
							}
							else {
								if (objWnd.container) {
									objWnd.container.removeChild(objWnd.wnd);
								}
							}
						}
						catch (e) {
						}
						
						objWnd.container = null;
						objWnd.containerId = null;
						objWnd.wnd = null;
						objWnd.wndHandle = "";
						objWnd.wndName = "";
						objWnd["NPP_wndObjects"]["wndHandle"] = "";
						objWnd["NPP_wndObjects"]["NPP_b_DiscardWindow"] = true;
					}
				}
				
				return operator;
			}
			else
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: RestoreWindow
	desc: 恢复窗口
	author: 
		- huzw
    returns: 
        - Object(NPPILY.Struct.ReturnValueStruct)
	params:
		- objWnd(NPPILY.Struct.WindowStruct) * 窗口对象
		- containerOrId(element | element dom id) * 新的窗口容器对象或ID
		- windowEvent(NPPILY.Struct.WindowEventStruct) 信息窗口事件（缺省时，将使用objWnd原先记录的事件信息）
	...
	*/
	RestoreWindow : function(objWnd, containerOrId, windowEvent)
	{
		try
		{
			var fn = "NPPILY.RestoreWindow";
			
			if (objWnd)
			{
				var connectId = objWnd.connectId;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				
				var container = null;
				if (typeof containerOrId == "object" && typeof containerOrId.id != "undefined")
				{
					container = containerOrId;	
				}
				else
				{
					if (typeof containerOrId == "undefined" || containerOrId == null || !document.getElementById(containerOrId))
					{	
						NPPUtils.Log(fn, "containerOrId error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					}
					
					container = document.getElementById(containerOrId);
				}
				
				var t_wndname = container.id + "_wnd"; 
				
				container.innerHTML = NPPILY.Plug.Html.get("wnd").replace(/(@id)|(@name)/g, t_wndname);
				
				if (!container.firstChild && container.firstChild.id != t_wndname && !document.getElementById(t_wndname))
				{
					NPPUtils.Log(fn, "include wnd plugin error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
				}
				
				var wnd = container.firstChild || document.getElementById(t_wndname);
				
				objWnd.container = container;
				objWnd.containerId = container.id;
						
				// 重新赋值给wnd
				objWnd.wnd = wnd;
				objWnd.wndName = t_wndname;
				
				// 改变窗口插件大小
				NPPILY.ResizeWindowDimension(objWnd, '100%', '100%');
				
				// 获取窗口插件句柄
				var operator = NPPIF.GetWindowHandle(objWnd.wnd);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					objWnd.wndHandle = operator.response;
					objWnd["NPP_wndObjects"]["wndHandle"] = operator.response;
					// 重新绑定窗口
					objWnd.wnd["NPP_tmpWinHandle"] = operator.response;
					objWnd["NPP_wndObjects"]["NPP_tmpWinHandle"] = operator.response;
					
					if (objWnd.params.ivStreamHandle) {
						// 先记录右键菜单项
						var cms = [];
						var npp_we = null;
						
						if (typeof windowEvent != "undefined")
						{
							npp_we = windowEvent;
						}
						else
						{
							npp_we = objWnd["NPP_wndObjects"]["NPP_originalWindowEvent"];
						}
						var npp_cms = objWnd["NPP_wndObjects"]["NPP_customMenus"];
						for(var key in npp_cms) {
							cms.push(npp_cms[key]);
						}
						npp_we.menu_command.menu = cms;
						
						// 重新绑定事件
						NPPILY.WindowAttachEvent.Init(objWnd, npp_we)
						
						// 恢复绑定新的窗口句柄
						NPPIF.SetPlayWindow(NPPILY.Plug.nc, objWnd.params.ivStreamHandle, operator.response);
						
						// 设置是否重绘背景标志
						NPPIF.SetEraseBkgndFlag(objWnd.wnd, 1);
					}
				}
				
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
			}
			else
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	/*
	---
	fn: RefreshAttachWindow
	desc: 刷新绑定窗口（用以解决某些浏览器页面元素隐藏再显示时没有画面）
	...
	*/
	RefreshAttachWindow : function (objWnd)
	{
		try
		{
			var fn = "NPPILY.RefreshAttachWindow";
			
			if (objWnd && objWnd.wnd)
			{
				// 获取窗口插件句柄
				var operator = NPPIF.GetWindowHandle(objWnd.wnd);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					objWnd.wndHandle = operator.response;
					objWnd["NPP_wndObjects"]["wndHandle"] = operator.response;
					// 重新绑定窗口
					objWnd.wnd["NPP_tmpWinHandle"] = operator.response;
					objWnd["NPP_wndObjects"]["NPP_tmpWinHandle"] = operator.response;
					
					// 先记录右键菜单项
					var cms = [];
					var npp_we = objWnd["NPP_wndObjects"]["NPP_originalWindowEvent"];
					var npp_cms = objWnd["NPP_wndObjects"]["NPP_customMenus"];
					for(var key in npp_cms) {
						cms.push(npp_cms[key]);
					}
					npp_we.menu_command.menu = cms;
					
					// 重新绑定事件
					NPPILY.WindowAttachEvent.Init(objWnd, npp_we);
					
					if (objWnd.params.ivStreamHandle) {
						// 恢复绑定新的窗口句柄
						NPPIF.SetPlayWindow(NPPILY.Plug.nc, objWnd.params.ivStreamHandle, operator.response);
						
						// 设置是否重绘背景标志
						NPPIF.SetEraseBkgndFlag(objWnd.wnd, 1);
					}
				}
				
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
			}
			else
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: 撤销及恢复绑定窗口 @huzw 2015.01.15
    * ........................................................................................................
    **/
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: 录像回放点播操作
    * ........................................................................................................
    **/
	/*
    ---
    fn: PlayVod 
    desc: 录像回放点播
    author:
        - huzw  
    time: 2013.11.04 
    returns: 
        - NrcapError
    params: 
		- connectId(string) * // - 连接ID
        - objWnd(NPPILY.Struct.WindowStruct) * // - 窗口对象（NPPILY.Enum.WindowType.VOD类型）
		- options(object) 点播相关参数
		{
			type(NPPILY.Enum.StorageFileType) * 存储文件类型
			csuPuid(string) * 中心存储器PUID
			csuIndex(uint) 中心存储单元资源索引，缺省为0
			puid(string) * 点播对象（设备）PUID
			sgIndex(uint) 前端点播时存储器资源索引
			ivIndex(uint) 点播对象（摄像头）资源索引，缺省为0
			fileFullPath(string) 点播的录像文件路径
			speed(uint) 播放速度，缺省0为正常速度
			direction(uint) 播放时间轴方向，1正向（缺省），0倒向
			relativeStartTime(UTC timestamp) 相对播放开始时间（缺省为0秒）
			beginTime(UTC timestamp) 录像开始时间
			endTime(UTC timestamp) 录像结束时间
		}
	remark:
	 	- 点播平台存储录像，type=NPPILY.Enum.StorageFileType.Platform时，可选下列参数传入csuPuid、csuIndex、puid、ivIndex、fileFullPath、speed、direction、relativeStartTime
　　		- 点播前端CEFS录像，type=NPPILY.Enum.StorageFileType.CEFS时，可选下列参数传入puid、ivIndex、speed、direction、beginTime、endTime
    ... 
	*/
	PlayVod : function(connectId, objWnd, options)
	{
		try
		{
			var fn = "NPPILY.PlayVod";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			if (!objWnd || !objWnd instanceof NPPILY.Struct.WindowStruct || !objWnd.wnd)
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
			
			var o = options = options || {};
			if (!o.type)
			{
				NPPUtils.Log(fn, "type error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
			}
			if (!o.puid || !NPPILY.puidRex.test(o.puid))
			{
				NPPUtils.Log(fn, "puid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
			}
			o.ivIndex = typeof o.ivIndex != "undefined" || !isNaN(o.ivIndex) ? o.ivIndex : 0;
			o.sgIndex = typeof o.sgIndex != "undefined" || !isNaN(o.sgIndex) ? o.sgIndex : 0;
			
			var _connStruct = NPPILY.Connections.get(connectId);
			
			o.speed = typeof o.speed != "undefined" || !isNaN(o.speed) ? o.speed : 0;
			o.direction = typeof o.direction != "undefined" || !isNaN(o.direction) ? o.direction : 1; 
			o.relativeStartTime = typeof o.relativeStartTime != "undefined" || !isNaN(o.relativeStartTime) ? o.relativeStartTime : 0;
					
			switch (o.type)
			{
				case NPPILY.Enum.StorageFileType.Platform : 
					if (!o.csuPuid || !NPPILY.puidRex.test(o.csuPuid))
					{
						NPPUtils.Log(fn, "csuPuid error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);	
					}
					o.csuIndex = typeof o.csuIndex != "undefined" || !isNaN(o.csuIndex) ? o.csuIndex : 0; 
					
					var csuhandle_operator = NPPILY.NPPSDKCommon.GetHandle
					(
						connectId,
						o.csuPuid,
						NPPILY.Enum.PuResourceType.SC,
						o.csuIndex
					);
					if (csuhandle_operator.rv != NrcapError.NRCAP_SUCCESS)
					{
						NPPUtils.Log(fn, "get csu handle error~");
						if (csuhandle_operator.rv == NrcapError.NRCAP_ERROR)
						{
							csuhandle_operator.rv = NrcapError.NRCAP_ERROR_HANDLE_ERROR;	
						}
						return new NPPILY.Struct.ReturnValueStruct(csuhandle_operator.rv);	
					}
					
					var isPlayVodByTime = (!o.fileFullPath ? true : false);
					
					if (isPlayVodByTime)
					{
						if (!o.beginTime || isNaN(o.beginTime) || !o.endTime || isNaN(o.endTime))
						{
							NPPUtils.Log(fn, "fileFullPath | beginTime | endTime error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						
						var ivhandle_operator = NPPILY.NPPSDKCommon.GetHandle
						(
							connectId,
							o.puid,
							NPPILY.Enum.PuResourceType.VideoIn,
							o.ivIndex
						);
						if (ivhandle_operator.rv != NrcapError.NRCAP_SUCCESS)
						{
							NPPUtils.Log(fn, "play vod by time -> get iv handle error~");
							if (ivhandle_operator.rv == NrcapError.NRCAP_ERROR)
							{
								ivhandle_operator.rv = NrcapError.NRCAP_ERROR_HANDLE_ERROR;	
							}
							return new NPPILY.Struct.ReturnValueStruct(ivhandle_operator.rv);	
						}
						var operator = NPPIF.SC_VODTimePlay
						(
							_connStruct.nc,
							csuhandle_operator.response,
							ivhandle_operator.response,
							o.beginTime,
							o.endTime,
							o.speed,
							o.direction,
							objWnd.wndHandle 	 
						);
					}
					else
					{
						var operator = NPPIF.SC_VODFilePlay
						(
							_connStruct.nc, 
							csuhandle_operator.response, 
							o.fileFullPath, 
							o.speed, 
							o.direction, 
							o.relativeStartTime, 
							objWnd.wndHandle 	 
						);
					}
					
					if (operator.rv != NrcapError.NRCAP_SUCCESS)
					{
						NPPUtils.Log(fn, "play vod failed~");
						return new NPPILY.Struct.ReturnValueStruct((NPPILY.Debug.debug ? operator.rv : NrcapError.NRCAP_FAILED));	
					}
					
					objWnd.params.csuPuid = o.csuPuid;
					objWnd.params.csuIndex = o.csuIndex;
					
					if (isPlayVodByTime)
					{
						objWnd.params.fileFullPath = o.fileFullPath;
						objWnd.params.relativeStartTime = o.relativeStartTime;
					}
					else
					{
						objWnd.params.beginTime = o.beginTime;
						objWnd.params.endTime = o.endTime;
					}
					break;
				case NPPILY.Enum.StorageFileType.CEFS : 
					if (!o.beginTime || isNaN(o.beginTime) || !o.endTime || isNaN(o.endTime))
					{
						NPPUtils.Log(fn, "fileFullPath | beginTime | endTime error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					}
					var sghandle_operator = NPPILY.NPPSDKCommon.GetHandle
					(
						connectId,
						o.puid,
						NPPILY.Enum.PuResourceType.Storager,
						o.sgIndex
					);
					if (sghandle_operator.rv != NrcapError.NRCAP_SUCCESS)
					{
						NPPUtils.Log(fn, "play cefs vod -> get sg handle error~");
						if (sghandle_operator.rv == NrcapError.NRCAP_ERROR)
						{
							sghandle_operator.rv = NrcapError.NRCAP_ERROR_HANDLE_ERROR;	
						}
						return new NPPILY.Struct.ReturnValueStruct(sghandle_operator.rv);	
					}
					var operator = NPPIF.SG_CEFSVODFilePlay
					(
						_connStruct.nc, 
						sghandle_operator.response, 
						o.beginTime, 
						o.endTime, 
						o.ivIndex,
						o.speed,
						o.direction,
						objWnd.wndHandle 	 
					);
					if (operator.rv != NrcapError.NRCAP_SUCCESS)
					{
						NPPUtils.Log(fn, "play cefs vod failed~");
						return new NPPILY.Struct.ReturnValueStruct((NPPILY.Debug.debug ? operator.rv : NrcapError.NRCAP_FAILED));	
					}
					
					objWnd.params.beginTime = o.beginTime;
					objWnd.params.endTime = o.endTime;
					break;
				case NPPILY.Enum.StorageFileType.FAT32 : 
					
					break;	
			}
			
			objWnd.connectId = connectId;
			
			objWnd.status.playvoding = true;
			objWnd.status.playaudioing = true; // - 声音默认是开启的
			
			objWnd.params.ivStreamHandle = operator.response;
			objWnd.params.puid = o.puid;
			objWnd.params.idx = o.ivIndex;
			objWnd.params.speed = o.speed;
			objWnd.params.direction = o.direction;
			
			// - 设置是否重绘背景标志
			NPPIF.SetEraseBkgndFlag(objWnd.wnd, 1);
			
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, operator.response);	
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);	
		}
	},
	// - 停止点播
	StopVod : function(objWnd)
	{
		try
		{
			var fn = "NPPILY.StopVod";
			
			if (objWnd && objWnd.wnd) 
			{
				var connectId = objWnd.connectId;
				if (connectId && NPPILY.Connections.get(connectId)) 
				{
					var _connStruct = NPPILY.Connections.get(connectId);
					if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					if (objWnd.status.playvoding) 
					{
						var ivStreamHandle = objWnd.params.ivStreamHandle;
						
						if (objWnd.status.recording)
						{
							NPPIF.StopRecord(_connStruct.nc, ivStreamHandle);
						}						
						
						if (objWnd.status.isfullscreening)
						{
							NPPIF.ExitFullScreen(objWnd.wnd);	
						}
						
						NPPIF.StopStreamPlay(_connStruct.nc, ivStreamHandle);
						
						objWnd.connectId = null;
						objWnd.status.playvoding = false;
						objWnd.status.playaudioing = false;
						objWnd.status.recording = false;
						objWnd.status.isddrawing = false;
						objWnd.status.isfullscreening = false;
						objWnd.params.puid = null;
						objWnd.params.idx = 0;
						objWnd.params.ivStreamHandle = "";
					}
					
					// - 设置是否重绘背景标志
					NPPIF.SetEraseBkgndFlag(objWnd.wnd, 0);
						
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else 
				{
					NPPUtils.Log(fn, "ConnectId noexist!");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
			}
			else 
			{
				NPPUtils.Log(fn, "objWnd wnd error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);	
		}
	},	
	// - 播放或停止点播声音
	PlayVodAudio : function (objWnd)
	{
		try
		{
			var fn = "NPPILY.PlayVodAudio";
			
			if (objWnd && objWnd.wnd) 
			{
				var connectId = objWnd.connectId;
				if (connectId && NPPILY.Connections.get(connectId)) 
				{
					var _connStruct = NPPILY.Connections.get(connectId);
					if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
					{
						NPPUtils.Log(fn, "connect havn't success~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					if (objWnd.status.playvoding) 
					{
						var operator;
						if (!objWnd.status.playaudioing)
						{
							operator = NPPIF.OpenAudio(_connStruct.nc, objWnd.params.ivStreamHandle);
							if (operator.rv != NrcapError.NRCAP_SUCCESS)
							{
								NPPUtils.Log(fn, "open vod audio failed~");
								return new NPPILY.Struct.ReturnValueStruct((NPPILY.Debug.debug ? operator.rv : NrcapError.NRCAP_FAILED));	
							}
							objWnd.status.playaudioing = true;
						}
						else
						{
							operator = NPPIF.CloseAudio(_connStruct.nc, objWnd.params.ivStreamHandle);
							if (operator.rv != NrcapError.NRCAP_SUCCESS)
							{
								NPPUtils.Log(fn, "close vod audio failed~");
								return new NPPILY.Struct.ReturnValueStruct((NPPILY.Debug.debug ? operator.rv : NrcapError.NRCAP_FAILED));	
							}
							objWnd.status.playaudioing = false;
						}
					}
					
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else 
				{
					NPPUtils.Log(fn, "ConnectId noexist!");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
			}
			else 
			{
				NPPUtils.Log(fn, "objWnd wnd error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: 录像回放点播操作
    * ........................................................................................................
    **/	
	/*
    ---
    fn: LocalRecord 
    desc: 本地录像
    author:
        - zenghx
		- huzw
    time: 2013.09.25
	mdftime: 2013.11.26
    returns: 
        - NrcapError
    params: 
        - objWnd(NPPILY.Struct.WindowStruct) * 窗口对象
		- savePath(String) 存储路径目录，缺省为C:/
		- fileName(String) 本地存储文件名，缺省格式为yyyyMMdd_HHmmss.avi
    ... 
    */
	LocalRecord : function (objWnd, savePath, fileName) 
	{
		try 
		{
			var fn = "NPPILY.LocalRecord";
			if (objWnd && objWnd.wnd) 
			{
				var connectId = objWnd.connectId;
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				var _connStruct = NPPILY.Connections.get(connectId);
				if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected)
				{
					NPPUtils.Log(fn, "connection hav't build error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				
				var savePath = savePath || "C:/";
				var fileName = fileName || (NPPUtils.DateFormat("yyyy#MM#dd#_#HH#mm#ss").replace(/#/g, "") + ".avi");
				var saveAsFilePath = savePath + "/" + fileName;
				
				if (objWnd.status.playvideoing || objWnd.status.playvoding) 
				{
					var ivStreamHandle = objWnd.params.ivStreamHandle;
					if (!objWnd.status.recording) 
					{
						var operator = NPPIF.StartRecord(_connStruct.nc, ivStreamHandle, saveAsFilePath);
					
						if (operator.rv == NrcapError.NRCAP_SUCCESS) 
						{
							objWnd.status.recording = true;
						}
						else 
						{
							objWnd.status.recording = false;
						}
						return operator;
					}
					else 
					{
						NPPIF.StopRecord(_connStruct.nc, ivStreamHandle);
						objWnd.status.recording = false;
					}
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else 
				{
					NPPUtils.Log(fn, "window no play error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}
			}
			else 
			{
				NPPUtils.Log(fn, "window noexist error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
    ---
    fn: Snapshot 
    desc: 本地抓图
    author:
        - zenghx
		- huzw
    time: 2013.09.25
	mdftime: 2013.11.26
    returns: 
        - NrcapError
    params: 
        - objWnd(NPPILY.Struct.WindowStruct) * 窗口对象
		- savePath(String) 存储路径目录，缺省为C:/
		- fileName(String) 本地存储文件名，可自定义，但必须是bmp类型的，缺省格式为yyyyMMdd_HHmmss_l.bmp（如20140624_153010_560.bmp）
    ... 
    */
	Snapshot : function(objWnd, savePath, fileName)
	{
		try 
		{
			var fn = "NPPILY.Snapshot";
			if (objWnd && objWnd.wnd) 
			{
				var connectId = objWnd.connectId;
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				var _connStruct = NPPILY.Connections.get(connectId);
				if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected)
				{
					NPPUtils.Log(fn, "connection hav't build error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				
				var savePath = savePath || "C:/";
				var fileName = fileName || (NPPUtils.DateFormat("yyyy#MM#dd#_#HH#mm#ss#_#l").replace(/#/g, "")+ ".bmp");
				var saveAsFilePath = savePath + "/" + fileName;
				
				if (objWnd.status.playvideoing || objWnd.status.playvoding) 
				{
					var ivStreamHandle = objWnd.params.ivStreamHandle;
					return NPPIF.Snapshot(_connStruct.nc, ivStreamHandle, saveAsFilePath);
				}
				else 
				{
					NPPUtils.Log(fn, "window no play error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}
			}
			else 
			{
				NPPUtils.Log(fn, "window noexist error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
    ---
    fn: FullScreen 
    desc: 全屏
    author:
        - zenghx  
    time: 2013.09.25
	mdftime: 2014.04.03
    returns: 
        - NrcapError
    params: 
        - objWnd (NPPILY.Struct.WindowStruct)        // - 窗口对象
    ... 
    */
	FullScreen : function(objWnd)
	{
		try
		{
			var fn = "NPPILY.FullScreen";
			if (objWnd && objWnd.wnd) 
			{
				if (objWnd.status.playvideoing || objWnd.status.playvoding) 
				{
					NPPIF.FullScreen(objWnd.wnd);
					objWnd.status.isfullscreening = true;
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else 
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}
			}
			else 
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch(e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);

		}
	},
	/*
    ---
    fn: ExitFullScreen 
    desc: 退出全屏
    author:
        - huzw  
    time: 2013.11.05 
	mdftime: 2014.04.03
    returns: 
        - NrcapError
    params: 
        - objWnd(NPPILY.Struct.WindowStruct) // - 窗口对象
    ... 
    */
	ExitFullScreen : function(objWnd)
	{
		try
		{
			var fn = "NPPILY.ExitFullScreen";
			if (objWnd && objWnd.wnd) 
			{
				if (objWnd.status.playvideoing || objWnd.status.playvoding) 
				{
					NPPIF.ExitFullScreen(objWnd.wnd);
					objWnd.status.isfullscreening = false;
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else 
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}
			}
			else 
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);
			}
		}
		catch(e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);

		}
	},
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: DDraw Mode Control
    * ........................................................................................................
    **/
	/*
	---
	fn : __Sdk_DDraw
	time : 2013.10.11
	...
	*/
	__Sdk_DDraw :
	{
		get : function(objWnd)
		{
			try
			{
				var fn = "NPPILY.__Sdk_DDraw.get";
				if (objWnd && objWnd.wnd)
				{
					if (objWnd.status && objWnd.status.playvideoing) 
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, !!(objWnd.status.isddrawing == true));
					}
					else 
					{
						NPPUtils.Log(fn, "playvideoing false!");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
					}
				}
				else
				{
					NPPUtils.Log(fn, "window noexist!");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);	
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		set : function(objWnd, bValue)
		{
			try
			{
				var fn = "NPPILY.__Sdk_DDraw.set";
				
				if (objWnd && objWnd.wnd)
				{
					if (objWnd.status && (objWnd.status.playvideoing || objWnd.status.playvoding)) 
					{
						var connectId = objWnd.connectId;
						if (!connectId || !NPPILY.Connections.get(connectId))
						{
							NPPUtils.Log(fn, "connectId error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
						}
						var _connStruct = NPPILY.Connections.get(connectId);
						
						var operator = NPPIF.EnableDDraw(_connStruct.nc, objWnd.params.ivStreamHandle, (bValue != 0 ? 1 : 0));//alert(Object.toJSON(operator));
						if (operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							objWnd.status.isddrawing = bValue != 0 ? true : false;
						}
						else
						{
							objWnd.status.isddrawing = false;	
						}
						return operator;
					}
					else 
					{
						NPPUtils.Log(fn, "playvideoing false!");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
					}					
				}
				else
				{
					NPPUtils.Log(fn, "window noexist!");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);	
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		}
	},
	IsDDrawing : function(objWnd)
	{
		return NPPILY.__Sdk_DDraw.get(objWnd);
	},
	EnableDDraw : function(objWnd, bValue)
	{
		return NPPILY.__Sdk_DDraw.set(objWnd, bValue);
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: DDraw Mode Control
    * ........................................................................................................
    **/
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: 窗口叠加字符控制
    * ........................................................................................................
    **/
	/*
	---
	fn : EnableAddText
	desc : 获取或设置是否使能窗口字符叠加
	time : 2013.10.15
	author : 
		- huzw
	params :
		- objWnd(NPPILY.Struct.WindowStruct) * 窗口结构
		- bValue(bool|uint) true|1使能，false|0不使能，省略bValue或bValue=null即获取是否使能叠加
	...
	*/
	EnableAddText : function(objWnd, bValue)
	{
		try
		{
			var fn = "NPPILY.EnableAddText";
			
			if (objWnd && objWnd.wnd)
			{
				if (objWnd.status && objWnd.status.playvideoing) 
				{
					var connectId = objWnd.connectId;
					if (!connectId || !NPPILY.Connections.get(connectId))
					{
						NPPUtils.Log(fn, "connectId error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					var _connStruct = NPPILY.Connections.get(connectId);
					
					if (typeof bValue == "undefined" || bValue == null)
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, objWnd.wnd["NPP_b_ENABLEADDTEXT"] || 0);
					}
					else
					{
						var bValue = (bValue != 0 ? 1 : 0);
						
						var operator = NPPIF.EnableAddText
						(
						 	_connStruct.nc, 
							objWnd.params.ivStreamHandle, 
							bValue
						);
						if (operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							objWnd.wnd["NPP_b_ENABLEADDTEXT"] = bValue;
						}
						return operator;
					}
				}
				else 
				{
					NPPUtils.Log(fn, "playvideoing false!");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}					
			}
			else
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);	
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
    ---
    fn: SetTextAdd
    desc: 向视频窗口叠加字符
    time: 2013.10.15
    params:
    	- objWnd(NPPILY.Struct.WindowStruct) 窗口信息对象 
   	 	- textSets([object|array](NPPILY.Struct.WindowTextAddStruct)) 叠加字符信息参数  
    remark: 
    	- 只当前观看PC受影响
    	- 当只一个设置节点时，不成功返回非0，多于一个节点时，任一个成功设置就返回0，全部不成功返回非0
    ...
    */
	SetTextAdd : function(objWnd, textSets)
	{
		try
		{
			var fn = "NPPILY.SetTextAdd";
			
			if (objWnd && objWnd.wnd)
			{
				if (objWnd.status && objWnd.status.playvideoing) 
				{
					var connectId = objWnd.connectId;
					if (!connectId || !NPPILY.Connections.get(connectId))
					{
						NPPUtils.Log(fn, "connectId error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					var _connStruct = NPPILY.Connections.get(connectId);
					
					var textSets = textSets || {},
						anySuccess = false;
					
					if (typeof textSets != "object")
					{
						NPPUtils.Log(fn, "textSets typeof error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					}
					if (textSets.constructor != Array) {
						textSets = [textSets];
					}
					
					// - 把叠加的区块编号记录下来
					objWnd.wnd["NPP_winTextAddNoStore"] = objWnd.wnd["NPP_winTextAddNoStore"] || {};
								
					for (var i = 0; i < textSets.length; i++)
					{
						var textSet = textSets[i];
						if (textSet instanceof NPPILY.Struct.WindowTextAddStruct)
						{
							var wndBlockNo = textSet.wndBlockNo || 0,
								left = textSet.left || 0,
								top = textSet.top || 0,
								width = textSet.width || 0,
								height = textSet.height || 0,
								color = textSet.color || 0,
								enableTilt = textSet.enableTilt || 0,
								enableUnderline = textSet.enableUnderline || 0,
								fontFamily = textSet.fontFamily || "",
								content = textSet.content || "";
	 						
							if (NPPUtils.GetStringRealLength(fontFamily) > 64)
							{
								NPPUtils.Log(fn, "error fontFamily index of " + i);
								continue;
							}
							if (NPPUtils.GetStringRealLength(content) > 128)
							{
								NPPUtils.Log(fn, "error content index of " + i);
								continue;
							}
	
							var operator = NPPIF.SetTextAdd
							(
								_connStruct.nc,
								objWnd.params.ivStreamHandle,
								wndBlockNo, left, top, width, height, color, enableTilt, enableUnderline, fontFamily, content
							);
							 
							if (operator.rv != NrcapError.NRCAP_SUCCESS)
							{
								objWnd.wnd["NPP_winTextAddNoStore"][wndBlockNo] = false;
								
								NPPUtils.Log(fn, "error SetTextAdd failed index of " + i);
								continue;
							}
							else
							{
								objWnd.wnd["NPP_winTextAddNoStore"][wndBlockNo] = true;
								
								if (!anySuccess) anySuccess = true;
							}
						}
					}
					
					return new NPPILY.Struct.ReturnValueStruct
					(
					 	( anySuccess ? NrcapError.NRCAP_SUCCESS : NrcapError.NRCAP_ERROR )
					);
				}
				else 
				{
					NPPUtils.Log(fn, "playvideoing false!");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}					
			}
			else
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);	
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn : DeleteTextAdd
	desc : 删除叠加的文字信息
	time : 2013.10.15
	author : 
		- huzw
	params :
		- objWnd(NPPILY.Struct.WindowStruct) * 窗口结构
		- wndBlockNo(uint) 叠加的编号，省略时删除所有的信息
	...
	*/
	DeleteTextAdd : function (objWnd, wndBlockNo)
	{
		try
		{
			var fn = "NPPILY.DeleteTextAdd";
			
			if (objWnd && objWnd.wnd)
			{
				if (objWnd.status && objWnd.status.playvideoing) 
				{
					var connectId = objWnd.connectId;
					if (!connectId || !NPPILY.Connections.get(connectId))
					{
						NPPUtils.Log(fn, "connectId error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
					}
					var _connStruct = NPPILY.Connections.get(connectId);
					
					// - 把叠加的区块编号记录下来
					objWnd.wnd["NPP_winTextAddNoStore"] = objWnd.wnd["NPP_winTextAddNoStore"] || {};
					
					var _delAll = false;
					if (typeof wndBlockNo == "undefined" || wndBlockNo == null || isNaN(wndBlockNo))
					{
						_delAll = true;
					}
						
					for (var i in objWnd.wnd["NPP_winTextAddNoStore"])
					{
						if (wndBlockNo == i || _delAll == true)
						{
							NPPIF.DeleteTextAdd(_connStruct.nc, objWnd.params.ivStreamHandle, i);
							objWnd.wnd["NPP_winTextAddNoStore"][i] = false;
						}
					}
					
					if (_delAll == true)
					{
						objWnd.wnd["NPP_winTextAddNoStore"] = {};
					}
					else
					{
						if (typeof objWnd.wnd["NPP_winTextAddNoStore"][wndBlockNo] != "undefined")
						{
							delete objWnd.wnd["NPP_winTextAddNoStore"][wndBlockNo];	
						}
					}
						
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				else 
				{
					NPPUtils.Log(fn, "playvideoing false!");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOPLAY);
				}					
			}
			else
			{
				NPPUtils.Log(fn, "window noexist!");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_WINDOW_NOTEXIST);	
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: 窗口叠加字符控制
    * ........................................................................................................
    **/
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: GPS Modeless
    * ........................................................................................................
    **/
	/*
	---
	remark:
		- customParams._HANDLE(string)GPS资源句柄存在，那么不会再根据puid、gpsIndex获取
	...
	*/
	__Sdk_GPSStreamCtl : function (action, connectId, puid, gpsIndex, customParams)
	{
		try
		{
			var fn = "NPPILY.__Sdk_GPSStreamCtl -> " + action;
			
			var action = action != "Stop" ? "Start" : "Stop"; // - Start | Stop
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			var _connStruct = NPPILY.Connections.get(connectId);
			if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
			{ 
				NPPUtils.Log(fn, "login or session error~");
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
				}
				else
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
				}
			}
			
			var customParams = customParams || {};
			var _gpsHandle = null;
			if (typeof customParams._HANDLE != "undefined" && customParams._HANDLE)
			{
				_gpsHandle = customParams._HANDLE;
			}
			else 
			{
				if (!puid || !NPPILY.puidRex.test(puid))
				{
					NPPUtils.Log(fn, "puid error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
				}
				if (typeof gpsIndex == "undefined" || isNaN(gpsIndex) || !NPPILY.intRex.test(gpsIndex))
				{
					NPPUtils.Log(fn, "gpsIndex error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR);
				}
				var handle_operator = NPPILY.NPPSDKCommon.GetHandle
				(
					connectId,
					puid,
					NPPILY.Enum.PuResourceType.GPS,
					gpsIndex
				);
				if (handle_operator.rv != NrcapError.NRCAP_SUCCESS)
				{
					NPPUtils.Log(fn, "handle_operator error~");
					return handle_operator;	
				}
				_gpsHandle = handle_operator.response;
			}
				
			var operator = NPPIF[(action + "GPSStream")]
			(
				_connStruct.nc,
				_gpsHandle
			);
			if (operator.rv != NrcapError.NRCAP_SUCCESS)
			{
				NPPUtils.Log(fn, action + " gps failed~");
				return new NPPILY.Struct.ReturnValueStruct((NPPILY.Debug.debug ? operator.rv : NrcapError.NRCAP_FAILED), (_gpsHandle || null));
			}
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, (_gpsHandle || null));
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	// - 开启（注册）GPS信号接收通道
	StartGPSStream : function(connectId, puid, gpsIndex, customParams)
	{
		return NPPILY.__Sdk_GPSStreamCtl("Start", connectId, puid, gpsIndex, customParams);
	},
	// - 停止（卸载）GPS信号接收通道
	StopGPSStream : function(connectId, puid, gpsIndex, customParams)
	{
		return NPPILY.__Sdk_GPSStreamCtl("Stop", connectId, puid, gpsIndex, customParams);
	},
	
	/*
	---
	desc: GPS数据
	time: 2013.11.28
	...
	*/
	GPSData :
	{
		// - GPS数据存储
		GetGPSResFromCSU : function (connectId, options)
		{
			return this.__Sdk_GPSDataControl("getgpsres", connectId, options);
		},
		AddGPSResToCSU : function (connectId, options)
		{
			return this.__Sdk_GPSDataControl("addgpsres", connectId, options);
		},
		RemoveGPSResFromCSU : function (connectId, options)
		{
			return this.__Sdk_GPSDataControl("removegpsres", connectId, options);
		},
		
		// - GPS数据查询
		QueryLastGPSDatas : function (connectId, options)
		{
			return this.__Sdk_GPSDataControl("querylast", connectId, options);
		},		
		QueryHistoryGPSDatas : function (connectId, options)
		{
			return this.__Sdk_GPSDataControl("queryhistory", connectId, options);
		},
		QueryGPSDates : function (connectId, options)
		{
			return this.__Sdk_GPSDataControl("dates", connectId, options);
		},
		QueryGPSDateFiles : function (connectId, options)
		{
			return this.__Sdk_GPSDataControl("datefiles", connectId, options);
		},
		
		// - SDK内部GPS数据控制接口
		__Sdk_GPSDataControl : function (action, connectId, options)
		{
			try
			{
				var fn = "NPPILY.GPSData.__Sdk_GPSDataControl -> " + action;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
            		return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				var _connStruct = NPPILY.Connections.get(connectId);
               	
               	if (!_connStruct.session || _connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
				{
					NPPUtils.Log(fn, "login or session error~");
					if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
					}
					else
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
					}		
				}
				
				var o = options = options || {};
				if (!o.csuPuid || !NPPILY.puidRex.test(o.csuPuid))
				{
					NPPUtils.Log(fn, "csuPuid error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);
				}
				o.csuIndex = typeof o.csuIndex != "undefined" || !isNaN(o.csuIndex) ? o.csuIndex : 0;
				o.offset = typeof o.offset != "undefined" || !isNaN(o.offset) ? o.offset : 0;
				o.count = typeof o.count != "undefined" || !isNaN(o.count) ? o.count : 200;
				o.domainRoad = o.domainRoad || ""; 
				
				var operator;
				
				switch (action.toLowerCase())
				{
					case "getgpsres":
						operator = NPPILY.Control.CommonGet
						(
							connectId,
							{
								puid : o.csuPuid,
								resType : NPPILY.Enum.PuResourceType.SC,
								resIdx : o.csuIndex,
								domainRoad : o.domainRoad,
								controlID : "CTL_SC_GetGPSRes",
								param : '<Param Offset="'+o.offset+'" Cnt="'+o.count+'" />'
							}
						);
						break;
					case "addgpsres":
					case "removegpsres":
						// - 当没有o.puid参数时，就会检测o.resourceSets是否存在，o.resourceSets存在，就可以一次添加或删除多条资源信息
						if (!o.puid || !NPPILY.puidRex.test(o.puid))
						{
							if (o.resourceSets == null || typeof o.resourceSets != "object")
							{
								NPPUtils.Log(fn, "puid & resourceSets error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
							}
							else
							{
								if (typeof o.resourceSets == "object" && o.resourceSets.constructor != Array)
								{
									o.resourceSets = [o.resourceSets];	
								}
							}
						}
						else
						{
							// - 当o.puid存在，那么每次最多只添加或删除一条资源信息 
							o.resType = o.resType || NPPILY.Enum.PuResourceType.GPS;
							o.resIdx = typeof o.resIdx != "undefined" || !isNaN(o.resIdx) ? o.resIdx : 0;
							o.optID = o.optID || 151;
							o.value = o.value || NPPILY.Enum.NrcapStreamType.REALTIME;
							
							o.resourceSets = [new NPPILY.Struct.GPSDataStorageResourceStruct(o.puid, o.resType, o.resIdx, o.optID, o.value)];
						}
						
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var xmlObj = new XML.ObjTree();
							xmlObj.xmlDecl = "";
							xmlObj.attr_prefix = "-";
							
							var ResArr = [];
							
							for (var i = 0; i < o.resourceSets.length; i++)
							{
								var item = o.resourceSets[i]; 
								
								if (typeof item.puid != "undefined")
								{
									ResArr.push
									(
									 	{
											"-ObjType" : 151,
											"-ObjID" : item.puid,
											"-Type" : item.resType,
											"-Idx" : (typeof item.resIdx == "undefined" ? 0 : item.resIdx),
											"-OptID" : (item.optID || "CTL_SCHEDULER_StartStream"),
											Param :
											{
												"-Value" : (item.value || NPPILY.Enum.NrcapStreamType.REALTIME)
											}
										} 
									); 
								}
							}
							
							var objSetsJSON =
							{
								ObjSets : 
								{
									Res : (ResArr || [])
								}
							};
							
							operator = NPPILY.Control.CommonGet
							(
								connectId,
								{
									puid : o.csuPuid,
									resType : NPPILY.Enum.PuResourceType.SC,
									resIdx : o.csuIndex,
									domainRoad : o.domainRoad,
									controlID : (action.toLowerCase() == "addgpsres" ? "CTL_SC_AddGPSRes" : "CTL_SC_RemoveGPSRes"),
									param : '<Param SerialNo="'+(o.serialNo||_connStruct.connParam.username)+'" SerialToken="'+MD5.Hex_MD5(o.serialToken||_connStruct.connParam.password)+'" />',
									xmlObjSets : xmlObj.writeXML(objSetsJSON)
								}
							); 
						}
						else
						{
							NPPUtils.Log(fn, "XML.ObjTree error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						break;
					
					case "querylast":
					case "queryhistory":
						if (!o.puid || !NPPILY.puidRex.test(o.puid))
						{
							if (o.resourceSets == null || typeof o.resourceSets != "object")
							{
								NPPUtils.Log(fn, "puid & resourceSets error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
							}
							else
							{
								if (typeof o.resourceSets == "object" && o.resourceSets.constructor != Array)
								{
									o.resourceSets = [o.resourceSets];	
								}
							}
						}
						else
						{
							o.resourceSets = [new NPPILY.Struct.GPSDataStorageResourceStruct(o.puid, o.resType, o.resIdx, null, null)];
						}
						
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var xmlObj = new XML.ObjTree();
							xmlObj.xmlDecl = "";
							xmlObj.attr_prefix = "-";
							
							var operationID = (action.toLowerCase() == "queryhistory" ? "CTL_SC_QueryHistoryGPSData" : "CTL_SC_QueryLastGPSData");
							
							var ResArr = [];
							
							for (var i = 0; i < o.resourceSets.length; i++)
							{
								var item = o.resourceSets[i]; 
								
								if (typeof item.puid != "undefined")
								{
									ResArr.push
									(
									 	{
											"-ObjType" : 151,
											"-ObjID" : item.puid,
											"-Type" : (item.resType || NPPILY.Enum.PuResourceType.GPS),
											"-Idx" : (typeof item.resIdx == "undefined" ? 0 : item.resIdx),
											"-CmdType" : "CTL",
											"-OptID": operationID,
											"-EPID": (_connStruct.connParam.epId || 'system') 
										} 
									); 
								}
							}
							
							var paramJSON = 
							{
								Param : ""	
							};
							if (action == "queryhistory")
							{
								paramJSON = 
								{
									Param :
									{
										"-Offset": o.offset,
										"-Cnt": o.count,
										"-BeginTime": o.beginTime || 0,
										"-EndTime": (o.endTime || Math.ceil(new Date().getTime()/1000)) 
									}
								};	
							}
							
							var objSetsJSON =
							{
								ObjSets : 
								{
									Res : (ResArr || [])
								}
							};
							
							operator = NPPILY.Control.CommonGet
							(
								connectId,
								{
									puid : o.csuPuid,
									resType : NPPILY.Enum.PuResourceType.SC,
									resIdx : o.csuIndex,
									domainRoad : o.domainRoad,
									controlID : operationID,
									param : xmlObj.writeXML(paramJSON),
									xmlObjSets : xmlObj.writeXML(objSetsJSON)
								}
							); 
						}
						else
						{
							NPPUtils.Log(fn, "XML.ObjTree error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						break;
						
					case "dates":
					case "datefiles":
						
						var operationID = (action == "datefiles" ? "CTL_SC_QueryDateGPSData" : "CTL_SC_QueryGPSDate");
						
						if (!o.puid || !NPPILY.puidRex.test(o.puid))
						{
							NPPUtils.Log(fn, "puid error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
						}
						o.resType = o.resType || NPPILY.Enum.PuResourceType.GPS;
						o.resIdx = typeof o.resIdx != "undefined" || !isNaN(o.resIdx) ? o.resIdx : 0;
						
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var xmlObj = new XML.ObjTree();
							xmlObj.xmlDecl = "";
							xmlObj.attr_prefix = "-";
							
							var ResArr = [];
							
							var paramJSON = 
							{
								Param :
								{
									"-Offset": o.offset,
									"-Cnt": o.count
								}
							};
							if (action == "datefiles")
							{
								paramJSON.Param["-Date"] = o.date || 0;
							}
							var objSetsJSON =
							{
								ObjSets : 

								{
									Res :
									{
										"-ObjType" : 151,
										"-ObjID" : o.puid,
										"-Type" : o.resType,
										"-Idx" : o.resIdx,
										"-CmdType" : "CTL",
										"-OptID": operationID,
										"-EPID": (_connStruct.connParam.epId || 'system') 
									} 
								}
							};
							
							operator = NPPILY.Control.CommonGet
							(
								connectId,
								{
									puid : o.csuPuid,
									resType : NPPILY.Enum.PuResourceType.SC,
									resIdx : o.csuIndex,
									domainRoad : o.domainRoad,
									controlID : operationID,
									param : xmlObj.writeXML(paramJSON),
									xmlObjSets : xmlObj.writeXML(objSetsJSON)
								}
							); 
						}
						else
						{
							NPPUtils.Log(fn, "XML.ObjTree error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						break;
				}
				
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					var _response = operator.response || {};
					
					if (_response != null && typeof _response != "undefined")
					{
						switch (action.toLowerCase())
						{
							case "getgpsres":
								var _resArr = [];
								if (typeof _response.Res != "undefined")
								{
									if (_response.Res.constructor != Array)
									{
										_response.Res = [_response.Res];	
									}
									for (var i = 0; i < _response.Res.length; i++)
									{
										_resArr.push
										(
											new NPPILY.Struct.GPSDataStorageResourceStruct
											(
												_response.Res[i].ObjID,
												_response.Res[i].Type,
												_response.Res[i].Idx,
												_response.Res[i].OptID,
												(_response.Res[i].Param.Value || NPPILY.Enum.NrcapStreamType.REALTIME)
											)
										);
									}
								}
								_response = _resArr;
								break;
							case "addgpsres":
							case "removegpsres":
								break;
								
							case "querylast":
							case "queryhistory":
							case "datefiles":
								var _resArr = [];
								if (typeof _response.Res != "undefined")
								{
									if (_response.Res.constructor != Array)
									{
										_response.Res = [_response.Res];	
									}
									for (var i = 0; i < _response.Res.length; i++)
									{
										var GPS = _response.Res[i].GPS,
											ObjID = _response.Res[i].ObjID,
											Type = _response.Res[i].Type,
											Idx = _response.Res[i].Idx;
										
										if (typeof GPS != "undefined")
										{
											if (typeof GPS == "object" && GPS.constructor != Array)
											{
												GPS = [GPS];	
											}
											
											for (var j = 0; j < GPS.length; j++)
											{
												_resArr.push
												(
													new NPPILY.Struct.CSUGPSDataFileStruct
													(
														GPS[j].UTC,
														GPS[j].Latitude,
														GPS[j].Longitude,
														GPS[j].Bearing,
														GPS[j].Speed,
														GPS[j].Altitude,
														GPS[j].State,
														GPS[j].MaxSpeed,
														GPS[j].MinSpeed,
														GPS[j].Timestamp,
														ObjID,
														Type,
														Idx
													)
												);
											}
										}
									}
								}
								_response = _resArr;
								break;
							
							case "dates":
								var _dateArr = [];
								if (typeof _response.Res != "undefined" && typeof _response.Res.Date != "undefined")
								{
									if (_response.Res.Date.constructor != Array)
									{
										_response.Res.Date = [_response.Res.Date];	
									}
									_dateArr = _response.Res.Date || [];
								}
								_response = _dateArr;
								break;
						}
					}
					
					operator.response = _response;
				}
				
				return operator;
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}	
		},
		
		end : true	
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: GPS Modeless
    * ........................................................................................................
    **/	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: EventLog Modeless @huzw 2015.05.14
    * ........................................................................................................
    **/	
	EventLog :
	{
		// 查询平台历史事件日志
		QueryHistoryEventLog : function (connectId, options)
		{
			return this.__Sdk_EventLogControl("queryhistory", connectId, options);
		},
		
		__Sdk_EventLogControl : function (action, connectId, options)
		{
			try
			{
				var fn = "NPPILY.EventLog.__Sdk_EventLogControl -> " + action;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
            		return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				var cs = NPPILY.Connections.get(connectId);
               	
               	if (!cs.session || cs.status != NPPILY.Enum.ConnectionStatus.Connected) 
				{
					NPPUtils.Log(fn, "login or session error~");
					if (cs.status == NPPILY.Enum.ConnectionStatus.Connecting)
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
					}
					else
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
					}		
				}
				
				var o = options = options || {};
				
				o.nuType_las = o.nuType || 13; // - Log网元类型
				o.nuid_las = o.nuid || o.NUID || "013000100000000001"; // - Log网元NUID
				
				o.offset = typeof o.offset != "undefined" || !isNaN(o.offset) ? o.offset : 0;
				o.count = typeof o.count != "undefined" || !isNaN(o.count) ? o.count : 200;
				o.domainRoad = o.domainRoad || ""; 
				
				var operator;
				
				switch (action.toLowerCase())
				{
					case "queryhistory":
						if (!o.puid || !NPPILY.puidRex.test(o.puid))
						{
							if (o.resourceSets == null || typeof o.resourceSets != "object")
							{
								NPPUtils.Log(fn, "puid & resourceSets error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
							}
							else
							{
								if (typeof o.resourceSets == "object" && o.resourceSets.constructor != Array)
								{
									o.resourceSets = [o.resourceSets];	
								}
							}
						}
						else
						{
							o.resourceSets = [{objType: o.objType, objID: (o.objID || o.puid), puid: o.puid, resType: o.resType, resIdx: o.resIdx }];
						}
						
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var xmlObj = new XML.ObjTree();
							xmlObj.xmlDecl = "";
							xmlObj.attr_prefix = "-";

							var operationID = 'CTL_LOG_QueryEventLogEx';
							
							var ResArr = [];
							
							for (var i = 0; i < o.resourceSets.length; i++)
							{
								var item = o.resourceSets[i]; 
								
								if (typeof item.puid != "undefined")
								{
									ResArr.push
									(
									 	{
											"-ObjType" : item.objType || '151',
											"-ObjID" : item.objID || item.puid,
											"-Type" : (item.resType || NPPILY.Enum.PuResourceType.SELF),
											"-Idx" : (typeof item.resIdx == "undefined" ? 0 : item.resIdx),
											"-CmdType": 'CTL',
											"-OptID": operationID,
											"-EPID": cs.connParam.epId
										} 
									); 
								}
							}
							
							var paramJSON =
							{
								Param:
								{
									"-Offset": o.offset,
									"-Count": o.count,
									"-BeginTime": o.beginTime || 0,
									"-EndTime": (o.endTime || Math.ceil(new Date().getTime()/1000)),
									"-Level": o.level || '',
									"-OfflineFlag": o.offlineFlag || '',
									"ID": (o.ID && typeof o.ID != "undefined" ? (o.ID.constructor != Array ? [o.ID] : o.ID) : [])
								}
							};
							
							var objSetsJSON =
							{
								ObjSets : 
								{
									Res : (ResArr || [])
								}
							};
							
							var requestXML = '<?xml version="1.0" encoding="utf-8"?>' +
									' <Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'">' + 
									' 	<Cmd Type="CTL" Prio="'+cs.userPriority+'" EPID="'+cs.connParam.epId+'">' +
									' 		<DstRes Type="SELF" Idx="0" OptID="'+operationID+'">' +
									' 			' + (xmlObj.writeXML(paramJSON)||"") +
									' 		</DstRes>' + 
									' 	</Cmd>'	+ 
									'	' + (xmlObj.writeXML(objSetsJSON)||"") +
									' </Msg>';
									

							NPPUtils.Log(fn, "requestXML -> " + requestXML);
							
							var operator = NPPIF.TransNUCommonMessage
							(
							 	cs.nc,
								cs.session,
								o.nuType_las,
								o.nuid_las,
								requestXML
							);
						}
						else
						{
							NPPUtils.Log(fn, "XML.ObjTree error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						break;
				}
				
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					var xmlObj = new XML.ObjTree();
					
					if (typeof operator.response == "string") {
						operator.response = xmlObj.parseXML(operator.response);
					}
					
					var _response = operator.response;
					
					if (_response != null && typeof _response != "undefined")
					{
						switch (action.toLowerCase())
						{
							
							case "queryhistory":
								if (_response.Msg && _response.Msg.Cmd && _response.Msg.Cmd.NUErrorCode == 0)
								{
									if (_response.Msg.Cmd.DstRes && _response.Msg.Cmd.DstRes.Param && _response.Msg.Cmd.DstRes.Param.Res)
									{
										var Res = _response.Msg.Cmd.DstRes.Param.Res;

										if (Res.constructor != Array) Res = [Res];
										
										_resArr = [];
										
										for (var i = 0; i < Res.length; i++)
										{
											var r = Res[i];
											
											var Event = r.Event;
											
											if (typeof Event != "undefined")
											{
												if (typeof Event == "object" && Event.constructor != Array)
												{
													Event = [Event];	
												}
												
												for (var j = 0; j < Event.length; j++)
												{
													var event = Event[j];
													
													var Msg = event.Msg;
													var Src = Msg.Src;
													
													_resArr.push
													({
														objType: r.ObjType,
														objID: r.ObjID,
														type: r.Type,
														idx: r.Idx,
														event_index: event.Index,
														event_name: Msg.Name,
														ID: Msg.ID,
														time: Msg.Time,
														level: Msg.level||0,
														ignoreFlag: Msg.IgnoreFlag||0,
														srcIDType: Src.SrcIDType||"",
														srcID: Src.SrcID||"",
														resType: Src.ResType||"SELF",
														resIdx: Src.ResIdx||0,
														resName: Src.ResName||"",
														description: Msg.description||""
													});
												}
											}
										}
									}
									else
									{
										NPPUtils.Log(fn, "DstRes.Param.Res error");
										return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
									}
								}
								else
								{
									NPPUtils.Log(fn, "NUErrorCode -> " + NUErrorCode);
									return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
								}
								
								_response = _resArr;
								break;
						}
					}
					
					operator.response = _response;
				}
				
				return operator;
				
			}
			catch (e)
			{
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		end : true
	}, 
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: EventLog Modeless @huzw 2015.05.14
    * ........................................................................................................
    **/	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: Call Talk Ctl
    * ........................................................................................................
    **/
	CallTalkControl : 
	{
		// - 内部存储喊话对讲信息
		__Sdk_OAStore : new NPPUtils.Hash(),
		// - 内部喊话对讲公共函数
		__Sdk_CallTalkCtl : function (action, connectId, puid, oaIndex, customParams)
		{
			try
			{
				var fn = "NPPILY.CallTalkControl.__Sdk_CallTalkCtl -> " + action;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
            		return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				var _connStruct = NPPILY.Connections.get(connectId);
               	
               	if (!_connStruct.session || _connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
				{
					NPPUtils.Log(fn, "login or session error~");
					if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
					}
					else
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
					}		
				}
				var _oastore = NPPILY.CallTalkControl.__Sdk_OAStore = NPPILY.CallTalkControl.__Sdk_OAStore || new NPPUtils.Hash();
				
				// - 清空喊话或对讲信息
				if (action == "clear")
				{ 
					if (_oastore.get(connectId))
					{
						var _oakey = puid + "_" + oaIndex;
						
						_oastore.get(connectId).each
						(
							function (item)
							{
								if (item.key == _oakey)
								{
									if ((item.value.call || item.value.talk) && item.value.oaStreamHandle)
									{
										NPPIF.StopStreamPlay(_connStruct.nc, item.value.oaStreamHandle);
										item.value.oaStreamHandle = "";
										item.value.call = false;
										item.value.talk = false;
									}
									return true;
								}
							} 
						);
						
						_oastore.unset(connectId);
					}
						
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				
				// - 获取所有正在喊话对讲的设备状态
				if (action != "allStatus")
				{
					if (!puid || !NPPILY.puidRex.test(puid)) 
					{
						NPPUtils.Log(fn, "puid error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
					}
					if (isNaN(oaIndex) || !NPPILY.intRex.test(oaIndex)) 
					{
						NPPUtils.Log(fn, "oaIndex error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_INDEX_ERROR);
					}	
				}
				
				var customParams = customParams || {};
				
				switch (action)
				{
					case "call":
					case "talk":						
						// - 检查喊话或对讲状态
						var _status_operator = NPPILY.CallTalkControl.__Sdk_CallTalkCtl("status", connectId, puid, oaIndex);
						if (_status_operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							var _nodeOAItem = _status_operator.response;
							if (_nodeOAItem != null && typeof _nodeOAItem != "undefined" && typeof _nodeOAItem.puid != "undefined" && _nodeOAItem.puid == puid && _nodeOAItem.oaIndex == oaIndex)
							{
								var _isPrevent = _nodeOAItem[(action=="call"?"talk":"call")];
								if (_isPrevent)
								{
									// - 喊话或对讲需要互斥操作
									NPPUtils.Log(fn, "call or talk should incompatible~");
									return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CALLTALK_INCOMPATIBLE);	
								}
								else
								{
									// - 已经有喊话或对讲了
									var _isExist = _nodeOAItem[(action=="call"?"call":"talk")];
									if (_isExist)
									{
										NPPUtils.Log(fn, "call or talk has existed~");
										return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CALLTALK_EXISTED);	
									}
								}
							}
						}
						
						var _oaHandle = null;
						if (customParams._HANDLE) {
							_oaHandle = customParams._HANDLE;
						}
						else {
							var operator = NPPILY.NPPSDKCommon.GetHandle
							(
								connectId,
								puid,
								NPPILY.Enum.PuResourceType.AudioOut,
								oaIndex
							);
							if (operator.rv == NrcapError.NRCAP_SUCCESS)
							{
								_oaHandle = operator.response;
							}
							else
							{
								NPPUtils.Log(fn, "get oa handle error~");
								return operator;
							}
						}
						
						// - 检查一下是否支持喊话或对讲资源
						/*var _support_operator = NPPILY.Config.GetSimple
						(
							 connectId, 
							 puid, 
							 NPPILY.Enum.PuResourceType.AudioOut, 
							 oaIndex, 
							 "CFG_OA_Status"
						);
						if (_support_operator.rv == NrcapError.NRCAP_SUCCESS)
						{
							if (_support_operator.response != "Free")
							{
								NPPUtils.Log(fn, "oa res has occupied~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CALLTALK_OCCUPIED);		
							}
						}
						else
						{
							if (_support_operator.rv == NrcapError.NRCAP_ERROR_PU_OFFLINE)
							{
								return _support_operator;
							}	
						}*/
						
						// - 开启喊话或对讲 
						var operator = NPPIF[(action=="call"?"StartCallPlay":"StartTalkPlay")](_connStruct.nc, _oaHandle);
						if (operator.rv != NrcapError.NRCAP_SUCCESS)
						{
							NPPUtils.Log(fn, "start call or talk failed~");
							return operator;	
						}
						
						if (!_oastore.get(connectId))
						{
							_oastore.set(connectId, new NPPUtils.Hash());
						}						
						if (_oastore.get(connectId))
						{
							var _oakey = puid + "_" + oaIndex;
							
							if (!_oastore.get(connectId).get(_oakey))
							{
								_oastore.get(connectId).set
								(
								 	_oakey,
									{
										puid: puid,
										oaIndex: oaIndex,
										oaStreamHandle: "",
										call: false,
										talk: false
									}
								); 
							}
							if (_oastore.get(connectId).get(_oakey))
							{
								// - 记录喊话或对讲流
								_oastore.get(connectId).get(_oakey)[(action=="call"?"call":"talk")] = true;
								_oastore.get(connectId).get(_oakey).oaStreamHandle = operator.response;
							}
						}
						NPPUtils.Log(fn, "start call or talk success~");
						// - 喊话对讲成功返回对应流的句柄
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, operator.response);
						break;
						
					case "status": // - 获取喊话或对讲状态
						var isExist = false;
						if (_oastore.get(connectId))
						{
							var _oakey = puid + "_" + oaIndex;
							
							if (_oastore.get(connectId).get(_oakey))
							{
								isExist = true;	
								return new NPPILY.Struct.ReturnValueStruct
								(
								 	NrcapError.NRCAP_SUCCESS, 
									_oastore.get(connectId).get(_oakey)
								);
							}
						}
						if (isExist == false)
						{
							NPPUtils.Log(fn, "get call or talk status failed~");
							
							return new NPPILY.Struct.ReturnValueStruct
							(
							 	NrcapError.NRCAP_SUCCESS, 
								{
									puid: puid, 
									oaIndex: oaIndex, 
									call: false, 
									talk: false, 
									oaStreamHandle: ""
								}
							);
						}
						break;
					
					case "allStatus": // - 获取所有正在喊话对讲的设备状态
						var allOAs = [];
						if (_oastore.get(connectId))
						{
							_oastore.get(connectId).each(function (item) {
								if (item.value.oaStreamHandle) allOAs.push(item.value);
							});
						}
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, allOAs);
						break;
						
					case "stop": // - 停止喊话或对讲
						if (_oastore.get(connectId))
						{
							var _oakey = puid + "_" + oaIndex;
						
							_oastore.get(connectId).each
							(
								function (item)
								{
									if (item.key == _oakey)
									{
										if ((item.value.call || item.value.talk) && item.value.oaStreamHandle)
										{
											NPPIF.StopStreamPlay(_connStruct.nc, item.value.oaStreamHandle);
											item.value.oaStreamHandle = "";
											item.value.call = false;
											item.value.talk = false;
										}
										return true;
									}
								} 
							);
						}
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
						break;
					default:
						NPPUtils.Log(fn, "unknown error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_UNDEFINE);
						break;
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD); 
			}
		},
		// - 清除对讲信息
		Clear : function (connectId)
		{
			return this.__Sdk_CallTalkCtl("clear", connectId);
		},
		
		// - 开启喊话
		StartCall : function (connectId, puid, oaIndex, customParams)
		{
			return this.__Sdk_CallTalkCtl("call", connectId, puid, oaIndex, customParams);
		},
		// - 开启对讲
		StartTalk : function (connectId, puid, oaIndex, customParams)
		{
			return this.__Sdk_CallTalkCtl("talk", connectId, puid, oaIndex, customParams);
		},
		// - 获取设备的喊话或对讲状态
		GetStatus : function (connectId, puid, oaIndex)
		{
			return this.__Sdk_CallTalkCtl("status", connectId, puid, oaIndex);
		},
		// - 获取所有正在喊话对讲的设备状态
		GetAllRunningStatus : function (connectId)
		{
			return this.__Sdk_CallTalkCtl("allStatus", connectId);	
		},
		// - 停止喊话或对讲
		Stop : function (connectId, puid, oaIndex, customParams)
		{
			return this.__Sdk_CallTalkCtl("stop", connectId, puid, oaIndex, customParams);
		},
		
		end : true
	},	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: Call Talk Ctl
    * ........................................................................................................
    **/
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: Planform Storage Plan Mgr
    * ........................................................................................................
    **/
	PlatformStorageControl :
	{
		// - 内部处理函数
		__Sdk_PlatfromStorageCtl : function (action, connectId, options)
		{
			try
			{
				var fn = "NPPILY.PlatformStorageControl.__Sdk_PlatfromStorageCtl -> " + action;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
            		return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				var _connStruct = NPPILY.Connections.get(connectId);
               	
               	if (!_connStruct.session || _connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
				{
					NPPUtils.Log(fn, "login or session error~");
					if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
					}
					else
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
					}		
				}
				
				var o = options = options || {};
				if (!o.csuPuid || !NPPILY.puidRex.test(o.csuPuid))
				{
					NPPUtils.Log(fn, "csuPuid error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);
				}
				o.csuIndex = typeof o.csuIndex != "undefined" || !isNaN(o.csuIndex) ? o.csuIndex : 0;
				o.domainRoad = o.domainRoad || ""; 
				
				var operator;
				
				switch (action.toLowerCase())
				{
					case "getplan":
					case "removeplan":
						if (!o.planName)
						{
							NPPUtils.Log(fn, "planName error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						operator = NPPILY.Control.CommonGet
						(
							connectId,
							{
								puid : o.csuPuid,
								resType : NPPILY.Enum.PuResourceType.SC,
								resIdx : o.csuIndex,
								domainRoad : o.domainRoad,
								controlID : (action.toLowerCase() == "getplan" ? "CTL_SC_GetPlan" : "CTL_SC_DelPlan"),
								param : '<Param Name="'+o.planName+'" />'
							}
						);
						break;
					case "setplan":
						if (!o.planName)
						{
							NPPUtils.Log(fn, "planName error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						o.guard = o.guard == 0 || o.guard == 1 ? o.guard : 1;
						o.cycle = o.cycle || NPPILY.Enum.PlanCycleValue.Everyday;
						 
						if (true)
						{
							var is_error = false;
							if (o.cycleParam != null && typeof o.cycleParam != "undefined" && !isNaN(o.cycleParam))
							{
								if (o.cycle == NPPILY.Enum.PlanCycleValue.Weekly && (Number(o.cycleParam) <= 0 || Number(o.cycleParam) >= 128))
								{
									is_error = true;
								}
							}
							else
							{
								if (typeof o.cycle != "undefined" && o.cycle != NPPILY.Enum.PlanCycleValue.Everyday)
								{
									is_error = true;
								}
							}
							if (is_error == true)
							{
								NPPUtils.Log(fn, "cycleParam error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);


							}
						}
						
						if (true)
						{
							var is_error = false;
							
							if (o.guardTimeMap && typeof o.guardTimeMap != "undefined")
							{
								var gtmap = o.guardTimeMap.toString().replace(NPPUtils.Regexs.strip, "").replace(/(0x)/gm, "");
								var gtmaplen = gtmap.length;
								
								switch (o.cycle)
								{
									case NPPILY.Enum.PlanCycleValue.Once:
									case NPPILY.Enum.PlanCycleValue.Everyday:
										if (gtmaplen != 36 * 2)
										{
											is_error = true;
										}
										break;
									case NPPILY.Enum.PlanCycleValue.Weekly:
										var cp = o.cycleParam,
											bincp = parseInt(cp).toString(2),
											countoneflag = 0;
										
										if (bincp.length < 0 || bincp.length > 7)
										{
											is_error = true;
											NPPUtils.Log(fn , "plan cycleParam length beyond range error~");
										}
										else
										{
											for (var i = 0; i < bincp.length; i++)
											{
												if (binco.charAt(i) == "1")
												{
													countoneflag++;
												}
											}
			
											if (gtmaplen != countoneflag * 36 * 2)
											{
												is_error = true;
											}
										}
										break;
								}
								
								o.guardTimeMap = gtmap; // - 赋值过滤后的值
							}
							else
							{
								is_error = true;
							}
							
							if (is_error == true)
							{
								NPPUtils.Log(fn, "guardTimeMap length error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
							}
						}
						
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var xmlObj = new XML.ObjTree();
							xmlObj.xmlDecl = "";
							xmlObj.attr_prefix = "-";
							
							var paramJSON = 
							{
								"Param" :
								{
									"-Name" : o.planName,
									"-Guard" : o.guard,
									"-Cycle" : o.cycle,
									"-CycleParam" : o.cycleParam,
									"-GuardTimeMap" : o.guardTimeMap,
									"-SerialNo" : o.serialNo || (_connStruct.connParam.username || ""),
									"-SerialToken" : MD5.Hex_MD5(o.serialToken || (_connStruct.connParam.password || ""))
								}
							};
							
							operator = NPPILY.Control.CommonGet
							(
								connectId,
								{
									puid : o.csuPuid,
									resType : NPPILY.Enum.PuResourceType.SC,
									resIdx : o.csuIndex,
									domainRoad : o.domainRoad,
									controlID : "CTL_SC_SetPlan",
									param : xmlObj.writeXML(paramJSON)
								}
							); 
						}
						else
						{
							NPPUtils.Log(fn, "XML.ObjTree error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						break;
					case "addplanres":
					case "removeres":
						if (!o.planName)
						{
							NPPUtils.Log(fn, "planName error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						
						// - 当没有o.puid参数时，就会检测o.resourceSets是否存在，o.resourceSets存在，就可以一次添加或删除多条资源信息
						if (!o.puid || !NPPILY.puidRex.test(o.puid))
						{
							if (o.resourceSets == null || typeof o.resourceSets != "object")
							{
								NPPUtils.Log(fn, "puid & resourceSets error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 
							}
							else
							{
								if (typeof o.resourceSets == "object" && o.resourceSets.constructor != Array)
								{
									o.resourceSets = [o.resourceSets];	
								}
							}
						}
						else
						{
							// - 当o.puid存在，那么每次最多只添加或删除一条资源信息
							
							if (!o.resType)
							{
								NPPUtils.Log(fn, "resType error~");
								return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
							}
							o.resIdx = typeof o.resIdx != "undefined" || !isNaN(o.resIdx) ? o.resIdx : 0;
							
							o.resourceSets = [new NPPILY.Struct.PlatformStoragePlanResourceStruct(o.planName, o.puid, o.resType, o.resIdx, o.optID, o.value)];
						}
						
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var xmlObj = new XML.ObjTree();
							xmlObj.xmlDecl = "";
							xmlObj.attr_prefix = "-";
							
							var ResArr = [];
							
							var IDArr = ["CTL_PTZ_MoveToPresetPos", "CTL_SCHEDULER_StartStream", "CTL_COMMONRES_StartStream"];
							
							for (var i = 0; i < o.resourceSets.length; i++)
							{
								var item = o.resourceSets[i]; 
								
								if (typeof item.puid != "undefined" && typeof item.optID != "undefined")
								{
									if (NPPUtils.Array.indexOf(IDArr, item.optID) == -1)
									{
										item.optID = item.resType == NPPILY.Enum.PuResourceType.PTZ ? IDArr[0] : IDArr[1];
									}
									else
									{
										item.optID = item.resType == NPPILY.Enum.PuResourceType.PTZ ? IDArr[0] : (item.optID || IDArr[1]);
									}
									
									item.value = item.value || (item.resType == NPPILY.Enum.PuResourceType.PTZ ? 0 : NPPILY.Enum.NrcapStreamType.REALTIME);
									
									ResArr.push
									(
									 	{
											"-ObjType" : 151,
											"-ObjID" : item.puid,
											"-Type" : item.resType,
											"-Idx" : item.resIdx,
											"-OptID" : item.optID,
											"-Prio" : _connStruct.userPriority, // - 用户优先级
											"-EPID" : _connStruct.connParam.epId, // - 登录用户所属企业ID
											Param :
											{
												"-Value" : item.value
											}
										} 
									); 
								}
							}
							
							var objSetsJSON =
							{
								ObjSets : 
								{
									Res : (ResArr || [])
								}
							};
							
							operator = NPPILY.Control.CommonGet
							(
								connectId,
								{
									puid : o.csuPuid,
									resType : NPPILY.Enum.PuResourceType.SC,
									resIdx : o.csuIndex,
									domainRoad : o.domainRoad,
									controlID : (action.toLowerCase() == "addplanres" ? "CTL_SC_AddResToPlan" : "CTL_SC_RemoveResFromPlan"),
									param : '<Param Name="'+o.planName+'" />',
									xmlObjSets : xmlObj.writeXML(objSetsJSON)
								}
							); 
						}
						else
						{
							NPPUtils.Log(fn, "XML.ObjTree error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						break;
					case "getplanres":
						if (!o.planName)
						{
							NPPUtils.Log(fn, "planName error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						o.offset = typeof o.offset != "undefined" && !isNaN(o.offset) ? o.offset : 0;
						o.count = typeof o.count != "undefined" && !isNaN(o.count) ? o.count : 200;
						
						operator = NPPILY.Control.CommonGet
						(
							connectId,
							{
								puid : o.csuPuid,
								resType : NPPILY.Enum.PuResourceType.SC,
								resIdx : o.csuIndex,
								domainRoad : o.domainRoad,
								controlID : "CTL_SC_GetPlanRes",
								param : '<Param Name="'+o.planName+'" Offset="'+o.offset+'" Cnt="'+o.count+'" />'
							}
						);
						break;
					case "getallplannames":
						operator = NPPILY.Control.CommonGet
						(
							connectId,
							{
								puid : o.csuPuid,
								resType : NPPILY.Enum.PuResourceType.SC,
								resIdx : o.csuIndex,
								domainRoad : o.domainRoad,
								controlID : "CTL_SC_GetAllPlanNames"
							}
						);
						break;
				}
				
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					var _response = operator.response || {};
					
					if (_response != null && typeof _response != "undefined")
					{
						switch (action.toLowerCase())
						{
							case "getplan":
								if (typeof _response.Cycle != "undefined")
								{
									_response = new NPPILY.Struct.PlatformStoragePlanStruct
									(
										o.planName,
										_response.Guard,
										_response.Cycle,
										_response.CycleParam,
										_response.GuardTimeMap
									);
								}
								break;
							case "setplan":
								break;
							case "removeplan":
								break;
							case "addplanres":
								break;
							case "removeres":
								break;
							case "getplanres":
								if (typeof _response.Res != "undefined")
								{
									var planResArr = [];
									
									var Res = _response.Res;
									if (Res.constructor != Array)
									{
										Res = [Res];	
									}
									for (var i = 0; i < Res.length; i++)
									{
										planResArr.push
										(
											new NPPILY.Struct.PlatformStoragePlanResourceStruct
											(
												o.planName,
												Res[i].ObjID,
												Res[i].Type,
												Res[i].Idx,
												Res[i].OptID,
												(typeof Res[i].Param != "undefined" && typeof Res[i].Param.Value != "undefined" ? (Res[i].Param.Value || "") : "")
											)
										);	
									}
									
									_response = planResArr;
								}
								break;
							case "getallplannames":
								if (typeof _response.Plan != "undefined")
								{
									var planNames = []; 
									
									var Plan = _response.Plan;
									if (Plan.constructor != Array)
									{
										Plan = [Plan];	
									}
									for (var i = 0; i < Plan.length; i++)
									{
										planNames.push(Plan[i].Name);	
									}
									
									_response = planNames;
								}
								break;
						}
					}
					
					operator.response = _response;
				}
				
				return operator;
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		/*
		---
		fn: GetPlan
		desc: 获取存储计划
		author: 
			- huzw
		returns:
			- succ <response:Object(NPPILY.Struct.PlatformStoragePlanStruct)>
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，一般可缺省为0
				planName(string) * 平台存储计划名称
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		GetPlan : function (connectId, options)
		{
			return this.__Sdk_PlatfromStorageCtl("getplan", connectId, options);
		},
		/*
		---
		fn: SetPlan
		desc: 设置存储计划
		author: 
			- huzw
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，一般可缺省为0
				planName(string) * 平台存储计划名称
				guard(uint) 是否布防，缺省为1布防，0为撤防
				cycle(NPPILY.Enum.PlanCycleValue) 存储计划类型，缺省为NPPILY.Enum.PlanCycleValue.Everyday
				cycleParam(uint) 存储计划取值
				guardTimeMap(string) * 存储计划布防时间表
				serialNo(string) 登录平台获取流的帐号，缺省为建立连接使用的用户名
				serialToken(string) 登录平台获取流的口令，缺省为建立连接使用的密码
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		SetPlan : function (connectId, options)
		{
			return this.__Sdk_PlatfromStorageCtl("setplan", connectId, options);
		},
		/*
		---
		fn: RemovePlan
		desc: 删除存储计划
		author: 
			- huzw
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，一般可缺省为0
				planName(string) * 平台存储计划名称
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		RemovePlan : function (connectId, options)
		{
			return this.__Sdk_PlatfromStorageCtl("removeplan", connectId, options);
		},
		/*
		---
		fn: AddResourceToPlan
		desc: 向存储计划添加资源
		author: 
			- huzw
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，一般可缺省为0
				planName(string) * 平台存储计划名称，要添加的资源都属于此计划
				resourceSets(Array|Object<NPPILY.Struct.PlatformStoragePlanResourceStruct>) [1] 存储计划资源集合
				puid(string) [2] 设备PUId
				resType(NPPILY.Enum.PuResourcType) [2] 资源类型
				resIdx(uint) [2] 资源索引，缺省为0
				optID(string) [2] 命令ID
				value(string|uint) [2] 预置位编号或流类型 
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		remark:
			- [1] 存在，那么可以进行批量添加资源，但是如果[2]中options.puid参数存在，批量添加不会生效
			- [2] 的参数存在，那么一次只能添加一条资源
			- options.optID取值范围是"CTL_PTZ_MoveToPresetPos", "CTL_SCHEDULER_StartStream", "CTL_COMMONRES_StartStream"

			- options.resType为NPPILY.Enum.PuResourcType.PTZ，那么options.optID取值CTL_PTZ_MoveToPresetPos，options.value为预置位编号，默认为0
			- options.resType为NPPILY.Enum.PuResourcType.VideoIn，options.value为流类型，默认REALTIME
		...
		*/
		AddResourceToPlan : function (connectId, options)
		{
			return this.__Sdk_PlatfromStorageCtl("addplanres", connectId, options);
		},
		/*
		---
		fn: GetPlanResource
		desc: 获取存储计划资源
		author: 
			- huzw
		returns:
			- succ <response:Array(NPPILY.Struct.PlatformStoragePlanResourceStruct)>
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，一般可缺省为0
				planName(string) * 平台存储计划名称
				offset(uint) 分页查询开始量，缺省为0
				count(uint) 分页查询条数，缺省为200
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		GetPlanResource : function (connectId, options)
		{
			return this.__Sdk_PlatfromStorageCtl("getplanres", connectId, options);
		},
		/*
		---
		fn: RemoveResourceFromPlan
		desc: 从存储计划删除资源
		author: 
			- huzw
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，一般可缺省为0
				planName(string) * 平台存储计划名称，要删除的资源都属于此计划
				resourceSets(Array|Object<NPPILY.Struct.PlatformStoragePlanResourceStruct>) [1] 存储计划资源集合
				puid(string) [2] 设备PUId
				resType(NPPILY.Enum.PuResourcType) [2] 资源类型
				resIdx(uint) [2] 资源索引，缺省为0
				optID(string) [2] 命令ID
				value(string|uint) [2] 预置位编号或流类型 
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		remark:
			- [1] 存在，那么可以进行批量删除资源，但是如果[2]中options.puid参数存在，批量删除不会生效
			- [2] 的参数存在，那么一次只能删除一条资源
			- options.optID取值范围是"CTL_PTZ_MoveToPresetPos", "CTL_SCHEDULER_StartStream", "CTL_COMMONRES_StartStream"
			- options.resType为NPPILY.Enum.PuResourcType.PTZ，那么options.optID取值CTL_PTZ_MoveToPresetPos，options.value为预置位编号，默认为0
			- options.resType为NPPILY.Enum.PuResourcType.VideoIn，options.value为流类型，默认REALTIME
		...
		*/
		RemoveResourceFromPlan : function (connectId, options)
		{
			return this.__Sdk_PlatfromStorageCtl("removeres", connectId, options);
		},
		/*
		---
		fn: GetAllPlanNames
		desc: 获取所有存储计划名
		author: 
			- huzw
		returns:
			- succ <response:[planName, ..., planName]>
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，一般可缺省为0
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		GetAllPlanNames : function (connectId, options)
		{
			return this.__Sdk_PlatfromStorageCtl("getallplannames", connectId, options);
		},
		
		end : true
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: Planform Storage Plan Mgr
    * ........................................................................................................
    **/
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: Planform LinkAction Mgr 2013.01.23
    * ........................................................................................................
    **/
	PlatformLinkActionControl :
	{
		/*
		---
		fn: GetAllPlanNames
		desc: 获取所有联动计划名
		author: 
			- huzw
		returns:
			- succ <response:[planName, ..., planName]>
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				nuType(string|uint) 联动调度网元类型，缺省为19，上层调用时建议省略（下同）
				nuid(string) 联动调度网元NUID，缺省为019000100000000001，上层调用时建议省略（下同）
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		GetAllPlanNames : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("GetAllPlanNames", connectId, options);
		},
		/*
		---
		fn: GetPlan
		desc: 获取联动计划
		author: 
			- huzw
		returns:
			- succ <response: {Guard: ?, Cycle: ?, CycleParam: ?, GuardTmMap: ?, CombineTm: ?, TriggerStatus: ?}>
			- 	Guard 
					“1”表示该计划布防，“0”表示撤防
				Cycle 
					NPPILY.Enum.PlanCycleValue对象的值Weekly, Everyday, Once
				CycleParam 
					字符串表示的是4字节无符号整数，
					当Cycle为Everyday时，此值无意义。
					当Cycle为Weekly时，这个值的0-6比特对应周一至周日，1表示有布防计划，0表示没有布防计划
					当Cycle为Once时，是UTC时间，单位秒
				GuardTmMap
					布防生效时间图。在布防情况下，如果不是生效时间图覆盖的时间区间，也不产生联动，1个比特代表5分钟，用36字节代表1天。
					内容是字符串。长度必然是n*36*2。
					Cycle是Weekly时，凡是CycleParam中是1的比特，对应着这里连续的36*2个字节。
					Cycle是Everyday或Once时，长度是36*2个字节
				CombineTm
					触发联动的事件同时发生的判决门限。单位ms
				TriggerStatus
					内存只读属性，1”表示该联动处于触发状态，“0”表示非触发状态。
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				planName(string) * 联动计划名
				nuType(string|uint) 联动调度网元类型，缺省为19，上层调用时建议省略
				nuid(string) 联动调度网元NUID，缺省为019000100000000001，上层调用时建议省略
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		GetPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("GetPlan", connectId, options);
		},
		/*
		---
		fn: SetPlan
		desc: 设置联动计划
		author: 
			- huzw
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				planName(string) * 联动计划名
				Guard(uint) 
					“1”表示该计划布防，“0”表示撤防
				Cycle(string) * 
					NPPILY.Enum.PlanCycleValue对象的值Weekly, Everyday, Once
				CycleParam(string) *
					字符串表示的是4字节无符号整数，
					当Cycle为Everyday时，此值无意义。
					当Cycle为Weekly时，这个值的0-6比特对应周一至周日，1表示有布防计划，0表示没有布防计划
					当Cycle为Once时，是UTC时间，单位秒
				GuardTmMap(hex string) *
					布防生效时间图。在布防情况下，如果不是生效时间图覆盖的时间区间，也不产生联动，1个比特代表5分钟，用36字节代表1天。
					内容是十六进制字符串。长度必然是n*36*2。
					Cycle是Weekly时，凡是CycleParam中是1的比特，对应着这里连续的36*2个字节。
					Cycle是Everyday或Once时，长度是36*2个字节
				CombineTm(uint) *
					触发联动的事件同时发生的判决门限。单位ms
				TriggerStatus(uint) *
					内存只读属性，1”表示该联动处于触发状态，“0”表示非触发
				nuType(string|uint) 联动调度网元类型，缺省为19，上层调用时建议省略
				nuid(string) 联动调度网元NUID，缺省为019000100000000001，上层调用时建议省略
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		SetPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("SetPlan", connectId, options);
		},
		/*
		---
		fn: RemovePlan
		desc: 移除联动计划
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				planName(string) * 联动计划名
				nuType(string|uint) 联动调度网元类型，缺省为19，上层调用时建议省略
				nuid(string) 联动调度网元NUID，缺省为019000100000000001，上层调用时建议省略
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		RemovePlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("RemovePlan", connectId, options);
		},
		
		GetPlanEvent : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("GetPlanEvent", connectId, options);
		},
		AddEventToPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("AddEventToPlan", connectId, options);
		},
		RemoveEventFromPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("RemoveEventFromPlan", connectId, options);
		},
		
		GetPlanAction : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("GetPlanAction", connectId, options);
		},
		AddActionToPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("AddActionToPlan", connectId, options);
		},
		RemoveActionFromPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("RemoveActionFromPlan", connectId, options);
		},
		
		/*
		---
		fn: ManualTriggerPlan
		desc: 手动触发联动
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				planName(string) * 联动计划名
				nuType(string|uint) 联动调度网元类型，缺省为19，上层调用时建议省略
				nuid(string) 联动调度网元NUID，缺省为019000100000000001，上层调用时建议省略
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		ManualTriggerPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("ManualTriggerPlan", connectId, options);
		},
		/*
		---
		fn: ManualStopPlan
		desc: 手动停止触发联动
		params:
			- connectId(string) 连接ID
			- options(object) 可选参数
			{
				planName(string) * 联动计划名
				nuType(string|uint) 联动调度网元类型，缺省为19，上层调用时建议省略
				nuid(string) 联动调度网元NUID，缺省为019000100000000001，上层调用时建议省略
				domainRoad(string) 所属子域名，缺省为空（表示根平台）
			}
		...
		*/
		ManualStopPlan : function (connectId, options)
		{
			return this.__Sdk_PlatformLinkActionCtl("ManualStopPlan", connectId, options);
		},
		
		__Sdk_PlatformLinkActionCtl : function (action, connectId, options)
		{
			try
			{
				var fn = "NPPILY.PlatformLinkActionControl.__Sdk_PlatformLinkActionCtl -> " + action;
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
            		return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
				}
				var _connStruct = NPPILY.Connections.get(connectId);
               	
               	if (!_connStruct.session || _connStruct.status != NPPILY.Enum.ConnectionStatus.Connected) 
				{
					NPPUtils.Log(fn, "login or session error~");
					if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
					}
					else
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
					}		
				}
				
				var o = options = options || {};
				o.nuType_las = o.nuType || 19; // - 联动调度网元类型
				o.nuid_las = o.nuid || o.NUID || "019000100000000001"; // - 联动调度网元NUID
				o.domainRoad = o.domainRoad || ""; 
				o.planName = o.planName || "";
				
				var requestXML;
				
				switch (action)
				{
					case "GetAllPlanNames" :
						requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="CTL_LA_GetAllPlanNames"><Param /></DstRes></Cmd></Msg>';
						break;
					
					case "GetPlan" :
						requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="CTL_LA_GetPlan"><Param Name="'+o.planName+'" /></DstRes></Cmd></Msg>';
						break;
					case "SetPlan" :
						o.Guard = typeof o.Guard != "undefined" ? (o.Guard || 0) : 1;
						o.Cycle = o.Cycle || NPPILY.Enum.PlanCycleValue.Everyday;
						
						var is_error = false;
						if (o.CycleParam != null && typeof o.CycleParam != "undefined" && !isNaN(o.CycleParam))
						{
							if (o.Cycle == NPPILY.Enum.PlanCycleValue.Weekly && (Number(o.CycleParam) <= 0 || Number(o.CycleParam) >= 128))
							{
								is_error = true;
							}
						}
						else
						{
							if (typeof o.Cycle != "undefined" && o.Cycle != NPPILY.Enum.PlanCycleValue.Everyday)
							{
								is_error = true;
							}
						}
						if (is_error == true)
						{
							NPPUtils.Log(fn, "CycleParam error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						
						var is_error = false;
						if (o.GuardTmMap && typeof o.GuardTmMap != "undefined")
						{
							var gtmap = o.GuardTmMap.toString().replace(NPPUtils.Regexs.strip, "").replace(/(0x)/gm, "");
							var gtmaplen = gtmap.length;
							
							switch (o.Cycle)
							{
								case NPPILY.Enum.PlanCycleValue.Once:
								case NPPILY.Enum.PlanCycleValue.Everyday:
									if (gtmaplen != 36 * 2)
									{
										is_error = true;
									}
									break;
								case NPPILY.Enum.PlanCycleValue.Weekly:
									var cp = o.CycleParam,
										bincp = parseInt(cp).toString(2),
										countoneflag = 0;
									
									if (bincp.length < 0 || bincp.length > 7)
									{
										is_error = true;
										NPPUtils.Log(fn , "plan cycleParam length beyond range error~");
									}
									else
									{
										for (var i = 0; i < bincp.length; i++)
										{
											if (binco.charAt(i) == "1")
											{
												countoneflag++;
											}
										}
										if (gtmaplen != countoneflag * 36 * 2)
										{
											is_error = true;
										}
									}
									break;
							}
							
							o.GuardTmMap = gtmap; // - 赋值过滤后的值
						}
						else
						{
							is_error = true;
						}
						if (is_error == true)
						{
							NPPUtils.Log(fn, "GuardTmMap length error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						
						o.CombineTm = typeof o.CombineTm != "undefined" ? o.CombineTm : 1000;
						
						requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="CTL_LA_SetPlan"><Param Name="'+o.planName+'" Guard="'+o.Guard+'" Cycle="'+o.Cycle+'" CycleParam="'+o.CycleParam+'" GuardTmMap="'+o.GuardTmMap+'" CombineTm="'+o.CombineTm+'" /></DstRes></Cmd></Msg>';
						break;
					case "RemovePlan" :
						requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="CTL_LA_DelPlan"><Param Name="'+o.planName+'" /></DstRes></Cmd></Msg>';
						break;
						
					case "GetPlanEvent" : // - 获取联动计划事件源
					case "GetPlanAction" : // - 获取联动计划动作
						o.offset = o.offset || 0;
						o.count = o.count || 200;
						
						var operationID = "CTL_LA_" + (action == "GetPlanEvent" ? "GetPlanEvent" : "GetPlanAction");
						
						requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="'+operatorID+'"><Param Name="'+o.planName+'" Offset="'+o.offset+'" Count="'+o.count+'" /></DstRes></Cmd></Msg>';
						break;
					case "AddEventToPlan" :
					case "RemoveEventFromPlan" :
						o.srcSets = o.srcSets || [];
						if (o.srcSets && o.srcSets.constructor != Array)
						{
							o.srcSets = [o.srcSets];	
						}
						
						var Src = [];
						for (var i = 0; i < o.srcSets.length; i++)
						{
							var item = o.srcSets[i];
							Src.push
							(
								{
									"-ObjType" : item.ObjType || "",
									"-ObjID" : item.ObjID || "",
									"-ResType" : item.ResType || NPPILY.Enum.PuResourceType.SELF,
									"-ResIdx" : item.ResIdx || "",
									"-EventID" : item.EventID || "",
									Param : 
									{
										"-ResName" : item.ResName || ""
									}
								} 
							);	
						}
						var jsonSrcSets = 
						{
							SrcSets : 
							{
								Src : Src	
							}
						};
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var xmlObj = new XML.ObjTree();
							xmlObj.xmlDecl = "";
							xmlObj.attr_prefix = "-";
							
							var operationID = "CTL_LA_" + (action == "AddEventToPlan" ? "AddEventToPlan" : "RemoveEventFromPlan");
						
							requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="'+operationID+'"><Param Name="'+o.planName+'" /></DstRes></Cmd>'+(xmlObj.writeXML(jsonSrcSets)||"")+'</Msg>';
						} 
						break;
					case "AddActionToPlan" :
					case "RemoveActionFromPlan" :
						o.resSets = o.resSets || [];
						if (o.resSets && o.resSets.constructor != Array)
						{
							o.resSets = [o.resSets];	
						}
						
						var xmlRes = "";
						
						for (var i = 0; i < o.resSets.length; i++)
						{
							var item = o.resSets[i];
							
							xmlRes += '<Res ObjType="'+(item.ObjType||"")+'" ObjID="'+(item.ObjID||"")+'" Type="'+(item.Type||"")+'" Idx="'+(item.Idx||"0")+'" CmdType="'+(item.CmdType||"")+'" OptID="'+(item.OptID||"")+'" Prio="'+(item.Prio||"0")+'" ><Param DelayTm="'+(item.DelayTm||"")+'" CycleTm="'+(item.CycleTm||"")+'" CycleNum="'+(item.CycleNum||"")+'" ResName="'+(item.ResName||"")+'">'+item.xmlExtraActionParam+'</Param></Res>';
						}
						var xmlObjSets = '<ObjSets>'+xmlRes+'</ObjSets>';
						
						var operationID = "CTL_LA_" + (action == "AddActionToPlan" ? "AddActionToPlan" : "RemoveActionFromPlan");
						
						requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="'+operationID+'"><Param Name="'+o.planName+'" /></DstRes></Cmd>'+(xmlObjSets||"")+'</Msg>';
						break;
					
					case "ManualTriggerPlan" :
					case "ManualStopPlan" :
						var operationID = "CTL_LA_" + (action == "ManualTriggerPlan" ? "ManualTriggerPlan" : "ManualStopPlan");
						
						requestXML = '<?xml version="1.0" encoding="utf-8"?><Msg Name="CUCommonMsgReq" DomainRoad="'+o.domainRoad+'"><Cmd Type="CTL" Prio="'+_connStruct.userPriority+'" EPID="'+_connStruct.connParam.epId+'"><DstRes Type="SELF" Idx="0" OptID="'+operationID+'"><Param Name="'+o.planName+'" /></DstRes></Cmd></Msg>';
						break;
				}
				var operator = NPPIF.TransNUCommonMessage
				(
				 	_connStruct.nc,
					_connStruct.session,
					o.nuType_las,
					o.nuid_las,
					requestXML
				);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
					{
						var xmlObj = new XML.ObjTree();
						var jsonResponse = xmlObj.parseXML(operator.response);
						
						if (jsonResponse && typeof jsonResponse.Msg != "undefined" && jsonResponse.Msg.Cmd && typeof jsonResponse.Msg.Cmd.NUErrorCode != "undefined")
						{
							if (jsonResponse.Msg.Cmd.NUErrorCode != 0)
							{
								operator.rv = jsonResponse.Msg.Cmd.NUErrorCode;
							}
							else
							{
								if (jsonResponse.Msg.Cmd.DstRes)
								{
									if (jsonResponse.Msg.Cmd.DstRes.ErrorCode != 0)
									{
										operator.rv = jsonResponse.Msg.Cmd.DstRes.ErrorCode;
									}
									else
									{
										var DstRes = jsonResponse.Msg.Cmd.DstRes;
										
										// - 根据不同的请求返回有效的值
										switch (action)
										{
											case "GetAllPlanNames":
												if (typeof DstRes.Param == "object" && typeof DstRes.Param.PlanName != "undefined")
												{
													if (DstRes.Param.PlanName.constructor != Array) DstRes.Param.PlanName = [DstRes.Param.PlanName];
													operator.response = DstRes.Param.PlanName;
												}
												else
												{
													operator.response = [];
												}
												break;
												
											case "GetPlan" :
												operator.response = DstRes.Param || {};
												break;
											
											case "GetPlanEvent" :
											case "GetPlanAction" :
												if (typeof DstRes.Param == "object" && typeof DstRes.Param.Res != "undefined")
												{
													if (DstRes.Param.Res.constructor != Array) DstRes.Param.Res = [DstRes.Param.Res];
													operator.response = DstRes.Param.Res || [];
												}
												else
												{
													operator.response = [];
												}
												break;
											case "SetPlan" :
											case "RemovePlan" :
											case "AddEventToPlan" :
											case "RemoveEventFromPlan" :
											case "AddActionToPlan" :
											case "RemoveActionFromPlan" :
											case "ManualTriggerPlan" :
											case "ManualStopPlan" :
												operator.response = jsonResponse;
												break;
										}
									}
								}
							}
						}		
					}
				}
				return operator;
			}
			catch (e)
			{
				NPPUtils.Log(fn, "excp error = " + e.name + "::" + e.message);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD, e);
			}
		},
		
		end : true	
	}, 
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: Planform LinkAction Mgr 2013.01.23
    * ........................................................................................................
    **/
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: Download Control - 2013.11.25 
    * ........................................................................................................
    **/ 
	Download :
	{
		// - 存储下载信息
		__Sdk_Downloads : new NPPUtils.Hash(),
		
		Clear : function (connectId)
		{
			try
			{
				var fn = "NPPILY.Download.Clear";
				
				if (!connectId || !NPPILY.Connections.get(connectId))
				{
					NPPUtils.Log(fn, "connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				var _connStruct = NPPILY.Connections.get(connectId);
				
				// - 存储下载信息
				var _dlhash = NPPILY.Download.__Sdk_Downloads = NPPILY.Download.__Sdk_Downloads || new NPPUtils.Hash();
				
				_dlhash.each
				(
					function (item)
					{
						if (item.key == connectId)
						{
							var _Sdk_ResetHandle = function (_dlFileStore)
							{
								_dlFileStore.each
								(
									function (_item)
									{
										if (_item.value.dlStreamHandle != null)
										{
											NPPIF.StopStreamPlay(_connStruct.nc, _item.value.dlStreamHandle);
											_item.value.dlStreamHandle = null;
										}
									}
								);
							};
							
							_Sdk_ResetHandle(item.value.dlCSUFileStore);
							_Sdk_ResetHandle(item.value.dlCEFSVodFileStore);
							_Sdk_ResetHandle(item.value.dlCEFSImageFileStore);
							
							_dlhash.unset(item.key);
							
							return true;
						} 
					} 
				); 
				
				return  new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		/*
		fn: StartCSUFileDownload
		desc: 下载平台存储录像或图片
		author:
			- huzw
		returns:
			- succ <response:dlStreamHandle(string) 下载通道（流）句柄
		params:
			- connectId(string) * 连接ID
			- csuPuid(string) * 中心存储器PUID
			- fileAllPath(string) * 中心存储文件全路径
			- localSaveAsFile(string) * 下载保存全路径，如C:/vod.avi，上层调用时确保正确的存储路径
			- csuIndex(uint) 中心存储单元资源索引，缺省为0
		reamrk:
			- 成功时，返回下载通道（流）句柄
		*/
		StartCSUFileDownload : function (connectId, csuPuid, fileAllPath, localSaveAsFile, csuIndex)
		{
			return NPPILY.Download.__Sdk_DLControl
			(
			 	"dlcsu",
				{
					connectId: connectId || null,
					csuPuid: csuPuid || null,
					csuIndex: csuIndex || 0,
					fileAllPath: fileAllPath || null,
					localSaveAsFile: localSaveAsFile || null
				}
			); 
		},
		/*
		fn: StopCSUFileDownload
		desc: 停止下载平台存储录像或图片
		author:
			- huzw
		params:
			- connectId(string) * 连接ID
			- dlStreamHandle(string) * 下载通道（流）句柄
		*/
		StopCSUFileDownload : function (connectId, dlStreamHandle)
		{
			return NPPILY.Download.__Sdk_DLControl
			(
			 	"stopdl",
				{
					connectId: connectId || null,
					dlStreamHandle: dlStreamHandle || null
				}
			);
		},
		/*
		fn: StartCEFSVodFileDownload
		desc: 下载前端录像
		author:
			- huzw
		returns:
			- succ <response:dlStreamHandle(string) 下载通道（流）句柄>
		params:
			- connectId(string) * 连接ID
			- puid(string) * 录像所属设备PUID
			- sgIndex(uint) * 前端存储器资源索引，默认为0
			- beginTime(uint) * 录像开始UTC时间，如1385049600
			- endTime(uint) * 录像结束UTC时间，如1385049900
			- ivIndex(uint) * 录像所属视频资源索引，默认为0
			- localSaveAsFile(string) * 下载保存全路径，如C:/vod.avi，上层调用时确保正确的存储路径
		*/
		StartCEFSVodFileDownload : function (connectId, puid, sgIndex, beginTime, endTime, ivIndex, localSaveAsFile)
		{
			return NPPILY.Download.__Sdk_DLControl
			(
			 	"dlcefsvod",
				{
					connectId: connectId || null,
					puid: puid || null,
					sgIndex: sgIndex || 0,
					beginTime: beginTime || null,
					endTime: endTime || null,
					ivIndex: ivIndex || 0,
					localSaveAsFile: localSaveAsFile || null
				}
			); 
		},
		/*
		fn: StartCEFSImageFileDownload
		desc: 下载前端图片
		author:
			- huzw
		returns:
			- succ <response:dlStreamHandle(string) 下载通道（流）句柄>
		params:
			- connectId(string) * 连接ID
			- puid(string) * 抓拍所属设备PUID
			- sgIndex(uint) * 前端存储器资源索引，默认为0
			- snapshotTime(uint) * 抓拍UTC时间，如1385049600
			- noInSecond(uint) * 抓拍图片秒内编号，默认为0，同一秒内可以有多个抓图
			- ivIndex(uint) * 抓拍所属视频资源索引，默认为0
			- localSaveAsFile(string) * 下载保存全路径，如C:/vod.bmp，上层调用时确保正确的存储路径
		*/
		StartCEFSImageFileDownload : function (connectId, puid, sgIndex, snapshotTime, noInSecond, ivIndex, localSaveAsFile)
		{
			return NPPILY.Download.__Sdk_DLControl
			(
			 	"dlcefsimage",
				{
					connectId: connectId || null,
					puid: puid || null,
					sgIndex: sgIndex || 0,
					snapshotTime: snapshotTime || null,
					noInSecond: noInSecond || 0,
					ivIndex: ivIndex || 0,
					localSaveAsFile: localSaveAsFile || null
				}
			); 
		},
		/*
		fn: StopCEFSFileDownload
		desc: 停止下载前端存储录像或图片
		author:
			- huzw
		params:
			- connectId(string) * 连接ID
			- dlStreamHandle(string) * 下载通道（流）句柄
		*/
		StopCEFSFileDownload : function (connectId, dlStreamHandle)
		{
			return NPPILY.Download.__Sdk_DLControl
			(
			 	"stopdl",
				{
					connectId: connectId || null,
					dlStreamHandle: dlStreamHandle || null
				}
			);
		},
		
		// - 内部共用下载函数
		__Sdk_DLControl : function (action, options)
		{
			try
			{
				var fn = "NPPILY.Download.__Sdk_DLControl -> " + action;
				
				var options = options || {};
				
				if (!options.connectId || !NPPILY.Connections.get(options.connectId))
				{
					NPPUtils.Log(fn, "options.connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				// - 存储下载信息
				var _dlhash = NPPILY.Download.__Sdk_Downloads = NPPILY.Download.__Sdk_Downloads || new NPPUtils.Hash();
				
				if (!_dlhash.get(options.connectId))
				{
					_dlhash.set
					(
					 	options.connectId, 
						{
							connectId: options.connectId,
							dlCSUFileStore: new NPPUtils.Hash(),
							dlCEFSVodFileStore: new NPPUtils.Hash(),
							dlCEFSImageFileStore: new NPPUtils.Hash()
						}
					);	
				}
							
				var operator;
				switch (action)
				{
					case "dlcsu": // - 下载平台录像或图片
						if (!options.csuPuid || !NPPILY.puidRex.test(options.csuPuid))
						{
							NPPUtils.Log(fn, "options.csuPuid error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);	
						}
						options.csuIndex = typeof options.csuIndex != "undefined" || !isNaN(options.csuIndex) ? options.csuIndex : 0; 
						
						if (!options.fileAllPath)
						{
							NPPUtils.Log(fn, "options.fileAllPath error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (!options.localSaveAsFile)
						{
							NPPUtils.Log(fn, "options.localSaveAsFile error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						
						var _dlkey = options.csuPuid + 
										"_" + options.csuIndex + 
										"_" + options.fileAllPath + 
										"_" + options.localSaveAsFile;
										
						if (_dlhash.get(options.connectId))
						{		
							var _dlCSUFileStore = _dlhash.get(options.connectId).dlCSUFileStore || new NPPUtils.Hash();
							if (_dlCSUFileStore.containsKey(_dlkey))
							{
								// - 判断是否存在同一下载通道
								if (typeof _dlCSUFileStore.get(_dlkey).dlStreamHandle != "undefined" 
										&& _dlCSUFileStore.get(_dlkey).dlStreamHandle != null)
								{
									NPPUtils.Log(fn, "csu dl existed, dlkey->" + _dlkey);
									return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_DOWNLOAD_EXISTED, _dlCSUFileStore.get(_dlkey).dlStreamHandle);	
								}
							}
							
							operator = NPPILY.NPPSDKCommon.GetNCResponse
							(
								options.connectId, 
								NPPILY.Enum.NCObjectMethodList.SC_DownLoadFile, 
								options.csuPuid, 
								NPPILY.Enum.PuResourceType.SC, 
								options.csuIndex,  
								options.fileAllPath, 
								options.localSaveAsFile
							);
							if (operator.rv == NrcapError.NRCAP_SUCCESS)
							{		
								_dlCSUFileStore.set
								(
									_dlkey,
									{
										dlkey: _dlkey,
										csuPuid: options.csuPuid,
										csuIndex: options.csuIndex,
										fileAllPath: options.fileAllPath,
										localSaveAsFile: options.localSaveAsFile,
										dlStreamHandle: operator.response
									}
								);
							}
						}
						break;
					case "dlcefsvod": // - 下载CEFS录像
						if (!options.puid || !NPPILY.puidRex.test(options.puid))
						{
							NPPUtils.Log(fn, "options.puid error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);	
						}
						options.sgIndex = typeof options.sgIndex != "undefined" || !isNaN(options.sgIndex) ? options.sgIndex : 0; 
						options.ivIndex = typeof options.ivIndex != "undefined" || !isNaN(options.ivIndex) ? options.ivIndex : 0; 
						
						if (!options.beginTime)
						{
							NPPUtils.Log(fn, "options.beginTime error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (!options.endTime)
						{
							NPPUtils.Log(fn, "options.endTime error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (!options.localSaveAsFile)
						{
							NPPUtils.Log(fn, "options.localSaveAsFile error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						
						var _dlkey = options.puid + 
										"_" + options.sgIndex + 
										"_" + options.ivIndex + 
										"_" + options.beginTime + 
										"_" + options.endTime + 
										"_" + options.localSaveAsFile;
										
						if (_dlhash.get(options.connectId))
						{
							var _dlCEFSVodFileStore = _dlhash.get(options.connectId).dlCEFSVodFileStore || new NPPUtils.Hash();
							if (_dlCEFSVodFileStore.containsKey(_dlkey))
							{
								// - 判断是否存在同一下载通道
								if (typeof _dlCEFSVodFileStore.get(_dlkey).dlStreamHandle != "undefined" 
										&& _dlCEFSVodFileStore.get(_dlkey).dlStreamHandle != null)
								{
									NPPUtils.Log(fn, "cefs vod dl existed, dlkey->" + _dlkey);
									return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_DOWNLOAD_EXISTED, _dlCEFSVodFileStore.get(_dlkey).dlStreamHandle);	
								}
							}
							
							operator = NPPILY.NPPSDKCommon.GetNCResponse
							(
								options.connectId, 
								NPPILY.Enum.NCObjectMethodList.SG_CEFSDownLoadFile, 
								options.puid, 
								NPPILY.Enum.PuResourceType.Storager, 
								options.sgIndex,
								options.beginTime, 
								options.endTime, 
								options.ivIndex,
								options.localSaveAsFile
							);
							if (operator.rv == NrcapError.NRCAP_SUCCESS)
							{		
								_dlCEFSVodFileStore.set
								(
									_dlkey,
									{
										dlkey: _dlkey,
										puid: options.puid,
										sgIndex: options.sgIndex,
										beginTime: options.beginTime,
										endTime: options.endTime,
										ivIndex: options.ivIndex,
										localSaveAsFile: options.localSaveAsFile,
										dlStreamHandle: operator.response
									}
								);
							}
						}
						break;
					case "dlcefsimage": // - 下载CEFS图片
						if (!options.puid || !NPPILY.puidRex.test(options.puid))
						{
							NPPUtils.Log(fn, "options.puid error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);	
						}
						options.sgIndex = typeof options.sgIndex != "undefined" || !isNaN(options.sgIndex) ? options.sgIndex : 0; 
						options.noInSecond = typeof options.noInSecond != "undefined" || !isNaN(options.noInSecond) ? options.noInSecond : 0; 
						options.ivIndex = typeof options.ivIndex != "undefined" || !isNaN(options.ivIndex) ? options.ivIndex : 0; 
						
						if (!options.snapshotTime)
						{
							NPPUtils.Log(fn, "options.snapshotTime error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (!options.localSaveAsFile)
						{
							NPPUtils.Log(fn, "options.localSaveAsFile error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						
						var _dlkey = options.puid + 
										"_" + options.sgIndex +
										"_" + options.snapshotTime +
										"_" + options.noInSecond + 
										"_" + options.ivIndex + 
										"_" + options.localSaveAsFile;
										
						if (_dlhash.get(options.connectId))
						{		
							var _dlCEFSImageFileStore = _dlhash.get(options.connectId).dlCEFSImageFileStore || new NPPUtils.Hash();
							if (_dlCEFSImageFileStore.containsKey(_dlkey))
							{
								// - 判断是否存在同一下载通道
								if (typeof _dlCEFSImageFileStore.get(_dlkey).dlStreamHandle != "undefined" 
										&& _dlCEFSImageFileStore.get(_dlkey).dlStreamHandle != null)
								{
									NPPUtils.Log(fn, "cefs image dl existed, dlkey->" + _dlkey);
									return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_DOWNLOAD_EXISTED, _dlCEFSImageFileStore.get(_dlkey).dlStreamHandle);	
								}
							}
							
							operator = NPPILY.NPPSDKCommon.GetNCResponse
							(
								options.connectId, 
								NPPILY.Enum.NCObjectMethodList.SG_CEFSDownLoadSnapshot, 
								options.puid, 
								NPPILY.Enum.PuResourceType.Storager, 
								options.sgIndex,
								options.snapshotTime, 
								options.noInSecond, 
								options.ivIndex,
								options.localSaveAsFile
							);
							if (operator.rv == NrcapError.NRCAP_SUCCESS)
							{		
								_dlCEFSImageFileStore.set
								(
									_dlkey,
									{
										dlkey: _dlkey,
										puid: options.puid,
										sgIndex: options.sgIndex,
										snapshotTime: options.snapshotTime,
										noInSecond: options.noInSecond,
										ivIndex: options.ivIndex,
										localSaveAsFile: options.localSaveAsFile,
										dlStreamHandle: operator.response
									}
								);
							}
						}
						break;
						
					case "stopdl": // - 停止下载
						if (typeof options.dlStreamHandle != "undefined" && options.dlStreamHandle != null)
						{
						 	// - 先检测是否存在
							var _connStruct = NPPILY.Connections.get(options.connectId);
							
							_dlhash.each
							(
								function (item)
								{
									if (item.key == options.connectId)
									{
										var found = false;
										var _Sdk_ResetHandle = function (_dlFileStore)
										{
											if (!found)
											{
												_dlFileStore.each
												(
													function (_item)
													{
														if (_item.value.dlStreamHandle == options.dlStreamHandle)
														{
															found = true;
															
															// - 然后再停止下载
															operator = NPPIF.StopStreamPlay(_connStruct.nc, options.dlStreamHandle);
															
															if (operator.rv == NrcapError.NRCAP_SUCCESS)
															{
																_item.value.dlStreamHandle = null;
																
																_dlFileStore.unset(_item.key);
															}
															return true;
														}
													}
												);	
											}
										};
										
										_Sdk_ResetHandle(item.value.dlCSUFileStore);
										_Sdk_ResetHandle(item.value.dlCEFSVodFileStore);
										_Sdk_ResetHandle(item.value.dlCEFSImageFileStore);
										
										if (found == false)
										{
											operator = new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);	
										} 
										return true;	
									}
								}
							);
						}
						else
						{
							NPPUtils.Log(fn, "dlStreamHandle error~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_HANDLE_ERROR);	
						}
						break;
				}
				
				return operator;
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		end : true
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: Download Control - 2013.11.25
    * ........................................................................................................
    **/
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: User Management - 2014.02.14
    * ........................................................................................................
    **/
	UserManagementControl : 
	{
		/*
		---
		desc: 获取当前用户索引
		params:
			- connectId(string) 连接ID
			- nuType_cui(uint|string) CUI网元类型，一般取5，建议省略（下同）
			- nuid_cui(string) CUI网元NUID，一般为005000100000000001，建议省略（下同）
		...
		*/
		QueryUserIndex : function (connectId, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"QueryUserIndex", 
				{
					connectId: connectId,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		/*
		---
		desc: 获取用户信息
		params:
			- connectId(string) 连接ID
			- userIndex(uint|string) 用户索引 
		returns:
			- response: Object
			{
				Identity(string) 用户名
				Active(boolean) 用户是否被激活
				Priority(uint) 用户优先级
				MaxSessionNum(uint) 最大连接数
				ActorType(uint) 所属角色类型（0自定义角色类型，1预定义角色类型）	
				Actor_Index(uint) 所属角色索引
				ParentUser_Index(uint) 父用户索引，管理员用户父用户索引为0
				AccreditedPassword(string) 接入密码（为MD5编码）
				Name(string) 联系人姓名
				Phones(string) 联系人电话
				Description(string) 联系人描述
				Remark(string) 其他备注
				EnableWhiteList(boolean) 允许白名单
			}
		...
		*/
		QueryUserInformation : function (connectId, userIndex, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"QueryUserInformation", 
				{
					connectId: connectId,
					userIndex: userIndex,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		/*
		---
		desc: 获取非管理员用户资源
		params:
			- connectId(string) 连接ID
			- userIndex(uint|string) 用户索引 
			...
		returns:
			- response: Array(Object)
			{ 
				PUID(string) 设备PUID
				Type(NPPILY.Enum.PuResourceType) 资源类型
				Idx(uint) 资源索引
			}
		...
		*/
		QueryUserResource : function (connectId, userIndex, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"QueryUserResource", 
				{
					connectId: connectId,
					userIndex: userIndex,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		// - 获取一个用户的逻辑分组
		QueryUserLogicGroup : function (connectId, userIndex, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"QueryUserLogicGroup", 
				{
					connectId: connectId,
					userIndex: userIndex,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		/*
		---
		desc: 获取一个用户的子用户
		params:
			- connectId(string) 连接ID
			- userIndex(uint|string) 用户索引 
			- recursive(uint) 0表示仅获取直接子用户，非0表示递归获取所有子用户，缺省为0
			...
		returns:
			- response: Array(Object)
			{ 
				Index(uint) 用户索引
				Identity(string) 用户账户名
				ParentUser_Index(uint) 父用户索引
			}
		...
		*/
		QuerySubUsers : function (connectId, userIndex, recursive, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"QuerySubUsers", 
				{
					connectId: connectId,
					userIndex: userIndex,
					recursive: recursive,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		/*
		---
		desc: 添加用户
		params:
			- connectId(string) 连接ID
			- userInformation(Object) 用户信息
			{
				Index(uint) 父用户索引
				Identity(string) 用户名
				Password(string) 密码（使用MD5编码）
				Active(boolean) 用户是否被激活
				Priority(uint) 用户优先级
				MaxSessionNum(uint) 最大连接数
				ActorType(uint) 所属角色类型（0自定义角色类型，1预定义角色类型）	
				Actor_Index(uint) 所属角色索引
				Name(string) 联系人姓名
				Phones(string) 联系人电话
				Description(string) 联系人描述
				Remark(string) 其他备注
				EnableWhiteList(boolean) 允许白名单
			}
		remark:
			- Index指父用户的索引，可以跨级添加子用户。用户ID不区分大小写。Identity（<32B）、Password（<32B）、Active（0，1）、Priority（1-255）、MaxSessionNum（1-255）、ActorType（0，1）、Actor_Index这些属性不能为空，其他属性可以为空，但都必填。所有属性默认都可继承其父用户的值（密码除外），但是Priority不能小于其父用户（权限不能比父用户高）。
		...
		*/
		AddUserInformation : function (connectId, userInformation, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"AddUser", 
				{
					connectId: connectId,
					userInformation: userInformation,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			); 
		},
		/*
		---
		desc: 更新用户
		params:
			- connectId(string) 连接ID
			- userInformation(Object) 用户信息
			{
				Index(uint) 父用户索引
				Identity(string) 用户名
				Password(string) 密码（使用MD5编码）
				Active(boolean) 用户是否被激活
				Priority(uint) 用户优先级
				MaxSessionNum(uint) 最大连接数
				Name(string) 联系人姓名
				Phones(string) 联系人电话
				Description(string) 联系人描述
				Remark(string) 其他备注
				EnableWhiteList(boolean) 允许白名单
			}
		remark:
			- 自己不能修改自己的Active、Priority、MaxSessionNum属性
			- 凡是不需要更新的属性就不必带上了
		...
		*/
		UpdateUserInformation : function (connectId, userInformation, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"UpdateUser", 
				{
					connectId: connectId,
					userInformation: userInformation,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			); 
		},
		// - 删除用户
		DeleteUserInformation : function (connectId, userIndex, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
			 	"DeleteUser", 
				{
					connectId: connectId,
					userIndex: userIndex,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			); 
		},
		/*
		---
		desc: 添加用户资源
		params:
			- connectId(string) 连接ID
			- userIndex(uint|string) 用户索引 
			- resSets(Array|Object) 资源集合（结构如下，下同）
			{ 
				PUID(string) 设备PUID
				Type(NPPILY.Enum.PuResourceType) 资源类型
				Idx(uint) 资源索引
			}
		...
		*/
		AddUserResource : function (connectId, userIndex, resSets, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
				"AddUserResource",
				{
					connectId: connectId,
					userIndex: userIndex,
					resSets: resSets,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		// - 移除用户资源
		RemoveUserResource : function (connectId, userIndex, resSets, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
				"RemoveUserResource",
				{
					connectId: connectId,
					userIndex: userIndex,
					resSets: resSets,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		// - 添加用户逻辑分组
		AddUserLogicGroup : function (connectId, userIndex, logicGroupIndexs, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
				"AddUserLogicGroup",
				{
					connectId: connectId,
					userIndex: userIndex,
					logicGroupIndexs: logicGroupIndexs,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		// - 移除用户逻辑分组
		RemoveUserLogicGroup : function (connectId, userIndex, logicGroupIndexs, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
				"RemoveUserLogicGroup",
				{
					connectId: connectId,
					userIndex: userIndex,
					logicGroupIndexs: logicGroupIndexs,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		/*
		---
		desc: 获取在线用户
		params:
			- connectId(string) 连接ID
		remark:
			- response: Array(Object)
			{
				CUID(string) 服务端分配给客户端的连接ID
				Identity(string) 用户账户名
				ValidationType(string) 验证类型？
				ClientType(string) 客户端类型
				OnlineDateTime(string) 客户端登录的时间
				SourceIP(string) 客户端所在机器IP
				SourcePort(uint) 客户端所在机器端口
			}
		...
		*/
		QueryOnlineUsers : function (connectId, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
				"QueryOnlineUsers",
				{
					connectId: connectId,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		/*
		---
		desc: 踢除在线用户
		params: 
			- connectId(string) 连接ID
			- CUID(string) 服务端分配给客户端的连接ID
		remark:
			- 优先级小于等于自己的才能踢除，用户已下线或被踢除同样返回成功
		...
		*/
		KickOnlineUsers : function (connectId, CUID, nuType_cui, nuid_cui)
		{
			return this.__Sdk_UMCtl
			(
				"KickOnlineUsers",
				{
					connectId: connectId,
					CUID: CUID,
					nuType_cui: nuType_cui,
					nuid_cui: nuid_cui
				}
			);
		},
		
		__Sdk_UMCtl : function (action, options)
		{
			try 
			{
				var fn = "NPPILY.UserManagementControl.__Sdk_UMCtl - > " + action;
				
				var options = options || {};
				
				if (!options.connectId || !NPPILY.Connections.get(options.connectId))
				{
					NPPUtils.Log(fn, "options.connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				var _connStruct = NPPILY.Connections.get(options.connectId);
				
				options.nuType_cui = options.nuType_cui || 5;
				options.nuid_cui = options.nuid_cui || "005000100000000001";
				
				options.userIndex = typeof options.userIndex != "undefined" && !isNaN(options.userIndex) ? options.userIndex : 0;
				
				var xmlRequest;
				switch (action)
				{
					case "QueryUserIndex":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryUserIndex" /></Msg>';		
						break;
					case "QueryUserInformation":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryUserInfo"><User Index="'+options.userIndex+'" /></Cmd></Msg>';	
						break;
					case "QueryUserResource":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryUserResource"><User Index="'+options.userIndex+'" /></Cmd></Msg>';	
						break;
					case "QueryUserLogicGroup":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryUserLogicGroup"><User Index="'+options.userIndex+'" /></Cmd></Msg>';	
						break;
					case "QuerySubUsers":
						options.recursive = typeof options.recursive != "undefined" && !isNaN(options.recursive) ? options.recursive : 0;
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QuerySubUser"><User Index="'+options.userIndex+'" Recursive="'+options.recursive+'" /></Cmd></Msg>';
						break;
					case "AddUser":
						var ui = options.userInformation = options.userInformation || {};
						if (!ui || typeof ui != "object" || typeof ui.Index == "undefined" || typeof ui.Identity == "undefined" || typeof ui.Password == "undefined" || typeof ui.Active == "undefined" || typeof ui.Priority == "undefined" || typeof ui.MaxSessionNum == "undefined" || typeof ui.ActorType == "undefined" || typeof ui.Actor_Index == "undefined")
						{
							NPPUtils.Log(fn, "options.userInformation error...");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
						}
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_AddUser"><User Index="'+(ui.Index||0)+'" Identity="'+(ui.Identity||"")+'" Password="'+MD5.Hex_MD5(ui.Password||"")+'" Active="'+(ui.Active||0)+'" Priority="'+(ui.Priority||0)+'" MaxSessionNum="'+(ui.MaxSessionNum||"")+'" ActorType="'+(ui.ActorType||0)+'" Actor_Index="'+(ui.Actor_Index||0)+'" Name="'+(ui.Name||"")+'" Phones="'+(ui.Phones||"")+'" Description="'+(ui.Description||"")+'" Remark="'+(ui.Remark||"")+'" EnableWhiteList="'+(ui.EnableWhiteList||0)+'" /></Cmd></Msg>';
						break;
					case "UpdateUser":
						var ui = options.userInformation = options.userInformation || {};
						if (typeof ui.Index == "undefined")
						{
							NPPUtils.Log(fn, "options.userInformation Index must exist ...");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						var xmlUser = '<User ';
						if (typeof ui.Index != "undefined")
						{
							xmlUser += 'Index="' + (ui.Index || 0) + '" ';
						}
						if (typeof ui.Password != "undefined")
						{
							xmlUser += 'Password="' + MD5.Hex_MD5(ui.Password || "") + '" ';
						}
						if (typeof ui.Active != "undefined")
						{
							xmlUser += 'Active="' + (ui.Active || 0) + '" ';
						}
						if (typeof ui.Priority != "undefined")
						{
							xmlUser += 'Priority="' + (ui.Priority || 0) + '" ';
						}
						if (typeof ui.MaxSessionNum != "undefined")
						{
							xmlUser += 'MaxSessionNum="' + (ui.MaxSessionNum || 0) + '" ';
						}
						if (typeof ui.Name != "undefined")
						{
							xmlUser += 'Name="' + (ui.Name || "") + '" ';
						}
						if (typeof ui.Phones != "undefined")
						{
							xmlUser += 'Phones="' + (ui.Phones || "") + '" ';
						}
						if (typeof ui.Description != "undefined")
						{
							xmlUser += 'Description="' + (ui.Description || "") + '" ';
						}
						if (typeof ui.Remark != "undefined")
						{
							xmlUser += 'Remark="' + (ui.Remark || "") + '" ';
						}
						if (typeof ui.EnableWhiteList != "undefined")
						{
							xmlUser += 'EnableWhiteList="' + (ui.EnableWhiteList || 0) + '" ';
						}
						xmlUser += '/>';
						
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_UpdateUser">' + xmlUser + '</Cmd></Msg>';
						break;
					case "DeleteUser":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_DeleteUser"><User Index="'+options.userIndex+'" /></Cmd></Msg>';	
						break;
					case "AddUserResource":
					case "RemoveUserResource":
						if (!options.resSets || typeof options.resSets != "object")
						{
							NPPUtils.Log(fn, "options.resSets null ...");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (options.resSets.constructor != Array)
						{
							options.resSets = [options.resSets];	
						}
						var xmlRes = '';
						for (var i = 0; i < options.resSets.length; i++)
						{
							xmlRes += '<Res PUID="'+options.resSets[i].PUID+'" Type="'+options.resSets[i].Type+'" Idx="'+options.resSets[i].Idx+'" />';	
						}
						var operationID = (action == 'AddUserResource' ? 'CTL_CUI_AddUserResource' : 'CTL_CUI_RemoveUserResource');
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="'+operationID+'"><User Index="'+options.userIndex+'">'+xmlRes+'</User></Cmd></Msg>';
						break;
					case "AddUserLogicGroup":
					case "RemoveUserLogicGroup":
						if (!options.logicGroupIndexs || typeof options.logicGroupIndexs != "object")
						{
							NPPUtils.Log(fn, "options.logicGroupIndexs null ...");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (options.logicGroupIndexs.constructor != Array)
						{
							options.logicGroupIndexs = [options.logicGroupIndexs];	
						}
						var xmlRes = '';
						for (var i = 0; i < options.logicGroupIndexs.length; i++)
						{
							xmlRes += '<LogicGroup Index="'+options.logicGroupIndexs[i].Index+'" />';	
						}
						var operationID = (action == 'AddUserLogicGroup' ? 'CTL_CUI_AddUserLogicGroup' : 'CTL_CUI_RemoveUserLogicGroup');
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="'+operationID+'"><User Index="'+options.userIndex+'">'+xmlRes+'</User></Cmd></Msg>';
						break;
					case "QueryOnlineUsers":
						var xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryOnlineUsers"></Cmd></Msg>';
						break;
					case "KickOnlineUsers":
						var xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_KickOnlineUsers"><OnlineUser CUID="'+options.CUID+'" /></Cmd></Msg>';
						break;
						
				}
				var operator = NPPIF.TransNUCommonMessage
				(
				 	_connStruct.nc, 
					_connStruct.session, 
					options.nuType_cui, 
					options.nuid_cui, 
					xmlRequest
				);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
					{
						var jsonResponse = (new XML.ObjTree()).parseXML(operator.response);
						
						if (jsonResponse && jsonResponse.Msg && jsonResponse.Msg.Cmd && jsonResponse.Msg.Cmd.NUErrorCode == 0)
						{ 
							switch (action)
							{
								case "QueryUserIndex":
								case "AddUser":
									if (jsonResponse.Msg.Cmd.User)
									{
										operator.response = Number(jsonResponse.Msg.Cmd.User.Index || 0);
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "UpdateUser":
								case "DeleteUser":
								case "AddUserResource":
								case "RemoveUserResource":
								case "AddUserLogicGroup":
								case "RemoveUserLogicGroup":
								case "KickOnlineUsers":
									break;
								case "QueryUserInformation":
									if (jsonResponse.Msg.Cmd.User)
									{
										operator.response = jsonResponse.Msg.Cmd.User;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "QueryUserResource":
									var Res = jsonResponse.Msg.Cmd.Res;
									if (typeof Res == "object")
									{
										if (Res.constructor != Array) Res = [Res];
										operator.response = Res;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "QueryUserLogicGroup":
									var LogicGroup = jsonResponse.Msg.Cmd.LogicGroup;
									if (typeof LogicGroup == "object")
									{
										if (LogicGroup.constructor != Array) LogicGroup = [LogicGroup];
										operator.response = LogicGroup;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "QuerySubUsers":
									var User = jsonResponse.Msg.Cmd.User;
									if (typeof User == "object")
									{
										if (User.constructor != Array) User = [User];
										operator.response = User;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "QueryOnlineUsers":
									var OnlineUser = jsonResponse.Msg.Cmd.OnlineUser;
									if (typeof OnlineUser == "object")
									{
										if (OnlineUser.constructor != Array) OnlineUser = [OnlineUser];
										operator.response = OnlineUser;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
							}
						}
						else
						{
							NPPUtils.Log(fn, "NUErrorCode -> " + jsonResponse.Msg.Cmd.NUErrorCode);
							operator.rv = jsonResponse.Msg.Cmd.NUErrorCode;
						}
					} 
				}
				return operator;
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		end : true
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: User Management - 2014.02.14
    * ........................................................................................................
    **/
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: User Actor Management - 2014.02.17
    * ........................................................................................................
    **/
	UserActorManagementControl :
	{
		/*
		---
		desc: 获取系统支持的操作信息
		params: 
			- connectId(string) 连接ID
		returns:
			- response: Array(Object) 
			{
				Index(uint) 操作索引
				Type(string) 操作类型
				ID(string) 操作ID
			}
		...
		*/
		QueryOperationInfo : function (connectId)
		{
			return this.__Sdk_UAMCtl
			(
				"QueryOperationInfo",
				{
					connectId: connectId	
				}
			);
		},
		/*
		---
		desc: 获取预定义角色列表
		params: 
			- connectId(string) 连接ID
		returns:
			- response: Array(Object) 
			{
				Index(uint) 角色索引
				Name(string) 角色名称
				Description(string) 角色描述
			}
		...
		*/
		QueryPredefinedActorSets : function (connectId)
		{
			return this.__Sdk_UAMCtl
			(
				"QueryPredefinedActorSets",
				{
					connectId: connectId	
				}
			);
		},
		/*
		---
		desc: 获取自定义角色列表
		params: 
			- connectId(string) 连接ID
		returns:
			- response: Array(Object) 
			{
				Index(uint) 角色索引
				Name(string) 角色名称
				Description(string) 角色描述
			}
		...
		*/
		QueryUserdefinedActorSets : function (connectId)
		{
			return this.__Sdk_UAMCtl
			(
				"QueryUserdefinedActorSets",
				{
					connectId: connectId	
				}
			);
		},
		/*
		---
		desc: 获取角色对应的操作
		params: 
			- connectId(string) 连接ID
			- actorType(uint) 角色类型，0自定义类型1为预定义类型
			- actorIndex(uint) 角色索引
		returns:
			- response: Array(Object) 
			{
				Index(uint) 操作索引
			}
		...
		*/
		QueryActorOperation : function (connectId, actorType, actorIndex)
		{
			return this.__Sdk_UAMCtl
			(
				"QueryActorOperation",
				{
					connectId: connectId,
					actorType: actorType,
					actorIndex: actorIndex 
				}
			);
		},
		// - 获取角色对应的用户列表
		QueryActorUserSets : function (connectId, actorType, actorIndex)
		{
			return this.__Sdk_UAMCtl
			(
				"QueryActorUserSets",
				{
					connectId: connectId,
					actorType: actorType,
					actorIndex: actorIndex 
				}
			);
		},
		/*
		---
		desc: 添加自定义角色（admin用户才能使用）
		params: 
			- connectId(string) 连接ID
			- actorName(string) 角色名称
			- actorDesc(string) 角色描述
			- actorOptIndexs(Array) 操作索引集合
		...
		*/
		AddUserdefinedActor : function (connectId, actorName, actorDesc, actorOptIndexs)
		{
			return this.__Sdk_UAMCtl
			(
				"AddUserdefinedActor",
				{
					connectId: connectId,
					actorName: actorName,
					actorDesc: actorDesc,
					actorOptIndexs: actorOptIndexs
				}
			);
		},
		// - 更新自定义角色 admin才能使用
		UpdateUserdefinedActor : function (connectId, actorIndex, actorName, actorDesc, actorOptIndexs)
		{
			return this.__Sdk_UAMCtl
			(
				"UpdateUserdefinedActor",
				{
					connectId: connectId,
					actorIndex: actorIndex,
					actorName: actorName,
					actorDesc: actorDesc,
					actorOptIndexs: actorOptIndexs
				}
			);
		},
		// - 删除自定义角色 admin才能使用
		DeleteUserdefinedActor : function (connectId, actorIndex)
		{
			return this.__Sdk_UAMCtl
			(
				"DeleteUserdefinedActor",
				{
					connectId: connectId,
					actorIndex: actorIndex
				}
			);
		},
		
		__Sdk_UAMCtl : function (action, options)
		{
			try 
			{
				var fn = "NPPILY.UserActorManagementControl.__Sdk_UAMCtl - > " + action;
				
				var options = options || {};
				
				if (!options.connectId || !NPPILY.Connections.get(options.connectId))
				{
					NPPUtils.Log(fn, "options.connectId error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
				}
				var _connStruct = NPPILY.Connections.get(options.connectId);
				
				options.nuType_cui = options.nuType_cui || 5;
				options.nuid_cui = options.nuid_cui || "005000100000000001";
				
				var xmlRequest;
				switch (action)
				{
					case "QueryOperationInfo":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryOperationInfo" /></Msg>';
						break;
					case "QueryPredefinedActorSets":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryPredefinedActorSets" /></Msg>';
						break;
					case "QueryUserdefinedActorSets":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryPredefinedActorSets" /></Msg>';
						break;
					case "QueryActorOperation":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryActorOperation"><Actor Type="'+options.actorType+'" Index="'+options.actorIndex+'" /></Cmd></Msg>';
						break;
					case "QueryActorUserSets":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_QueryActorUserSets"><Actor Type="'+options.actorType+'" Index="'+options.actorIndex+'" /></Cmd></Msg>';
						break;
					case "AddUserdefinedActor":
						if (!options.actorOptIndexs || typeof options.actorOptIndexs != "object")
						{
							NPPUtils.Log(fn, "options.actorOptIndexs null ...");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (options.actorOptIndexs.constructor != Array)
						{
							options.actorOptIndexs = [options.actorOptIndexs];	
						}
						var xmlOpt = '';
						for (var i = 0; i < options.actorOptIndexs.length; i++)
						{
							xmlOpt += '<Opt Index="'+options.actorOptIndexs[i].Index+'" />';	
						}
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_AddUserdefinedActor"><Actor Name="'+options.actorName+'" Description="'+options.actorDesc+'">'+xmlOpt+'</Actor></Cmd></Msg>';
						break;
					case "UpdateUserdefinedActor":
						if (!options.actorOptIndexs || typeof options.actorOptIndexs != "object")
						{
							NPPUtils.Log(fn, "options.actorOptIndexs null ...");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
						}
						if (options.actorOptIndexs.constructor != Array)
						{
							options.actorOptIndexs = [options.actorOptIndexs];	
						}
						var xmlOpt = '';
						for (var i = 0; i < options.actorOptIndexs.length; i++)
						{
							xmlOpt += '<Opt Index="'+options.actorOptIndexs[i].Index+'" />';	
						}
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_UpdateUserdefinedActor"><Actor Index="'+options.actorIndex+'" Name="'+options.actorName+'" Description="'+options.actorDesc+'">'+xmlOpt+'</Actor></Cmd></Msg>';
						break;
					case "DeleteUserdefinedActor":
						xmlRequest = '<?xml version="1.0" encoding="utf-8" ?><Msg Name="CUCustomMsgReq"><Cmd Type="CTL" OptID="CTL_CUI_DeleteUserdefinedActor"><Actor Index="'+options.actorIndex+'" /></Cmd></Msg>';
						break;
				}
				var operator = NPPIF.TransNUCommonMessage
				(
				 	_connStruct.nc, 
					_connStruct.session, 
					options.nuType_cui, 
					options.nuid_cui, 
					xmlRequest
				);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
					{
						var jsonResponse = (new XML.ObjTree()).parseXML(operator.response);
						
						if (jsonResponse && jsonResponse.Msg && jsonResponse.Msg.Cmd && jsonResponse.Msg.Cmd.NUErrorCode == 0)
						{ 
							switch (action)
							{
								case "QueryOperationInfo":
								case "QueryUserdefinedActorSets":
								case "QueryActorOperation":
									var Opt = jsonResponse.Msg.Cmd.Opt;
									if (typeof Opt == "object")
									{
										if (Opt.constructor != Array) Opt = [Opt];
										operator.response = Opt;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "QueryPredefinedActorSets":
								case "QueryUserdefinedActorSets":
									var Actor = jsonResponse.Msg.Cmd.Actor;
									if (typeof Actor == "object")
									{
										if (Actor.constructor != Array) Actor = [Actor];
										operator.response = Actor;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "QueryActorUserSets":
									var User = jsonResponse.Msg.Cmd.User;
									if (typeof User == "object")
									{
										if (User.constructor != Array) User = [User];
										operator.response = User;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								case "AddUserdefinedActor":
									var Actor = jsonResponse.Msg.Cmd.Actor;
									if (typeof Actor == "object")
									{
										operator.response = Actor.Index;
									}
									else
									{
										operator.rv = NrcapError.NRCAP_FAILED;	
									}
									break;
								
								case "UpdateUserdefinedActor":
								case "DeleteUserdefinedActor":
									break;
							}
						}
						else
						{
							NPPUtils.Log(fn, "NUErrorCode -> " + jsonResponse.Msg.Cmd.NUErrorCode);
							operator.rv = jsonResponse.Msg.Cmd.NUErrorCode;
						}
					} 
				}
				return operator;
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		end : true
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: User Actor Management - 2014.02.17
    * ........................................................................................................
    **/
	/*
	---
	fn : CommonRequest
	desc : （支持多命令）联合请求
	author :
		- huzw
	time : 2013.10.15
	params : 
		- connectId(string) 连接ID
		- options(object) 选择传入参数
	remark :
		- options => 
		{
			cmdType(NPPILF.Enum.CmdType) * 请求命令类型，所有请求项符合此类型
			puid(string) 请求对象设备PUID，所有请求项针对此设备；直连设备时比较随意，可省略 
			xmlDstRes(xml string) * 联合请求命令
			xmlObjSets(xml string) 其他可能对象参数（如查询中心存储文件时需要，含<ObjSets>...</ObjSets>）
			domainRoad(string) 级联子域名称，根平台默认为空字符串
			returnType(string) 响应字符串格式xml | json(default)
			returnFlag(uint) 解析信号量（0内部解析，1留给上层自行解析，当returnType='xml'时，视returnFlag===1处理）
		}
		- options.xmlDstRes => 
			<DstRes Type=\"?\" Idx=\"?\" OptID=\"?\"  StreamType=\"?\"... ><Param ... /></DstRes>...<DstRes ...>...</DstRes>
		- options.xmlObjSets =>
			<ObjSets><Res ObjType=\"?\" ObjID=\"?\" Type=\"?\" Idx=\"?\" ></Res>...</ObjSets>
	...
	*/
	CommonRequest : function(connectId, options)
	{
		try
		{
			var fn = "NPPILY.CommonRequest";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
		
			var _connStruct = NPPILY.Connections.get(connectId);
			
			if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connected)
			{
				var options = options || {};
				
				if (!options.cmdType || typeof NPPILY.Enum.CmdType[options.cmdType] == "undefined")
				{
					NPPUtils.Log(fn, "options.cmdType error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
				}
				if (_connStruct.connType != NPPILY.Enum.ConnectionType.Device)
				{
					if (!options.puid || !NPPUtils.Regexs.puid.test(options.puid))
					{
						NPPUtils.Log(fn, "options.puid error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
					}
					else
					{
						var operator = NPPILY.NPPSDKCommon.PUIsOnline(connectId, options.puid);
						if (operator.rv != NrcapError.NRCAP_SUCCESS)
						{
							NPPUtils.Log(fn, "options.puid not online~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PU_OFFLINE);	
						}
					}
				}
				if (!options.xmlDstRes)
				{
					NPPUtils.Log(fn, "options.xmlDstRes error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
				}
				
				options.domainRoad = options.domainRoad || "";
				options.returnType = options.returnType || "json";
				options.returnFlag = options.returnFlag || 0;
				
				var prio_operator = NPPIF.GetUserPriority(_connStruct.nc, _connStruct.session);
				var priority = prio_operator.response || 1;
				
				var requestXML = '<?xml version="1.0" encoding="UTF-8"?><Msg Name="CUCommonMsgReq" DomainRoad="' + options.domainRoad + '"><Cmd Type="' + options.cmdType + '" Prio="' + priority + '" EPID="' + (_connStruct.connParam.epId || "system") + '">' + options.xmlDstRes + '</Cmd>' + (options.xmlObjSets || "") + '</Msg>';
				
				NPPUtils.Log(fn, "requestXML -> " + requestXML);
				
				var operator = NPPIF.TransCommonMessage(_connStruct.nc, _connStruct.session, (options.puid || ""), requestXML);
				
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					if (options.returnType.toLowerCase() == "json")
					{
						if (typeof XML != "undefined" && typeof XML.ObjTree != "undefined")
						{
							var _response = (new XML.ObjTree()).parseXML(operator.response);
							if (options.returnFlag == "0")
							{
								if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && typeof _response.Msg.Cmd.NUErrorCode != "undefined" && _response.Msg.Cmd.NUErrorCode != "0")
								{
									// - 返回具体的NUErrorCode错误码
									operator.rv = _response.Msg.Cmd.NUErrorCode || -1;
								}
								else if (typeof _response == "object" && _response.Msg && _response.Msg.Cmd && _response.Msg.Cmd.DstRes) 
								{
									_response = _response.Msg.Cmd.DstRes || {};
									if (typeof _response == "object" && (_response.constructor != Array || _response.length == 1))
									{
										if (_response.constructor == Array)
										{
											_response = _response[0];	
										}
										if (typeof _response.ErrorCode != "undefined" && _response.ErrorCode != "0")
										{
											// - 返回具体的ErrorCode错误码
											operator.rv = _response.ErrorCode || -1;
										}
										// - 单个节点就解析单个的
										if (typeof _response.Param != "undefined")
										{
											_response = _response.Param;
										}
									}
								}
							}
							operator.response = _response;
						}
					}
				}
				return operator;
			}
			else
			{
				NPPUtils.Log(fn, "connectId hav't built ~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
			}
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},  
	// - 配置项
	Config :
	{
		GetSimple : function(connectId, puid, resType, resIdx, configID, streamType, customParams)
		{
			var operator = NPPILY.CommonRequest
			(
				connectId, 
				{
					cmdType : NPPILY.Enum.CmdType.GET,
					puid : puid || "",
					xmlDstRes : '<DstRes Type="'+(resType||"")+'" Idx="'+(typeof resIdx != "undefined" && !isNaN(resIdx) ? resIdx : "")+'" OptID="'+(configID||"")+'" '+(streamType?'StreamType="'+streamType+'"' : '')+'></DstRes>',
					returnFlag : (typeof customParams == "object" ? (customParams.returnFlag || 0) : 0)
				}
			);
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				if (typeof operator.response.Value != "undefined")
				{
					// - 截取具体的值即可
					operator.response = operator.response.Value;
				}
			}
			return operator;
		},
		SetSimple : function(connectId, puid, resType, resIdx, configID, streamType, value, customParams)
		{
			return NPPILY.CommonRequest
			(
				connectId, 
				{
					cmdType : NPPILY.Enum.CmdType.SET,
					puid : puid || "",
					xmlDstRes : '<DstRes Type="'+(resType||"")+'" Idx="'+(typeof resIdx != "undefined" && !isNaN(resIdx) ? resIdx : "")+'" OptID="'+(configID||"")+'" '+(streamType?'StreamType="'+streamType+'"' : '')+'><Param Value="'+(typeof value != "undefined" && value != null ? value : '')+'" /></DstRes>',
					returnFlag : (typeof customParams == "object" ? (customParams.returnFlag || 0) : 0)
				}
			);	
		},
		/*
		---
		remark :
			- reqParams =>
			{
				puid(string) * 设备PUID
				resType(NPPILY.Enum.PuResourceType) * 资源类型
				resIdx(uint) * 资源索引
				configID(string) * 配置命令
				streamType(NPPILY.Enum.NrcapStreamType) 流类型
				returnType(string) xml | json(default)
				returnFlag(uint) 0(default)返回有用的节点 | 1自行解析，当returnType='xml'时，视returnFlag===1处理
				cmdType(NPPILY.Enum.CmdType) 默认GET
				domainRoad(string) 级联子域名称，根平台默认为空字符串
			}
		...
		*/
		GetComplex : function(connectId, reqParams)
		{
			var reqParams = reqParams || {};
			return NPPILY.CommonRequest
			(
				connectId,
				{
					cmdType : (reqParams.cmdType || NPPILY.Enum.CmdType.GET),
					puid : reqParams.puid || "",
					xmlDstRes : '<DstRes Type="'+(reqParams.resType||"")+'" Idx="'+(typeof reqParams.resIdx != "undefined" && !isNaN(reqParams.resIdx) ? reqParams.resIdx : "")+'" OptID="'+(reqParams.configID||"")+'" '+(reqParams.streamType?'StreamType="'+reqParams.streamType+'"' : '')+'></DstRes>',
					xmlObjSets : (reqParams.xmlObjSets || ""),
					domainRoad : (reqParams.domainRoad || ""),
					returnType : (reqParams.returnType || "json"),
					returnFlag : (reqParams.returnFlag || 0)	
				}
			);
		},
		/*
		---
		remark :
			- setParams =>
			{
				puid(string) * 设备PUID
				resType(NPPILY.Enum.PuResourceType) * 资源类型
				resIdx(uint) * 资源索引
				configID(string) * 配置命令
				param(xml string) * 含<Param ...>...</Param> 
				streamType(NPPILY.Enum.NrcapStreamType) 流类型
				returnType(string) xml | json(default)
				returnFlag(uint) 0(default)返回有用的节点 | 1自行解析，当returnType='xml'时，视returnFlag===1处理
				cmdType(NPPILY.Enum.CmdType) 默认SET
				domainRoad(string) 级联子域名称，根平台默认为空字符串
			}
		...
		*/
		SetComplex : function(connectId, setParams)
		{
			var setParams = setParams || {};
			return NPPILY.CommonRequest
			(
				connectId,
				{
					cmdType : (setParams.cmdType || NPPILY.Enum.CmdType.SET),
					puid : setParams.puid || "",
					xmlDstRes : '<DstRes Type="'+(setParams.resType||"")+'" Idx="'+(typeof setParams.resIdx != "undefined" && !isNaN(setParams.resIdx) ? setParams.resIdx : "")+'" OptID="'+(setParams.configID||"")+'" '+(setParams.streamType?'StreamType="'+setParams.streamType+'"' : '')+'>' + (setParams.param || '<Param />') + '</DstRes>',
					xmlObjSets : (setParams.xmlObjSets || ""),
					domainRoad : (setParams.domainRoad || ""),
					returnType : (setParams.returnType || "json"),
					returnFlag : (setParams.returnFlag || 0)	
				}
			);
		}
	},
	// - 控制命令
	Control : 
	{
		/*
		---
		remark :
			- reqParams =>
			{
				puid(string) * 设备PUID
				resType(NPPILY.Enum.PuResourceType) * 资源类型
				resIdx(uint) * 资源索引
				controlID(string) * 控制命令
				param(xml string) * 含<Param ...>...</Param> 
				streamType(NPPILY.Enum.NrcapStreamType) 流类型
				returnType(string) xml | json(default)
				returnFlag(uint) 0(default)返回有用的节点 | 1自行解析，当returnType='xml'时，视returnFlag===1处理
				cmdType(NPPILY.Enum.CmdType) 默认CTL
				xmlObjSets(xml string) 其他可能对象参数（如查询中心存储文件时需要，含<ObjSets>...</ObjSets>）
				domainRoad(string) 级联子域名称，根平台默认为空字符串
			}
		...
		*/
		CommonGet : function(connectId, reqParams)
		{
			var reqParams = reqParams || {};
			return NPPILY.CommonRequest
			(
				connectId,
				{
					cmdType : (reqParams.cmdType || NPPILY.Enum.CmdType.CTL),
					puid : reqParams.puid || "",
					xmlDstRes : '<DstRes Type="'+(reqParams.resType||"")+'" Idx="'+(typeof reqParams.resIdx != "undefined" && !isNaN(reqParams.resIdx) ? reqParams.resIdx : "")+'" OptID="'+(reqParams.controlID||"")+'" '+(reqParams.streamType?'StreamType="'+reqParams.streamType+'"' : '')+'>' + (reqParams.param || '<Param />') + '</DstRes>',
					xmlObjSets : (reqParams.xmlObjSets || ""),
					domainRoad : (reqParams.domainRoad || ""),
					returnType : (reqParams.returnType || "json"),
					returnFlag : (reqParams.returnFlag || 0)	
				}
			);
		},
		/*
		---
		remark :
			- setParams =>
			{
				puid(string) * 设备PUID
				resType(NPPILY.Enum.PuResourceType) * 资源类型
				resIdx(uint) * 资源索引
				controlID(string) * 控制命令
				param(xml string) * 含<Param ...>...</Param> 
				streamType(NPPILY.Enum.NrcapStreamType) 流类型
				returnType(string) xml | json(default)
				returnFlag(uint) 0(default)返回有用的节点 | 1自行解析，当returnType='xml'时，视returnFlag===1处理
				cmdType(NPPILY.Enum.CmdType) 默认CTL
				xmlObjSets(xml string) 其他可能对象参数（如查询中心存储文件时需要，含<ObjSets>...</ObjSets>）
				domainRoad(string) 级联子域名称，根平台默认为空字符串
			}
		...
		*/
		CommonSet : function(connectId, setParams)
		{
			var setParams = setParams || {};
			return NPPILY.CommonRequest
			(
				connectId,
				{
					cmdType : (setParams.cmdType || NPPILY.Enum.CmdType.CTL),
					puid : setParams.puid || "",
					xmlDstRes : '<DstRes Type="'+(setParams.resType||"")+'" Idx="'+(typeof setParams.resIdx != "undefined" && !isNaN(setParams.resIdx) ? setParams.resIdx : "")+'" OptID="'+(setParams.controlID||"")+'" '+(setParams.streamType?'StreamType="'+setParams.streamType+'"' : '')+'>' + (setParams.param || '<Param />') + '</DstRes>',
					xmlObjSets : (setParams.xmlObjSets || ""),
					domainRoad : (setParams.domainRoad || ""),
					returnType : (setParams.returnType || "json"),
					returnFlag : (setParams.returnFlag || 0)	
				}
			);	
		}
	},
	
	/* 平台命令 */
	// - 获取资源是否可用
	GetResourceUsable : function (connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.GetResourceUsable, puid);
	},
	// 获取资源是否使能
	GetResourceEnable : function (connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.GetResourceEnable, puid);
	},
	
	/* 设备命令 */
	// - 所有资源描述 
	ST_GetResDescSets : function (connectId, puid) 
	{
		return NPPILY.Config.GetSimple(connectId, (puid || ""), NPPILY.Enum.PuResourceType.SELF, 0, "CFG_ST_ResDescSets");
	},
	// - 获取PUID
	ST_GetPUID : function (connectId, puid)
	{
		return NPPILY.Config.GetSimple(connectId, (puid || ""), NPPILY.Enum.PuResourceType.SELF, 0, "CFG_ST_PUID");
	},
	// - 设置PUID
	ST_SetPUID : function (connectId, puid, newPuidValue)
	{
		return NPPILY.Config.SetSimple(connectId, (puid || ""), NPPILY.Enum.PuResourceType.SELF, 0, "CFG_ST_PUID", "", newPuidValue);
	},
	// - 平台地址
	ST_GetPlatformAddr : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetPlatformAddr, puid);
	},
	ST_SetPlatformAddr : function(connectId, puid, platformAddr)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_SetPlatformAddr, puid, platformAddr);
	}, 
	// - 设备接入密码
	ST_GetRegPsw : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetRegPsw, puid);
	}, 
	ST_SetRegPsw : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_SetRegPsw, puid);
	}, 
	// - 设备型号
	ST_GetModel : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetModel, puid);
	},
	// - 软件版本号
	ST_GetSoftwareVersion : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetSoftwareVersion, puid);
	},
	// - 硬件型号
	ST_GetHardwareModel : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetHardwareModel, puid);
	},
	// - 硬件版本
	ST_GetHardwareVersion : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetHardwareVersion, puid);
	},
	// - 厂商ID
	ST_GetProducerID : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetProducerID, puid);
	},
	// - 设备ID
	ST_GetDeviceID : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetDeviceID, puid);
	},
	// - 设备时区
	ST_GetTZ : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetTZ, puid);
	},
	ST_SetTZ : function(connectId, puid, timeZone)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_SetTZ, puid, timeZone);
	},
	// - 设备与平台同步时间的间隔
	ST_GetTimeSyncInterval : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetTimeSyncInterval, puid);
	},
	ST_SetTimeSyncInterval : function(connectId, puid, nTimeSyncInterval)

	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_SetTimeSyncInterval, puid, nTimeSyncInterval);
	},
	// - OEM数据
	ST_GetOEMData : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetOEMData, puid);
	},
	ST_SetOEMData : function(connectId, puid, OEMData)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_SetOEMData, puid, OEMData);
	},
	// - 发送让视频服务器重启的命令
	ST_Reboot : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_Reboot, puid);
	},
	// - 时间
	ST_GetTime : function(connectId, puid)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_GetTime, puid);
	},
	ST_SetTime : function(connectId, puid, time)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ST_SetTime, puid, time);
	},
	
	// - s - 前端联动配置 @huzw 2014.01.02 ------------------------------------------------
	/*
	---
	desc: 获取支持的事件
	...
	*/
	ST_GetSupportedEventSets : function (connectId, puid)
	{
		try 
		{
			var fn = "NPPILY.ST_GetSupportedEventSets";
			
			var operator = NPPILY.Config.GetComplex
			(
				connectId, 
				{
					puid: puid,
					resType: NPPILY.Enum.PuResourceType.SELF,
					resIdx: 0,
					configID: "CFG_ST_SupportedEventSets"
				}
			);
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				var _response = operator.response;
				if (typeof _response != "undefined" && typeof _response.SrcRes != "undefined")
				{
					if (typeof _response.SrcRes == "object")
					{
						if (_response.SrcRes.constructor != Array)
						{
							_response.SrcRes = [_response.SrcRes];	
						}
						var map = {};
						for (var i = 0; i < _response.SrcRes.length; i++)
						{
							var item = _response.SrcRes[i];
							if (item.Type && item.Event)
							{
								if (typeof map[item.Type] == "undefined")
								{
									map[item.Type] = [];
								}
								if (item.Event.constructor != Array) 

								{
									item.Event = [item.Event];
								}
								for (var j = 0; j < item.Event.length; j++)
								{
									switch (item.Event[j])
									{
										case "alertIn":
											item.Event[j] = "EVT_IDL_AlertIn";
											break;
										case "signalLost":
											item.Event[j] = "EVT_IV_SignalLost";
											break;
										case "motDetect":
											item.Event[j] = "EVT_IV_MotionDetected";
											break;
										case "coverDetect":
											item.Event[j] = "EVT_IV_CoverDetected";
											break;
									}
								}
								map[item.Type] = map[item.Type].concat(item.Event);
							}
						}
						operator.response = [];
						for (var key in map)
						{
							if (typeof map[key] == "object" && map[key].constructor == Array && map[key].length > 0)
							{
								operator.response.push({"Type": key, "Event": map[key]});	
							}
						}
					}
				} 
			} 
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD, e);
		}
	},
	/*
	---
	desc: 获取支持的动作
	returns:
		- response::Array 如["alertOut", "record", ...]
		含义：alertOut 			报警输出
			sendEmail			发送电子邮件,并附抓图
			ftpUpload			抓拍上传到FTP服务器
			record				开始前端录像
			snapShot				开始前端抓拍
			moveToPresetPosition	前往预置位
			online				上线
			sendSMS				发送报警短信
			preTransmitVideo		预传视频
			preSnapshot			预抓图
			preTransmitAudio		预传音频
			preTransmitGPS		预传定位信息
			uploadAlert			上传报警信息
			uploadRecord		上传录像,实时上传视频和音频
			playTipVoice		播放提示声音
	...
	*/
	ST_GetSupportedActionSets : function (connectId, puid)
	{
		try 
		{
			var fn = "NPPILY.ST_GetSupportedActionSets";
			
			var operator = NPPILY.Config.GetComplex
			(
				connectId, 
				{
					puid: puid,
					resType: NPPILY.Enum.PuResourceType.SELF,
					resIdx: 0,
					configID: "CFG_ST_SupportedActionSets"
				}
			);
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				if (typeof operator.response != "undefined" && typeof operator.response.Action != "undefined")
				{
					if (operator.response.Action.constructor != Array)
					{
						operator.response.Action = [operator.response.Action];
					}
					operator.response = operator.response.Action;
				}
			}
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD, e);
		}
	},
	/*
	---
	desc: 获取前端联动配置
	...
	*/
	ST_GetDeviceLinkActions : function (connectId, puid, returnType)
	{
		try
		{
			var fn = "NPPILY.ST_GetDeviceLinkActions";
			
			return NPPILY.Config.GetComplex
			(
				connectId, 
				{
					puid: puid,
					resType: NPPILY.Enum.PuResourceType.SELF,
					resIdx: 0,
					configID: "CFG_ST_DeviceLinkActions",
					returnType: (returnType != "xml" ? "json" : "xml")
				}
			);
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD, e);
		}
	},
	/*
	---
	desc: 设置前端联动配置
	...
	*/
	ST_SetDeviceLinkActions : function (connectId, puid, xmlDevLinkActions)
	{
		try
		{
			var fn = "NPPILY.ST_SetDeviceLinkActions";
			
			return NPPILY.Config.SetComplex
			(
				connectId, 
				{
					puid: puid,
					resType: NPPILY.Enum.PuResourceType.SELF,
					resIdx: 0,
					configID: "CFG_ST_DeviceLinkActions",
					param: "<Param>" + xmlDevLinkActions + "</Param>"
				}
			);
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD, e);
		}
	},
	// - e - 前端联动配置 @huzw 2014.01.02 ------------------------------------------------
	
	/* 视频命令 */
	// - 摄像头状态
	IV_GetCameraStatus : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetCameraStatus, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	// - 亮度
	IV_GetBrightness : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetBrightness, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetBrightness : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetBrightness, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	IV_PreviewBrightness : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_PreviewBrightness, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	// - 对比度
	IV_GetContrast : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetContrast, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetContrast : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetContrast, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	IV_PreviewContrast : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_PreviewContrast, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	// - 色调
	IV_GetHue : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetHue, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetHue : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetHue, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	IV_PreviewHue : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_PreviewHue, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	// - 饱和度
	IV_GetSaturation : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetSaturation, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetSaturation : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetSaturation, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	IV_PreviewSaturation : function(connectId, puid, ivIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_PreviewSaturation, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, value);
	},
	// - 支持的编码算法 
	IV_GetSupportedEncoderSets : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetSupportedEncoderSets, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	// - 编码算法
	IV_GetEncoder : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetEncoder, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetEncoder : function(connectId, puid, ivIndex, encoder)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetEncoder, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, encoder);
	},
	// - 支持的流类型
	IV_GetSupportedStreamTypeSets : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetSupportedStreamTypeSets, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex); 
	},
	// - 支持的编码分辨率
	IV_GetSupportedResolutionSets : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetSupportedResolutionSets, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType); 
	},
	// - 编码分辨率
	IV_GetResolution : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetResolution, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType);
	},
	IV_SetResolution : function(connectId, puid, ivIndex, streamType, resolution)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetResolution, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType, resolution);
	},
	// - 支持的编码质量控制模式
	IV_GetSupportedQualityControlModeSets : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetSupportedQualityControlModeSets, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType); 
	},
	// - 编码质量控制模式
	IV_GetQualityControlMode : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetQualityControlMode, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType);
	},
	IV_SetQualityControlMode : function(connectId, puid, ivIndex, streamType, mode)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetQualityControlMode, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType, mode);
	},
	// - 目标码率
	IV_GetBitRate : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetBitRate, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType);
	},
	IV_SetBitRate : function(connectId, puid, ivIndex, streamType, bitRate)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetBitRate, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType, bitRate);
	},
	// - 目标帧率
	IV_GetFrameRate : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetFrameRate, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType);
	},
	IV_SetFrameRate : function(connectId, puid, ivIndex, streamType, frameRate)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetFrameRate, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType, frameRate);
	},
	// - 目标清晰度
	IV_GetImageDefinition : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetImageDefinition, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType);
	},
	IV_SetImageDefinition : function(connectId, puid, ivIndex, streamType, definition)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetImageDefinition, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType, definition);
	},
	// - 是否叠加时间
	IV_GetAddTime : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetAddTime, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType);
	},
	IV_SetAddTime : function(connectId, puid, ivIndex, streamType, bValue)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetAddTime, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType, bValue);
	},
	// - 是否叠加文字
	IV_GetAddText : function(connectId, puid, ivIndex, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetAddText, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType);
	},
	IV_SetAddText : function(connectId, puid, ivIndex, streamType, bValue)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetAddText, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, streamType, bValue);
	},
	// - 叠加的文字内容
	IV_GetTextAdd : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetTextAdd, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetTextAdd : function(connectId, puid, ivIndex, text)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetTextAdd, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, text);
	},
	// - 屏蔽区域
	IV_GetCoverRegions : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetCoverRegions, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetCoverRegions : function(connectId, puid, ivIndex, regions)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetCoverRegions, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, regions);
	},
	// - 定时录像时间表
	IV_GetRecordSchedule : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetRecordSchedule, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetRecordSchedule : function(connectId, puid, ivIndex, timeMap)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetRecordSchedule, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, timeMap);
	},
	// - 是否录制对应音频
	IV_GetRecordAudio : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_GetRecordAudio, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	IV_SetRecordAudio : function(connectId, puid, ivIndex, bValue)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_SetRecordAudio, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex, bValue);
	},
	// - 请求发送I帧
	IV_StartKeyFrame : function(connectId, puid, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IV_StartKeyFrame, puid, NPPILY.Enum.PuResourceType.VideoIn, ivIndex);
	},
	
	/* 输入音频 */
	// - 输入音量
	IA_GetVolume : function(connectId, puid, iaIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IA_GetVolume, puid, NPPILY.Enum.PuResourceType.AudioIn, iaIndex);
	},
	IA_SetVolume : function(connectId, puid, iaIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IA_SetVolume, puid, NPPILY.Enum.PuResourceType.AudioIn, iaIndex, value);
	},
	IA_PreviewVolume : function(connectId, puid, iaIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IA_PreviewVolume, puid, NPPILY.Enum.PuResourceType.AudioIn, iaIndex, value);
	},
	// - 支持的编码算法
	IA_GetSupportedEncoderSets : function(connectId, puid, iaIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IA_GetSupportedEncoderSets, puid, NPPILY.Enum.PuResourceType.AudioIn, iaIndex);
	},
	// - 编码算法
	IA_GetEncoder : function(connectId, puid, iaIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IA_GetEncoder, puid, NPPILY.Enum.PuResourceType.AudioIn, iaIndex);
	},
	IA_SetEncoder : function(connectId, puid, iaIndex, encoder)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IA_SetEncoder, puid, NPPILY.Enum.PuResourceType.AudioIn, iaIndex, encoder);
	},
	// - 支持的流类型
	IA_GetSupportedStreamTypeSets : function(connectId, puid, iaIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IA_GetSupportedStreamTypeSets, puid, NPPILY.Enum.PuResourceType.AudioIn, iaIndex);
	},
	/* 串口命令 */
	// - 串口模式
	SP_GetMode : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetMode, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	// - 支持的波特率
	SP_GetSupportedBaudRateSets : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetSupportedBaudRateSets, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	// - 波特率
	SP_GetBaudRate : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetBaudRate, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	SP_SetBaudRate : function(connectId, puid, spIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_SetBaudRate, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex, value);
	},
	// - 支持的数据位
	SP_GetSupportedDataBitsSets : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetSupportedDataBitsSets, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	// - 数据位
	SP_GetDataBits : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetDataBits, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	SP_SetDataBits : function(connectId, puid, spIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_SetDataBits, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex, value);
	},
	// - 支持的校验位
	SP_GetSupportedParitySets : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetSupportedParitySets, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	// - 校验位
	SP_GetParity : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetParity, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	SP_SetParity : function(connectId, puid, spIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_SetParity, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex, value);
	},
	// - 支持的停止位
	SP_GetSupportedStopBitsSets : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetSupportedStopBitsSets, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	// - 停止位
	SP_GetStopBits : function(connectId, puid, spIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_GetStopBits, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex);
	},
	SP_SetStopBits : function(connectId, puid, spIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_SetStopBits, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex, value);
	},
	// - 发送串口数据，dataArr数组形式如[30,31,76,...]等，dataStr字符串形式，如"01D..."
	SP_WriteData : function(connectId, puid, spIndex, dataArr)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_WriteData, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex, dataArr);
	},
	SP_WriteDataStr : function(connectId, puid, spIndex, dataStr)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SP_WriteDataStr, puid, NPPILY.Enum.PuResourceType.SerialPort, spIndex, dataStr);
	},
	
	/* 云台命令 */
	// - 所接串口编号
	PTZ_GetConnectedSerialPort : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_GetConnectedSerialPort, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	PTZ_SetConnectedSerialPort : function(connectId, puid, ptzIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_SetConnectedSerialPort, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, value);
	},
	// - 所有预置位名称
	PTZ_GetPresetPositionSets : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_GetPresetPositionSets, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	PTZ_SetPresetPositionSets : function(connectId, puid, ptzIndex, posMap)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_SetPresetPositionSets, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, posMap);
	},
	// - 所有辅助设备名称
	PTZ_GetSecondaryDeviceSets : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_GetSecondaryDeviceSets, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	PTZ_SetSecondaryDeviceSets : function(connectId, puid, ptzIndex, devMap)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_SetSecondaryDeviceSets, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, devMap);
	},
	// - 支持的云台协议
	PTZ_GetSupportedProtocolSets : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_GetSupportedProtocolSets, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 控制协议
	PTZ_GetProtocol : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_GetProtocol, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	PTZ_SetProtocol : function(connectId, puid, ptzIndex, protocol)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_SetProtocol, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, protocol);
	},
	// - 解码器地址
	PTZ_GetDecoderAddress : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_GetDecoderAddress, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	PTZ_SetDecoderAddress : function(connectId, puid, ptzIndex, decoderAddr)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_SetDecoderAddress, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, decoderAddr);
	},
	// - PTZ移动的速度
	PTZ_GetSpeed : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_GetSpeed, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	PTZ_SetSpeed : function(connectId, puid, ptzIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_SetSpeed, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, value);
	},
	// - 向左转（动）
	PTZ_StartTurnLeft : function(connectId, puid, ptzIndex, turnDegree)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StartTurnLeft, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (turnDegree || 0));
	},
	// - 向右转（动）
	PTZ_StartTurnRight : function(connectId, puid, ptzIndex, turnDegree)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StartTurnRight, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (turnDegree || 0));
	},
	// - 向上转（动）
	PTZ_StartTurnUp : function(connectId, puid, ptzIndex, turnDegree)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StartTurnUp, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (turnDegree || 0));
	},
	// - 向下转（动）
	PTZ_StartTurnDown : function(connectId, puid, ptzIndex, turnDegree)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StartTurnDown, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (turnDegree || 0));
	},
	// - 停止转动
	PTZ_StopTurn : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StopTurn, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 增大光圈
	PTZ_AugmentAperture : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_AugmentAperture, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 减小光圈
	PTZ_MinishAperture : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_MinishAperture, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 停止光圈缩放
	PTZ_StopApertureZoom : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StopApertureZoom, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 推远焦点
	PTZ_MakeFocusFar : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_MakeFocusFar, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 拉近焦点
	PTZ_MakeFocusNear : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_MakeFocusNear, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 停止焦点调整
	PTZ_StopFocusMove : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StopFocusMove, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 缩小图像
	PTZ_ZoomOutPicture : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_ZoomOutPicture, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 放大图像
	PTZ_ZoomInPicture : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_ZoomInPicture, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 停止图像缩放
	PTZ_StopPictureZoom : function(connectId, puid, ptzIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StopPictureZoom, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex);
	},
	// - 开启辅助设备
	PTZ_StartSecondaryDev : function(connectId, puid, ptzIndex, devNumber)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StartSecondaryDev, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (devNumber || 0));
	},
	// - 关闭辅助设备
	PTZ_StopSecondaryDev : function(connectId, puid, ptzIndex, devNumber)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_StopSecondaryDev, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (devNumber || 0));
	},

	// - 前往预置位
	PTZ_MoveToPresetPos : function(connectId, puid, ptzIndex, posNumber)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_MoveToPresetPos, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (posNumber || 0));
	},
	// - 设置预置位
	PTZ_SetPresetPos : function(connectId, puid, ptzIndex, posNumber, posName)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.PTZ_SetPresetPos, puid, NPPILY.Enum.PuResourceType.PTZ, ptzIndex, (posNumber || 0), (posName || ""));
	},
	
	/* 输入报警命令 */
	// - 支持的报警触发模式
	IDL_GetSupportedAlertInModeSets : function(connectId, puid, idlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IDL_GetSupportedAlertInModeSets, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex);
	},
	// - 报警触发模式
	IDL_GetAlertInMode : function(connectId, puid, idlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IDL_GetAlertInMode, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex);
	},
	IDL_SetAlertInMode : function(connectId, puid, idlIndex, mode)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IDL_SetAlertInMode, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, mode);
	},
	// - 报警间隔
	IDL_GetAlertInDuration : function(connectId, puid, idlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IDL_GetAlertInDuration, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex);
	},
	IDL_SetAlertInDuration : function(connectId, puid, idlIndex, duration)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IDL_SetAlertInDuration, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, duration);
	},
	// - 报警输入状态
	IDL_GetAlertInStatus : function(connectId, puid, idlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.IDL_GetAlertInStatus, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex);
	},
	// - s - 其他报警输入配置 @huzw 2014.01.03 ------------------------------------------------
	/*
	---
	desc: 获取支持的工作模式
	returns:
		- response<Array(AlertIn|Counter|StatusCap)>
		含义：AlertIn	报警输入模式,该模式时,下面的报警参数生效
			Counter		计数模式,该模式时,下面的计数参数生效
			StatusCap	状态采集模式,该模式时,下面的"状态是否有效"生效 
	...
	*/
	IDL_GetSupportedWorkModeSets : function (connectId, puid, idlIndex) 
	{
		try
		{
			var fn = "NPPILY.IDL_GetSupportedWorkModeSets";
			
			var operator = NPPILY.Config.GetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_SupportedWorkModeSets");
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				if (operator.response != null && typeof operator.response.WorkMode == "object")
				{
					if (operator.response.WorkMode.constructor != Array)
					{
						operator.response.WorkMode = [operator.response.WorkMode];
					}
					operator.response = operator.response.WorkMode;
				}
				else
				{
					operator.response = [];	
				}
			}
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValue(NrcapError.NRCAP_ERROR_THREAD, e);
		}
	},
	// - 当前的工作模式
	IDL_GetWorkMode : function (connectId, puid, idlIndex) 
	{
		return NPPILY.Config.GetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_WorkMode");
	},
	IDL_SetWorkMode : function (connectId, puid, idlIndex, value) 
	{
		return NPPILY.Config.SetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_WorkMode", "", value);
	},
	// - 获取开始计数时间，返回UTC时间秒
	IDL_GetCountBeginTime : function (connectId, puid, idlIndex) 
	{
		return NPPILY.Config.SetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_CountBeginTime");
	},
	// - 计数总值
	IDL_GetCount : function (connectId, puid, idlIndex) 
	{
		return NPPILY.Config.SetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_Count");
	},
	// - 状态是否有效
	IDL_GetLevelValid : function (connectId, puid, idlIndex) 
	{
		return NPPILY.Config.SetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_LevelValid");
	},
	// - 读取报警布防区域信息摘要
	IDL_GetGuardRegionSetsSummary : function (connectId, puid, idlIndex)
	{
		try
		{
			var fn = "NPPILY.IDL_GetGuardRegionSetsSummary";
			
			var operator = NPPILY.Config.GetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_GuardRegionSetsSummary");
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				if (operator.response != null && typeof operator.response.Summary == "object")
				{
					operator.response = operator.response.Summary;
				}
				else
				{
					operator.response = {};	
				}
			}
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValue(NrcapError.NRCAP_ERROR_THREAD, e);
		}
	},
	// - 读取报警布防时间表
	IDL_GetGuardMap : function (connectId, puid, idlIndex)
	{
		return NPPILY.Config.GetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_GuardMap");
	},
	// - 设置报警布防时间表
	IDL_SetGuardMap : function (connectId, puid, idlIndex, mapValue)
	{
		return NPPILY.Config.SetSimple(connectId, puid, NPPILY.Enum.PuResourceType.AlertIn, idlIndex, "CFG_IDL_GuardMap", "", mapValue);
	},
	
	// - e - 其他报警输入配置 @huzw 2014.01.03 ------------------------------------------------
	
	/* 输出报警命令 */
	// - 报警输出默认状态
	ODL_GetDefaultConnectStatus : function(connectId, puid, odlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ODL_GetDefaultConnectStatus, puid, NPPILY.Enum.PuResourceType.AlertOut, odlIndex);
	},
	// - 报警输出当前状态
	ODL_GetConnectStatus : function(connectId, puid, odlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ODL_GetConnectStatus, puid, NPPILY.Enum.PuResourceType.AlertOut, odlIndex);
	},
	// - 接通动作别名
	ODL_GetAliasConnect : function(connectId, puid, odlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ODL_GetAliasConnect, puid, NPPILY.Enum.PuResourceType.AlertOut, odlIndex);
	},
	ODL_SetAliasConnect : function(connectId, puid, odlIndex, aliasName)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ODL_SetAliasConnect, puid, NPPILY.Enum.PuResourceType.AlertOut, odlIndex, aliasName);
	},
	// - 断开动作别名
	ODL_GetAliasBreak : function(connectId, puid, odlIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ODL_GetAliasBreak, puid, NPPILY.Enum.PuResourceType.AlertOut, odlIndex);
	},
	ODL_SetAliasBreak : function(connectId, puid, odlIndex, aliasName)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ODL_SetAliasBreak, puid, NPPILY.Enum.PuResourceType.AlertOut, odlIndex, aliasName);
	},
	// - 控制报警输出状态
	ODL_SetStatus : function(connectId, puid, odlIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.ODL_SetStatus, puid, NPPILY.Enum.PuResourceType.AlertOut, odlIndex, value);
	},
	
	/* 前端存储配置 */
	// - 录像持续时间
	SG_GetRecordTimeSpan : function(connectId, puid, sgIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_GetRecordTimeSpan, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex);
	},
	SG_SetRecordTimeSpan : function(connectId, puid, sgIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_SetRecordTimeSpan, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, value);
	},
	// - 磁盘状态
	SG_GetDiskStatus : function(connectId, puid, sgIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_GetDiskStatus, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex);
	},
	// - 磁盘空间不足时是否覆盖旧文件
	SG_GetCoverOldRecordFile : function(connectId, puid, sgIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_GetCoverOldRecordFile, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex);
	},
	SG_SetCoverOldRecordFile : function(connectId, puid, sgIndex, bValue)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_SetCoverOldRecordFile, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, bValue);
	},
	// - 磁盘空间不足时的剩余空间门限
	SG_GetDiskInsufficientSpace : function(connectId, puid, sgIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_GetDiskInsufficientSpace, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex);
	},
	SG_SetDiskInsufficientSpace : function(connectId, puid, sgIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_SetDiskInsufficientSpace, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, value);
	},
	// - 录像文件保留天数
	SG_GetRecordFileReserveDays : function(connectId, puid, sgIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_GetRecordFileReserveDays, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex);
	},
	SG_SetRecordFileReserveDays : function(connectId, puid, sgIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_SetRecordFileReserveDays, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, value);
	},
	// - 文件系统类型
	SG_GetFileSystemType : function(connectId, puid, sgIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_GetFileSystemType, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex);
	},
	// - 获取磁盘信息
	SG_GetDiskInfo : function(connectId, puid, sgIndex)
	{
		var operator = NPPILY.Control.CommonGet
		(
		 	connectId,
			{
				puid: puid,
				resType: NPPILY.Enum.PuResourceType.Storager,
				resIdx: sgIndex,
				controlID: "CTL_SG_GetDiskInfo"
			} 
		);
		if (operator.rv == NrcapError.NRCAP_SUCCESS)
		{
			if (operator.response != null && typeof operator.response.Disk == "object")
			{
				var Disk = operator.response.Disk;	
				if (Disk.constructor != Array)
				{
					Disk = [Disk];	
				}
				var dealWith = [];
				for (var i = 0; i < Disk.length; i++) 
				{
					var item = Disk[i];
					dealWith.push
					({
						status: item.Status,
						letter: item.Letter,
						volume_label: item.VolumeLabel,
						type: item.Type,
						file_system: item.FileSystem,
						capacity: item.Capacity,
						used_space: item.UsedSpace,
						usable_space: item.UsableSpace
					});
				}
				operator.response = dealWith;
			}
			else
			{
				operator.response = [];	
			}
		}
		return operator;
	},
	// - 开始初始化文件系统
	SG_StartInitFileSystem : function(connectId, puid, sgIndex, sgDiskLetter)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_StartInitFileSystem, puid, NPPILY.Enum.PuResourceType.Storager, sgDiskLetter);
	},
	// - 查询初始化文件系统进度
	SG_QueryInitFileSystemProgress : function(connectId, puid, sgIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_QueryInitFileSystemProgress, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex);
	},
	// - 手动启动存储
	SG_ManualStart : function(connectId, puid, sgIndex, ivType, ivIndex, ivStreamType, duration)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_ManualStart, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, ivType, ivIndex, ivStreamType, duration);
	},
	// - 手动停止存储
	SG_ManualStop : function(connectId, puid, sgIndex, ivType, ivIndex, ivStreamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_ManualStop, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, ivType, ivIndex, ivStreamType);
	},
	// - 查询CEFS录像或图片
	SG_CEFSQueryFiles : function (connectId, puid, sgIndex, ivIndex, beginTime, endTime, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SG_CEFSQueryFiles, puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, ivIndex, beginTime, endTime, streamType);
	},
	// @huzw 2015.05.04
	// - 查询前端存储日期
	SG_QueryCEFSRecordDate : function (connectId, puid, sgIndex, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, 'SG_QueryCEFSRecordDate', puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, ivIndex);
	},
	// - 查询前端抓图日期
	SG_QueryCEFSSnapshotDate : function (connectId, puid, sgIndex, ivIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, 'SG_QueryCEFSSnapshotDate', puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, ivIndex);
	},
	// - 高级查询前端存储文件
	SG_CEFSQueryFilesEx : function (connectId, puid, sgIndex, ivIndex, intBeginTime, intEndTime, intReason, streamType)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, 'SG_CEFSQueryFilesEx', puid, NPPILY.Enum.PuResourceType.Storager, sgIndex, ivIndex, intBeginTime, intEndTime, intReason, streamType);
	},
	
	/* 平台存储配置 */
	// - 录像时间
	SC_GetRecordTimeSpan : function(connectId, puid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetRecordTimeSpan, puid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	SC_SetRecordTimeSpan : function(connectId, puid, csuIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_SetRecordTimeSpan, puid, NPPILY.Enum.PuResourceType.SC, csuIndex, value);
	},
	// - 磁盘状态
	SC_GetDiskStatus : function(connectId, puid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetDiskStatus, puid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	// - 磁盘满时是否覆盖旧文件
	SC_GetCoverOldRecordFile : function(connectId, puid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetCoverOldRecordFile, puid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	SC_SetCoverOldRecordFile : function(connectId, puid, csuIndex, bValue)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_SetCoverOldRecordFile, puid, NPPILY.Enum.PuResourceType.SC, csuIndex, bValue);
	},
	// - 录像文件保存天数
	SC_GetRecordFileReserveDays : function(connectId, puid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetRecordFileReserveDays, puid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	SC_SetRecordFileReserveDays : function(connectId, puid, csuIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_SetRecordFileReserveDays, puid, NPPILY.Enum.PuResourceType.SC, csuIndex, value);
	},
	// - GPS数据保存天数
	SC_GetGPSReserveDays : function(connectId, puid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetGPSReserveDays, puid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	SC_SetGPSReserveDays : function(connectId, puid, csuIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_SetGPSReserveDays, puid, NPPILY.Enum.PuResourceType.SC, csuIndex, value);
	},
	// - 是否使能GPS存储
	SC_GetEnableGPSDataStorage : function(connectId, puid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetEnableGPSDataStorage, puid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	SC_SetEnableGPSDataStorage : function(connectId, puid, csuIndex, bValue)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_SetEnableGPSDataStorage, puid, NPPILY.Enum.PuResourceType.SC, csuIndex, bValue);
	},
	// - 抓拍文件保存天数
	SC_GetSnapshotReserveDays : function(connectId, puid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetSnapshotReserveDays, puid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	SC_SetSnapshotReserveDays : function(connectId, puid, csuIndex, value)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_SetSnapshotReserveDays, puid, NPPILY.Enum.PuResourceType.SC, csuIndex, value);

	},
	/* 平台存储控制 */
	// - 获取磁盘信息
	SC_GetDiskInfo : function(connectId, csuPuid, csuIndex)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_GetDiskInfo, csuPuid, NPPILY.Enum.PuResourceType.SC, csuIndex);
	},
	// - 手动启动存储
	SC_ManualStart : function(connectId, csuPuid, csuIndex, rec_puid, rec_ivIndex, rec_streamType, rec_reason, rec_duration)
	{
		if (!rec_puid || typeof rec_ivIndex == "undefined")
		{
			NPPUtils.Log("NPPILY.SC_ManualStart", "rec_puid or rec_ivIndex error~");
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
		}
		var rec_ivHandle_operator = NPPILY.NPPSDKCommon.GetHandle
		(
			connectId,
			rec_puid,
			NPPILY.Enum.PuResourceType.VideoIn,
			rec_ivIndex
		);
		if (rec_ivHandle_operator.rv != NrcapError.NRCAP_SUCCESS) 
		{
			NPPUtils.Log("NPPILY.SC_ManualStart", "get rec_ivHandle error~");
			return rec_ivHandle_operator;
		}
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_ManualStart, csuPuid, NPPILY.Enum.PuResourceType.SC, csuIndex, rec_ivHandle_operator.response, rec_streamType, rec_reason, rec_duration);
	},
	// - 手动停止存储
	SC_ManualStop : function(connectId, csuPuid, csuIndex, rec_puid, rec_ivIndex, rec_streamType)
	{
		if (!rec_puid || typeof rec_ivIndex == "undefined")
		{
			NPPUtils.Log("NPPILY.SC_ManualStop", "rec_puid or rec_ivIndex error~");
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
		}
		var rec_ivHandle_operator = NPPILY.NPPSDKCommon.GetHandle
		(
			connectId,
			rec_puid,
			NPPILY.Enum.PuResourceType.VideoIn,
			rec_ivIndex
		);
		if (rec_ivHandle_operator.rv != NrcapError.NRCAP_SUCCESS) 
		{
			NPPUtils.Log("NPPILY.SC_ManualStop", "get rec_ivHandle error~");
			return rec_ivHandle_operator;
		}
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_ManualStop, csuPuid, NPPILY.Enum.PuResourceType.SC, csuIndex, rec_ivHandle_operator.response, rec_streamType);
	},
	// - 查询录像/图片文件
	SC_QueryFiles : function(connectId, csuPuid, csuIndex, rec_puid, rec_ivIndex, rec_beginTime, rec_endTime, rec_streamType, byOffset, byCount)
	{
		if (!rec_puid || typeof rec_ivIndex == "undefined")
		{
			NPPUtils.Log("NPPILY.SC_QueryFiles", "rec_puid or rec_ivIndex error~");
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
		}
		var rec_ivHandle_operator = NPPILY.NPPSDKCommon.GetHandle
		(
			connectId,
			rec_puid,
			NPPILY.Enum.PuResourceType.VideoIn,
			rec_ivIndex
		);
		if (rec_ivHandle_operator.rv != NrcapError.NRCAP_SUCCESS) 
		{
			NPPUtils.Log("NPPILY.SC_QueryFiles", "get rec_ivHandle error~");
			return rec_ivHandle_operator;
		}
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_QueryFiles, csuPuid, NPPILY.Enum.PuResourceType.SC, csuIndex, rec_ivHandle_operator.response, rec_beginTime, rec_endTime, rec_streamType, byOffset, byCount);
	},
	// - 删除录像/图片文件
	SC_DelFiles : function(connectId, csuPuid, csuIndex, fileListArray)
	{
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_DelFiles, csuPuid, NPPILY.Enum.PuResourceType.SC, csuIndex, fileListArray);
	},
	// - 查询历史GPS数据
	SC_QueryGPSData : function(connectId, csuPuid, csuIndex, rec_puid, rec_gpsIndex, rec_beginTime, rec_endTime, byOffset, byCount)
	{
		if (!rec_puid || typeof rec_gpsIndex == "undefined")
		{
			NPPUtils.Log("NPPILY.SC_QueryGPSData", "rec_puid or rec_ivIndex error~");
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
		}
		var rec_gpsHandle_operator = NPPILY.NPPSDKCommon.GetHandle
		(
			connectId,
			rec_puid,
			NPPILY.Enum.PuResourceType.GPS,
			rec_gpsIndex
		);
		if (rec_gpsHandle_operator.rv != NrcapError.NRCAP_SUCCESS) 
		{
			NPPUtils.Log("NPPILY.SC_QueryGPSData", "get rec_gpsHandle error~");
			return rec_gpsHandle_operator;
		}
		return NPPILY.NPPSDKCommon.GetNCResponse(connectId, NPPILY.Enum.NCObjectMethodList.SC_QueryGPSData, csuPuid, NPPILY.Enum.PuResourceType.SC, csuIndex, rec_gpsHandle_operator.response, rec_beginTime, rec_endTime, byOffset, byCount);
	},
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: 获取发送接收总流量 2015.02.06
    * ........................................................................................................
    **/
	// 接收
	GetCurStreamsTotalBytes : function ()
	{
		try
		{
			var fn = "NPPILY.GetCurStreamsTotalBytes";
			
			var recv = 0;
			var send = 0;
			
			if (NPPILY.Plug.nc != null) {
				var recv_operator = NPPIF.GetCurStreamsTotalRecvBytes(NPPILY.Plug.nc);
				if (recv_operator.rv == NrcapError.NRCAP_SUCCESS) {
					recv = Number(recv_operator.response);
				}
				var send_operator = NPPIF.GetCurStreamsTotalSendBytes(NPPILY.Plug.nc);
				if (send_operator.rv == NrcapError.NRCAP_SUCCESS) {
					send = Number(send_operator.response);
				}
			}
			
			NPPUtils.Log(fn, "Current streams total: recv -> " + recv + ", send -> " + send);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS, {
				receive: recv || 0,
				send: send || 0
			});
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error -> " + e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: 获取发送接收总流量 2015.02.06
    * ........................................................................................................
    **/
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: 外接存储查询下载接口 2014.05.29
    * ........................................................................................................
    **/
	// 记录下载信息
	__Sdk_RecordQR_CopyStore : new NPPUtils.Hash(),
	// 清空下载等信息
	RecordQR_Clear : function ()
	{
		try
		{
			var fn = "NPPILY.RecordQR_Clear";
			
			if (NPPILY.__Sdk_RecordQR_CopyStore)
			{
				NPPILY.__Sdk_RecordQR_CopyStore.each(function (item) {
					var node = item.value;
					if (node.active && node.localFilePath)
					{
						NPPIF.RecordQR_CancelCopy(NPPILY.Plug.nc, node.localFilePath);
					}
					node.active = false;
				});
				
				NPPILY.__Sdk_RecordQR_CopyStore.clear();
			}
			
			// 清理模块
			NPPILY.RecordQR_Cleanup();
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error -> " + e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	// 加载模块，与RecordQR_Cleanup互斥调用，不能只重复调用某个接口
	RecordQR_Startup : function ()
	{
		try
		{
			var fn = "NPPILY.RecordQR_Startup";
			
			if (NPPILY.Plug.nc)
			{
				NPPILY.Plug.nc["NPP_RecordQR_Startupped"] = NPPILY.Plug.nc["NPP_RecordQR_Startupped"] || false;
				if (NPPILY.Plug.nc["NPP_RecordQR_Startupped"])
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				var operator = NPPIF.RecordQR_Startup(NPPILY.Plug.nc);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					NPPILY.Plug.nc["NPP_RecordQR_Startupped"] = true;	
				}
				else
				{
					NPPUtils.Log(fn, "nc RecordQR_Startupp failed~");
				}
				return operator;
			}
			else
			{
				NPPUtils.Log(fn, "nc undefined error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_LOADPLUG_NC);
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	// 清理模块
	RecordQR_Cleanup : function ()
	{
		try
		{
			var fn = "NPPILY.RecordQR_Cleanup";
			
			if (NPPILY.Plug.nc)
			{
				NPPILY.Plug.nc["NPP_RecordQR_Startupped"] = NPPILY.Plug.nc["NPP_RecordQR_Startupped"] || false;
				if (!NPPILY.Plug.nc["NPP_RecordQR_Startupped"])
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
				}
				var operator = NPPIF.RecordQR_Cleanup(NPPILY.Plug.nc);
				if (operator.rv == NrcapError.NRCAP_SUCCESS)
				{
					NPPILY.Plug.nc["NPP_RecordQR_Startupped"] = false;	
				}
				else
				{
					NPPUtils.Log(fn, "nc RecordQR_Startupp failed~");
				}
				return operator;
			}
			else
			{
				NPPUtils.Log(fn, "nc undefined error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_LOADPLUG_NC);
			}
		}
		catch (e)
		{
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn : RecordQR_GetDeviceInfo
	desc : 获得设备信息
	returns :
		- 比如{"rv":0,"response":{"mac":"000F7C0B08A3","puid":"","tz":"GMT-08:00","name":"000F7C0B08A3","video_name":{"0":"Camera0", "1":"Camera1" ... }}} 
		- 注意：video_name节点下可以有多个子节点，以字符串型数字为属性名，如"0"表示第1个摄像点索引，如下面相关函数的videoIndex
	...
	*/
	RecordQR_GetDeviceInfo : function ()
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_GetDeviceInfo(NPPILY.Plug.nc);
	},
	/*
	---
	fn : RecordQR_QueryRecordDate
	desc : 查询录像日期
	returns :
		- 比如{"rv":0,"response":["1397145600"]}
		- 注意：1397145600为某天时刻点，可以看成bUTCTime进行后续查询
	...
	*/
	RecordQR_QueryRecordDate : function (videoIndex, offset, count)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_QueryRecordDate(NPPILY.Plug.nc, videoIndex, (offset||0), (count==0?0:(count||1000)));
	},
	/*
	---
	fn : RecordQR_QueryRecordFiles
	desc : 查询录像文件
	returns :
		- 比如{"rv":0,"response":[{"name":"20140411165530_0140.avi","path":"B:\\0000\\","size":"35960320","begin_time":"1397206530","end_time":"1397206850","reason":["Schedule"]}]}
	...
	*/
	RecordQR_QueryRecordFiles : function (videoIndex, offset, count, bUTCTime, eUTCTime)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_QueryRecordFiles(NPPILY.Plug.nc, videoIndex, (offset||0), (count==0?0:(count||1000)), (bUTCTime||0), (eUTCTime||0));
	},
	// 查询抓拍日期
	RecordQR_QuerySnapshotDate : function (videoIndex, offset, count)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_QuerySnapshotDate(NPPILY.Plug.nc, videoIndex, (offset||0), (count==0?0:(count||1000)));
	},
	// 查询抓拍文件
	RecordQR_QuerySnapshotFiles : function (videoIndex, offset, count, bUTCTime, eUTCTime)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_QuerySnapshotFiles(NPPILY.Plug.nc, videoIndex, (offset||0), (count==0?0:(count||1000)), (bUTCTime||0), (eUTCTime||0));
	},
	// 查询事件
	RecordQR_QueryEvent : function (offset, count, bUTCTime, eUTCTime)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_QueryEvent(NPPILY.Plug.nc, (offset||0), (count==0?0:(count||1000)), (bUTCTime||0), (eUTCTime||0));
	},
	// 查询定位数据
	RecordQR_QueryGnssData : function (offset, count, bUTCTime, eUTCTime)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_QueryGnssData(NPPILY.Plug.nc, (offset||0), (count==0?0:(count||1000)), (bUTCTime||0), (eUTCTime||0));
	},
	// 查询串口数据
	RecordQR_QuerySPData : function (offset, count, bUTCTime, eUTCTime)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		return NPPIF.RecordQR_QuerySPData(NPPILY.Plug.nc, (offset||0), (count==0?0:(count||1000)), (bUTCTime||0), (eUTCTime||0));
	},
	// 下载抓拍文件
	RecordQR_CopySnapshot : function (remoteFilePath, localFilePath)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		var node = NPPILY.__Sdk_RecordQR_CopyStore.get(localFilePath) || {};
		if (node && node.active)
		{
			// 先停止后重新下载
			NPPIF.RecordQR_CancelCopy(NPPILY.Plug.nc, localFilePath);
		}
		var operator = NPPIF.RecordQR_CopySnapshot(NPPILY.Plug.nc, remoteFilePath, localFilePath);
		if(operator.rv == NrcapError.NRCAP_SUCCESS)
		{
			NPPILY.__Sdk_RecordQR_CopyStore.set
			(
				localFilePath,
				{
					active : true,
					copyType : "IMAGE",
					remoteFilePath : remoteFilePath,
					localFilePath : localFilePath
				}
			);
		}
		return operator;
	},
	// 下载录像文件
	RecordQR_CopyRecord : function (remoteFilePath, localFilePath)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		var node = NPPILY.__Sdk_RecordQR_CopyStore.get(localFilePath) || {};
		if (node && node.active)
		{
			// 先停止后重新下载
			NPPIF.RecordQR_CancelCopy(NPPILY.Plug.nc, localFilePath);
		}
		var operator = NPPIF.RecordQR_CopyRecord(NPPILY.Plug.nc, remoteFilePath, localFilePath);
		if(operator.rv == NrcapError.NRCAP_SUCCESS)
		{
			NPPILY.__Sdk_RecordQR_CopyStore.set
			(
				localFilePath,
				{
					active : true,
					copyType : "VOD",
					remoteFilePath : remoteFilePath,
					localFilePath : localFilePath
				}
			);
		}
		return operator;
	},
	// 取消下载
	RecordQR_CancelCopy : function (localFilePath)
	{
		if (!NPPILY.Plug.nc || NPPILY.Plug.nc["NPP_RecordQR_Startupped"] != true)
		{
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_RECORDQR_STARTUP_FAILED);
		}
		var operator = NPPIF.RecordQR_CancelCopy(NPPILY.Plug.nc, localFilePath);
		if(operator.rv == NrcapError.NRCAP_SUCCESS)
		{
			NPPILY.__Sdk_RecordQR_CopyStore.each(function (item) {
				if (item.key == localFilePath)
				{
					item.value.active = false;
					return true;
				}
			});
		}
		return operator;
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: 外接存储查询下载接口 2014.05.29
    * ........................................................................................................
    **/
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: 会议室功能接口 2014.12.25
    * ........................................................................................................
    **/
	/*
	---
	fn: CreateMeetingRoom
	desc: 创建会议室
	author: huzw
	params:
		- connectId 连接ID
		- szName 会议室名称
		- szPassword 会议室密码
	returns:
		- operator of NPPILY.Struct.ReturnValue
		operator.response为会议室流句柄（唯一标识）
	...
	*/
	CreateMeetingRoom : function (connectId, szName, szPassword)
	{
		try
		{
			var fn = "NPPILY.CreateMeetingRoom";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			if (!szName)
			{
				NPPUtils.Log(fn, "szName error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			var szPassword = szPassword || "";
			
			var cs = NPPILY.Connections.get(connectId);
			
			return NPPIF.CreateMeetingRoom(cs.nc, cs.session, szName, szPassword);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: CloseOrExitMeetingRoom
	desc: 关闭或退出会议室
	author: huzw
	params:
		- connectId 连接ID
		- streamHandle 会议室流句柄（唯一标识）
	returns:
		- operator of NPPILY.Struct.ReturnValue
	...
	*/
	CloseOrExitMeetingRoom : function (connectId, streamHandle)
	{
		try
		{
			var fn = "NPPILY.CloseOrExitMeetingRoom";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			
			var cs = NPPILY.Connections.get(connectId);
			return NPPIF.StopStreamPlay(cs.nc, streamHandle);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: QueryAllMeetingRoomInfo
	desc: 查询所有会议室信息
	author: huzw
	params:
		- connectId 连接ID
		- count 会议室数
	returns:
		- operator of NPPILY.Struct.ReturnValue
	...
	*/
	QueryAllMeetingRoomInfo: function (connectId, count)
	{
		try
		{
			var fn = "NPPILY.QueryAllMeetingRoomInfo";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			
			var cs = NPPILY.Connections.get(connectId);
			var operator = NPPIF.QueryAllMeetingRoomInfo(cs.nc, cs.session, typeof count != "undefined" && !isNaN(count) ? count : 1024);
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				if (typeof operator.response == "object")
				{
					if (typeof operator.response == "undefined" || !operator.response)
					{
						operator.response = [];
					}
					if (operator.response.constructor != Array)
					{
						operator.response = [operator.response];
					}
					for(var i = 0; i < operator.response.length; i++)
					{
						var item = operator.response[i];
						item.MeetingRoomName = NPPUtils.UTF8toUnicode(item.MeetingRoomName);
					}
				}
			}
			return operator;
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: GetOnlineUsers
	desc: 获取在线用户
	author: huzw
	params:
		- connectId 连接ID
		- count 查询条数
	returns:
		- operator of NPPILY.Struct.ReturnValue
	...
	*/
	GetOnlineUsers: function (connectId, count)
	{
		try
		{
			var fn = "NPPILY.GetOnlineUsers";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			
			var cs = NPPILY.Connections.get(connectId);
			return NPPIF.GetOnlineUsers(cs.nc, cs.session, typeof count != "undefined" && !isNaN(count) ? count : 1024);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: AddPUMeetingRoom
	desc: 添加一个设备入会议室
	author: huzw
	params:
		- connectId 连接ID
		- hStreamHandle 会议室的句柄
		- puid 设备PUID
	returns:
		- operator of NPPILY.Struct.ReturnValue
	...
	*/
	AddPUMeetingRoom: function (connectId, hStreamHandle, puid)
	{
		try
		{
			var fn = "NPPILY.AddPUMeetingRoom";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			
			var cs = NPPILY.Connections.get(connectId);
			return NPPIF.AddPUMeetingRoom(cs.nc, cs.session, hStreamHandle, puid);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: KickOutMemberPU
	desc: 从会议室中删除一个设备
	author: huzw
	params:
		- connectId 连接ID
		- hStreamHandle 会议室流句柄
		- puid 设备PUID
	returns:
		- operator of NPPILY.Struct.ReturnValue
	...
	*/
	KickOutMemberPU: function (connectId, hStreamHandle, puid)
	{
		try
		{
			var fn = "NPPILY.KickOutMemberPU";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			if (!hStreamHandle)
			{
				NPPUtils.Log(fn, "hStreamHandle error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			if (!puid)
			{
				NPPUtils.Log(fn, "puid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			
			var cs = NPPILY.Connections.get(connectId);
			return NPPIF.KickOutMemberPU(cs.nc, cs.session, hStreamHandle, puid);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: KickOutMemberCU
	desc: 从会议室中删除一个用户
	author: huzw
	params:
		- connectId 连接ID
		- hStreamHandle 会议室流句柄
		- szCUID 用户连接CUID
	returns:
		- operator of NPPILY.Struct.ReturnValue
	...
	*/
	KickOutMemberCU: function (connectId, hStreamHandle, szCUID)
	{
		try
		{
			var fn = "NPPILY.KickOutMemberCU";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			if (!hStreamHandle)
			{
				NPPUtils.Log(fn, "hStreamHandle error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			if (!szCUID)
			{
				NPPUtils.Log(fn, "szCUID error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			
			var cs = NPPILY.Connections.get(connectId);
			return NPPIF.KickOutMemberCU(cs.nc, cs.session, hStreamHandle, szCUID);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: ModifyMeetingRoomPassword
	desc: 修改会议室密码
	author: huzw
	params:
		- connectId 连接ID
		- szID 会议室ID
		- new_szPassword 会议室新的密码
	returns:
		- operator of NPPILY.Struct.ReturnValue
	...
	*/
	ModifyMeetingRoomPassword: function (connectId, szID, new_szPassword)
	{
		try
		{
			var fn = "NPPILY.ModifyMeetingRoomPassword";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			
			if (!szID)
			{
				NPPUtils.Log(fn, "szID error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			var new_szPassword = new_szPassword || "";
			
			var cs = NPPILY.Connections.get(connectId);
			return NPPIF.ModifyMeetingRoomPassword(cs.nc, cs.session, szID, new_szPassword);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: JoinMeetingRoom
	desc: 申请加入会议室
	author: huzw
	params:
		- connectId 连接ID
		- szID 会议室ID
		- szPassword 会议室密码
	returns:
		- operator of NPPILY.Struct.ReturnValue
		operator.response为加入会议室分配的流句柄（唯一标识）
	...
	*/
	JoinMeetingRoom: function (connectId, szID, szPassword)
	{
		try
		{
			var fn = "NPPILY.JoinMeetingRoom";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);	
			}
			
			if (!szID)
			{
				NPPUtils.Log(fn, "szID error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			var szPassword = szPassword || "";
			
			var cs = NPPILY.Connections.get(connectId);
			return NPPIF.JoinMeetingRoom(cs.nc, cs.session, szID, szPassword);
		}
		catch (e)
		{
			NPPUtils.Log(fn, e.name + "::" + e.message);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: 会议室功能接口 2014.12.25
    * ........................................................................................................
    **/
    /*
    ---
    fn: QueryCSUFiles 
    desc: 查询中心存储文件
    author:
        - huzw  
    time: 2013.10.29
	returns:
		- succ <Response: Array(NPPILY.Struct.SCIVDateFileStruct)>
	params:
		- connectId(string) * 连接ID
		- queryConditions(Object) * 查询条件
			=> {
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，缺省为0

				puid(string) * 查询对象（设备）PUID
				ivIndex(uint) 查询对象（摄像头）资源索引，缺省为0
				objSets(Object|Array) 若干查询对象列表，在queryConditions.puid存在情况下，此节点无效
				beginTime(UTC time) 查询开始时间（UTC秒，如1385380100），缺省为0
				endTime(UTC time) 查询结束时间（UTC秒，如1385380100），缺省为当前时间
				offset(uint) 查询开始索引，缺省从0开始
				count(uint) 查询条数，缺省为200
				streamType(NPPILY.Enum.NrcapStreamType) 限定查询存储的流类型，多个流类型之间使用英文竖线（|）分割，如（REALTIME|STORAGE），查图片使用PICTURE，缺省为STORAGE查录像
				reason(string) 存储原因，多个原因之间使用英文竖线（|）分割，如（Manual|Plan），缺省为空字符串将查询所有符合条件录像
				logicMode(string) 查询逻辑（AND与，OR或），缺省OR
				domainRoad(string) 子域平台名（缺省空字符串，代表根平台）
			}
	remark:
		- queryConditions.objSets
			-> 单个查询对象 如 = {puid: "151...", ivIndex: "0"}	 
     		-> 多个查询数组 如 = [{puid: "151...", ivIndex: "0"}, {puid: "151...", ivIndex: "0"}, ...]	
    ... 
    */
	QueryCSUFiles : function (connectId, queryConditions)
	{
		try
		{
			var fn = "NPPILY.QueryCSUFiles";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			var _connStruct = NPPILY.Connections.get(connectId);
			if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
			{ 
				NPPUtils.Log(fn, "login or session error~");
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
				}
				else
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
				}
			}
			
			var querys = queryConditions || {};
			if (!querys || !querys.csuPuid)
			{
				NPPUtils.Log(fn, "csuPuid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);
			}
			querys.csuIndex = typeof querys.csuIndex != "undefined" || !isNaN(querys.csuIndex) ? querys.csuIndex : 0;
			
			var xmlObjRes = '';
			if (typeof querys.puid != "undefined")
			{
				querys.ivIndex = typeof querys.ivIndex != "undefined" || !isNaN(querys.ivIndex) ? querys.ivIndex : 0;
				
				xmlObjRes = '<Res ObjType="151" ObjID="'+querys.puid+'" Type="'+NPPILY.Enum.PuResourceType.VideoIn+'" Idx="'+querys.ivIndex+'"></Res>';
			}
			else
			{
				if (typeof querys.objSets == "object")
				{
					if (querys.objSets.constructor != Array)
					{
						querys.objSets = [querys.objSets];	
					}
					
					for (var i = 0; i < querys.objSets.length; i++)
					{
						var r = querys.objSets[i];
						if (r && r.puid)
						{
							xmlObjRes += '<Res ObjType="151" ObjID="'+r.puid+'" Type="'+NPPILY.Enum.PuResourceType.VideoIn+'" Idx="'+r.ivIndex+'"></Res>';
						}
					}
				}
			}
			
			if (!xmlObjRes)
			{
               	NPPUtils.Log(fn, "xmlObjRes error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
            }
			
			querys.beginTime = typeof querys.beginTime != "undefined" || !isNaN(querys.beginTime) ? querys.beginTime : 0;
			querys.endTime = typeof querys.endTime != "undefined" || !isNaN(querys.endTime) ? querys.endTime : Math.ceil(new Date().getTime() / 1000);
			querys.offset = typeof querys.offset != "undefined" || !isNaN(querys.offset) ? querys.offset : 0;
			querys.count = typeof querys.count != "undefined" || !isNaN(querys.count) ? querys.count : 200;
			querys.streamType = querys.streamType || NPPILY.Enum.NrcapStreamType.STORAGE;
			querys.logicMode = querys.logicMode != "AND" ? "OR" : "AND";
			
			var xmlReason = "";
			var reasons = typeof querys.reason != "undefined" ? querys.reason.split("|") : "";
			if (typeof reasons == "object")
			{
				if (reasons.constructor != Array)
				{
					reasons = [reasons];	
				}
				for (var j = 0; j < reasons.length; j++)
				{
					xmlReason += "<Reason>" + reasons[j] + "</Reason>";
				}
			}
			xmlReason = xmlReason || "<Reason></Reason>";
			
			var optID = "CTL_SC_QueryFiles";
			
			var operator = NPPILY.CommonRequest
			(
				connectId, 
				{
					cmdType : NPPILY.Enum.CmdType.CTL,
					puid : querys.csuPuid,
					domainRoad : querys.domainRoad || '',
					xmlDstRes : '<DstRes Type="'+NPPILY.Enum.PuResourceType.SC+'" Idx="'+querys.csuIndex+'" OptID="'+optID+'"><Param Offset="'+querys.offset+'" Cnt="'+querys.count+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'" StreamType="'+querys.streamType+'" LogicMode="'+querys.logicMode+'">'+xmlReason+'</Param></DstRes>',
					xmlObjSets : (xmlObjRes ? ('<ObjSets>' + xmlObjRes + '</ObjSets>') : ''),
					returnType : "json"
				}
			);
			
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				var _fileListArray = new Array();
				
				var _response = operator.response || {};
				if (typeof _response == "object" && typeof _response.Res == "object")
				{
					if (_response.Res.constructor != Array)
					{
						_response.Res = [_response.Res];	
					}
					
					for (var k = 0; k < _response.Res.length; k++)
					{
						var _res = _response.Res[k],
							_puid = _res.ObjID,
							_type = _res.Type,
							_idx = _res.Idx;
						
						if (typeof _res.File == "object")
						{
							if (_res.File.constructor != Array)
							{
								_res.File = [_res.File]; 
							}
							for (var m = 0; m < _res.File.length; m++)
							{
								var _file = _res.File[m];
								
								_fileListArray.push
								(
								 	new NPPILY.Struct.SCIVDateFileStruct
									(
										_file.Name,
										_file.Path,
										_file.Size,
										_file.BeginTime,
										_file.EndTime,
										_file.Reason,
										querys.csuPuid,
										querys.csuIndex,
										_puid,
										_type,
										_idx
									)
								);
							}
						}
					}
				}
				
				operator.response = _fileListArray || [];
			}
			
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: RemoveCSUFiles
	desc: 删除存储文件
	author: 
		- huzw
	time: 2013.11.29
	params:
		- connectId(string) 连接ID
		- options(object) 可选参数
		{
			csuPuid(string) * 中心存储器PUID
			csuIndex(uint) 中心存储单元资源索引
			fileSets(object|array) * 平台录像或图片文件集合	
		}
	remark:
		- 单个文件可以options.fileSets = {fileName: ?, filePath: ?} 或 [{fileName: ?, filePath: ?}]
		- 多个文件集合options.fileSets = [{fileName: ?, filePath: ?}, {fileName: ?, filePath: ?}, ...]
		注意fileName和filePath为查询出来的文件名和文件所处目录
	...
	*/
	RemoveCSUFiles : function (connectId, options)
	{
		try
		{
			var fn = "NPPILY.RemoveCSUFiles";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			var _connStruct = NPPILY.Connections.get(connectId);
			if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
			{ 
				NPPUtils.Log(fn, "login or session error~");
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
				}
				else
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
				}
			}
			
			var o = options = options || {};
			if (!o.csuPuid || !NPPILY.puidRex.test(o.csuPuid))
			{
				NPPUtils.Log(fn, "csuPuid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);
			}
			o.csuIndex = typeof o.csuIndex != "undefined" || !isNaN(o.csuIndex) ? o.csuIndex : 0;
			
			o.fileSets = o.fileSets || [];
			
			if (o.fileSets != null && typeof o.fileSets == "object")
			{
				if (o.fileSets.constructor != Array)
				{
					o.fileSets = [o.fileSets];	
				}
				
				var xmlFiles = "";
				for (var i = 0; i < o.fileSets.length; i++)
				{
					var file = o.fileSets[i];
					if (typeof file.fileName != "undefined" && typeof file.filePath != "undefined")
					{
						xmlFiles += '<File Name="'+file.fileName+'" Path="'+file.filePath+'" />';
					}
				}
				
				var operator = NPPILY.Control.CommonSet
				(
					connectId,
					{
						puid: o.csuPuid,
						resType: NPPILY.Enum.PuResourcType.SC,
						resIdx: o.csuIndex,
						controlID: "CTL_SC_DelFile",
						param: '<Param>' + xmlFiles + '</Param>',
						domainRoad: o.domainRoad || ""
					}
				);
				
				return operator;
			}
			 
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	/*
    ---
    fn: FetchCSUIVDate 
    desc: 获取平台存储下有存储文件的日期
    author:
        - huzw  
    time: 2013.10.29
	returns:
		- succ <Response: Array(UTC timestamp)>
	params:
		- connectId(string) * 连接ID
		- queryConditions(Object) * 查询条件
			=> {
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，缺省为0
				puid(string) * 查询对象（设备）PUID
				ivIndex(uint) 查询对象（摄像头）资源索引，缺省为0
				offset(uint) 查询开始索引，缺省从0开始
				count(uint) 查询条数，缺省为200
				streamType(NPPILY.Enum.NrcapStreamType) 限定查询存储的流类型，多个流类型之间使用英文竖线（|）分割，如（REALTIME|STORAGE），查图片使用PICTURE，缺省为STORAGE查录像
				domainRoad(string) 子域平台名（缺省空字符串，代表根平台）
			}
    ... 
    */
	FetchCSUIVDate : function (connectId, queryConditions)
	{
		try
		{
			var fn = "NPPILY.FetchCSUIVDate";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			var _connStruct = NPPILY.Connections.get(connectId);
			if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
			{ 
				NPPUtils.Log(fn, "login or session error~");
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
				}
				else
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
				}
			}
			
			var querys = queryConditions || {};
			if (!querys || !querys.csuPuid)
			{
				NPPUtils.Log(fn, "querys.csuPuid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);
			}
			querys.csuIndex = typeof querys.csuIndex != "undefined" || !isNaN(querys.csuIndex) ? querys.csuIndex : 0;
			
			var xmlObjRes = '';
			if (typeof querys.puid != "undefined")
			{
				querys.ivIndex = typeof querys.ivIndex != "undefined" || !isNaN(querys.ivIndex) ? querys.ivIndex : 0;
				
				xmlObjRes = '<Res ObjType="151" ObjID="'+querys.puid+'" Type="'+NPPILY.Enum.PuResourceType.VideoIn+'" Idx="'+querys.ivIndex+'"></Res>';
			}
			else
			{
				NPPUtils.Log(fn, "querys.puid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
			}
			
			if (!xmlObjRes)
			{
               	NPPUtils.Log(fn, "xmlObjRes error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
            }
			
			querys.offset = typeof querys.offset != "undefined" || !isNaN(querys.offset) ? querys.offset : 0;
			querys.count = typeof querys.count != "undefined" || !isNaN(querys.count) ? querys.count : 200;
			querys.streamType = querys.streamType || NPPILY.Enum.NrcapStreamType.STORAGE;
			
			var optID = "CTL_SC_QueryIVDate";
			
			var operator = NPPILY.CommonRequest
			(
				connectId, 
				{
					cmdType : NPPILY.Enum.CmdType.CTL,
					puid : querys.csuPuid,
					domainRoad : querys.domainRoad || '',
					xmlDstRes : '<DstRes Type="'+NPPILY.Enum.PuResourceType.SC+'" Idx="'+querys.csuIndex+'" OptID="'+optID+'"><Param Offset="'+querys.offset+'" Cnt="'+querys.count+'" StreamType="'+querys.streamType+'"></Param></DstRes>',
					xmlObjSets : '<ObjSets>' + xmlObjRes + '</ObjSets>',
					returnType : "json"
				}
			);
			
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				var _dateArray = new Array();
				
				var _response = operator.response || {};
				if (typeof _response == "object" && typeof _response.Res == "object")
				{
					if (typeof _response.Res.Date == "object" && _response.Res.Date.constructor == Array)
					{
						for (var i = 0; i < _response.Res.Date.length; i++)
						{
							_dateArray.push(_response.Res.Date[i]);	
						}
 					}
					else
					{
						_dateArray.push(_response.Res.Date);		
					}
				}
				
				operator.response = _dateArray || [];
			}
			
			return operator;			
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
    ---
    fn: FetchCSUIVDateFiles 
    desc: 按日期获取视频的平台存储文件
    author:
        - huzw  
    time: 2013.10.29
	returns:
		- succ <Response: Array(NPPILY.Struct.SCIVDateFileStruct)>
	params:
		- connectId(string) * 连接ID
		- queryConditions(Object) * 查询条件
			=> {
				csuPuid(string) * 中心存储器PUID
				csuIndex(uint) 中心存储单元资源索引，缺省为0
				puid(string) * 查询对象（设备）PUID
				ivIndex(uint) 查询对象（摄像头）资源索引，缺省为0
				datetime(UTC timestamp) * 以UTC时间（如1385380100）查询，必选，应该为通过NPPILY.FetchCSUIVDate获取到的UTC日期时间
				offset(uint) 查询开始索引，缺省从0开始
				count(uint) 查询条数，缺省为200
				streamType(NPPILY.Enum.NrcapStreamType) 限定查询存储的流类型，多个流类型之间使用英文竖线（|）分割，如（REALTIME|STORAGE），查图片使用PICTURE，缺省为STORAGE查录像
				domainRoad(string) 子域平台名（缺省空字符串，代表根平台）
			}
    ... 
    */
	FetchCSUIVDateFiles : function (connectId, queryConditions)
	{
		try
		{
			var fn = "NPPILY.FetchCSUIVDateFiles";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			var _connStruct = NPPILY.Connections.get(connectId);
			if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
			{ 
				NPPUtils.Log(fn, "login or session error~");
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
				}
				else
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
				}
			}
			
			var querys = queryConditions || {};
			if (!querys || !querys.csuPuid)
			{
				NPPUtils.Log(fn, "querys.csuPuid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CSU_PUID_ERROR);
			}
			querys.csuIndex = typeof querys.csuIndex != "undefined" || !isNaN(querys.csuIndex) ? querys.csuIndex : 0;
			
			var xmlObjRes = '';
			if (typeof querys.puid != "undefined")
			{
				querys.ivIndex = typeof querys.ivIndex != "undefined" || !isNaN(querys.ivIndex) ? querys.ivIndex : 0;
				
				xmlObjRes = '<Res ObjType="151" ObjID="'+querys.puid+'" Type="'+NPPILY.Enum.PuResourceType.VideoIn+'" Idx="'+querys.ivIndex+'"></Res>';
			}
			else
			{
				NPPUtils.Log(fn, "querys.puid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR);
			}
			
			if (!xmlObjRes)
			{
               	NPPUtils.Log(fn, "xmlObjRes error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
            }
			if (typeof querys.datetime == "undefined" || isNaN(querys.datetime) || querys.datetime == null)
			{
				NPPUtils.Log(fn, " querys.datetime error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);	
			}
			
			querys.offset = typeof querys.offset != "undefined" || !isNaN(querys.offset) ? querys.offset : 0;
			querys.count = typeof querys.count != "undefined" || !isNaN(querys.count) ? querys.count : 200;
			querys.streamType = querys.streamType || NPPILY.Enum.NrcapStreamType.STORAGE;
			
			var optID = "CTL_SC_QueryIVDateFiles";
			
			var operator = NPPILY.CommonRequest
			(
				connectId, 
				{
					cmdType : NPPILY.Enum.CmdType.CTL,
					puid : querys.csuPuid,
					domainRoad : querys.domainRoad || '',
					xmlDstRes : '<DstRes Type="'+NPPILY.Enum.PuResourceType.SC+'" Idx="'+querys.csuIndex+'" OptID="'+optID+'"><Param Offset="'+querys.offset+'" Cnt="'+querys.count+'" StreamType="'+querys.streamType+'" Date="'+querys.datetime+'"></Param></DstRes>',
					xmlObjSets : '<ObjSets>' + xmlObjRes + '</ObjSets>',
					returnType : "json"
				}
			);
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				var _fileListArray = new Array();
				
				var _response = operator.response || {};
				if (typeof _response == "object" && typeof _response.Res == "object")
				{
					if (_response.Res.constructor != Array)
					{
						_response.Res = [_response.Res];	
					}
					
					for (var k = 0; k < _response.Res.length; k++)
					{
						var _res = _response.Res[k],
							_puid = _res.ObjID,
							_type = _res.Type,
							_idx = _res.Idx;
						
						if (typeof _res.File == "object")
						{
							if (_res.File.constructor != Array)
							{
								_res.File = [_res.File]; 
							}
							for (var m = 0; m < _res.File.length; m++)
							{
								var _file = _res.File[m];
								
								_fileListArray.push
								(
								 	new NPPILY.Struct.SCIVDateFileStruct
									(
										_file.Name,
										_file.Path,
										_file.Size,
										_file.BeginTime,
										_file.EndTime,
										_file.Reason,
										querys.csuPuid,
										querys.csuIndex,
										_puid,
										_type,
										_idx
									)
								);
							}
						}
					}
				}
				
				operator.response = _fileListArray || [];
			}
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	
	/*
    ---
    fn: FetchCEFSDate 
    desc: CEFS查询有存储文件的日期
    author:
        - huzw  
    time: 2013.11.07
	returns:
		- succ <Response: Array(UTC timstamp)>
	params:
		- connectId(string) * 连接ID
		- queryConditions(Object) * 查询条件
		{
			puid(string) * 查询对象设备PUID
			requestID(NPPILY.Enum.CEFSRequestID) * 请求命令
			sgIndex(uint) 前端存储器资源索引，一般为0（缺省）
			diskLetter(string) 查询磁盘的盘符，缺省为空字符串
			channelSets(Uint|Array) 查询通道号，从0开始，依次表示第一路...视频，缺省为0，多个通道号使用数组，如new Array(0, 1, ..)
		}
	remark:
		- queryConditions.channelSets 单个数值，如0或[0]
			requestID = NPPILY.Enum.CEFSRequestID.QueryRecordDate | QueryPictureDate
		- queryConditions.channelSets不传
			requestID = NPPILY.Enum.CEFSRequestID.QueryUserLogDate  
		- queryConditions.channelSets 单个数值或数组，如0或[0, 1, 2, ...]
			requestID = NPPILY.Enum.CEFSRequestID.QueryAlarmEventDate 
	...
	*/
	FetchCEFSDate : function (connectId, queryConditions)
	{
		try
		{
			var fn = "NPPILY.FetchCEFSDate";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			var _connStruct = NPPILY.Connections.get(connectId);
			if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
			{ 
				NPPUtils.Log(fn, "login or session error~");
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
				}
				else
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
				}
			}
			
			var querys = queryConditions || {};
			
			if (!querys.puid || !NPPILY.puidRex.test(querys.puid))
			{
				NPPUtils.Log(fn, "querys.puid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 	
			}
			
			querys.diskLetter = querys.diskLetter || "";
			querys.channelSets = typeof querys.channelSets != "undefined" ? querys.channelSets : [0];
			
			if (querys.channelSets.constructor != Array)
			{
				querys.channelSets = [querys.channelSets];	
			}
			
			var xmlRequest = "",
				sgType = NPPILY.Enum.PuResourceType.Storager,
				sgIndex = querys.sgIndex = typeof querys.sgIndex != "undefined" && !isNaN(querys.sgIndex) ? querys.sgIndex : 0;
			
			switch (querys.requestID)
			{
				case NPPILY.Enum.CEFSRequestID.QueryRecordDate :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" Channel="'+querys.channelSets[0]+'" />';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryPictureDate :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" Channel="'+querys.channelSets[0]+'" />';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryUserLogDate :
				case NPPILY.Enum.CEFSRequestID.QueryGPSDataDate :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" />';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryAlarmEventDate :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'"><Channels>';
					for (var i = 0; i < querys.channelSets.length; i++)
					{
						if (typeof querys.channelSets[i] != "undefined" && !isNaN(querys.channelSets[i]))
						{
							xmlRequest += '<Channel>'+querys.channelSets[i]+'</Channel>';
						}	
					}
					xmlRequest += '</Channels></Request>';
					break;
				default:
					NPPUtils.Log(fn, "querys.requestID undefined+ error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					break;
			}
			
			var operator = NPPILY.Control.CommonGet
			(
				connectId,
				{
					puid: querys.puid,
					resType: NPPILY.Enum.PuResourceType.Storager,
					resIdx: querys.sgIndex,
					controlID: "CTL_SG_TransparenceComXML",
					param: '<Param>' + xmlRequest + '</Param>',
					returnFlag: 0
				}
			);
			
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				var dateArr = [];
				
				if (operator.response && operator.response.Response && operator.response.Response.Result == "0")
				{
					if (operator.response.Response.ID == querys.requestID) 
					{
						if (typeof operator.response.Response.Date != "undefined" && typeof operator.response.Response.Date.UTC != "undefined")
						{
							dateArr = operator.response.Response.Date.UTC;
							if (dateArr.constructor != Array)
							{
								dateArr = [dateArr];	
							}
						}														
					}
				}
				operator.response = dateArr;
			}
			
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
    ---
    fn: FetchCEFSFiles 
    desc: 查询CEFS存储文件（适用快速查询或高级查询）
    author:
        - huzw  
    time: 2013.11.08
	returns:
		- succ <Response: Array(UTC timstamp)>
	params:
		- connectId(string) * 连接ID
		- queryConditions(Object) * 查询条件
		{
			puid(string) * 查询对象设备PUID
			requestID(NPPILY.Enum.CEFSRequestID) * 请求命令
			beginTime(UTC timstamp) * 起始查询时间，缺省为0，如1325376000
			endTime(UTC timstamp) * 结束查询时间，缺省为0，如1325386000
			sgIndex(uint) 前端存储器资源索引，一般为0（缺省）
			diskLetter(string) 查询磁盘的盘符，缺省为空字符串
			channelSets(Uint|Array) 查询通道号，从0开始，依次表示第一路...视频，缺省为0，多个通道号使用数组，如new Array(0, 1, ..)
			reasonSets(String|Array) 存储原因，多个原因逻辑或联合查询请传数组，缺省将查所有原因的
			typeSets(String|Array) 数据类型
		}
	remark:
		- requestID = NPPILY.Enum.CEFSRequestID.QueryRecord 快速索引查询
			=> queryConditions.channelSets一个数值，如0或[0] 
			=> queryConditions.reasonSets传值也无效，将查所有原因的		
		- requestID = NPPILY.Enum.CEFSRequestID.QueryLinkActionRecord 高级查询
			=> queryConditions.channelSets一个数值，如0或[0] 
			=> queryConditions.reasonSets<(String|Array)(NPPILY.Enum.CEFSRecordReason)>，如Schedule或[Schedule, Manual]，缺省将查所有原因的
		
		- requestID = NPPILY.Enum.CEFSRequestID.QueryPicture 快速索引查询
			=> queryConditions.channelSets一个数值，如0或[0] 
			=> queryConditions.reasonSets传值也无效，将查所有原因的		
		- requestID = NPPILY.Enum.CEFSRequestID.QueryLinkActionPicture 高级查询
			=> queryConditions.channelSets单个数值或数组，如0或1或[0, 1, ...] 
			=> queryConditions.reasonSets<(String|Array)(NPPILY.Enum.CEFSPictureReason)>，如Schedule或[Schedule, Manual]，缺省将查所有原因的
		
		- requestID = NPPILY.Enum.CEFSRequestID.QueryUserLog
			=> 高级查询时: queryConditions.typeSets<(String|Array)(NPPILY.Enum.CEFSUserLogType)>，如UserLogin或UserLogin, UserLogout]
			=> 快速索引查询时：queryConditions.typeSets不必传值，将查所有类型的
			
		- requestID = NPPILY.Enum.CEFSRequestID.QueryAlarmEvent
			queryConditions.channelSets单个数值或数组，如0或1或[0, 1, ...] 
			=> 高级查询时: queryConditions.typeSets<(String|Array)(NPPILY.Enum.CEFSAlarmEventType)>，如AlertIn或[AlertIn, MotionDetected]
			=> 快速索引查询时：queryConditions.typeSets不必传值，将查所有类型的
		- requestID = NPPILY.Enum.CEFSRequestID.QueryGPSData
	...
	*/
	FetchCEFSFiles : function (connectId, queryConditions)
	{
		try
		{
			var fn = "NPPILY.FetchCEFSFiles";
			
			if (!connectId || !NPPILY.Connections.get(connectId))
			{
				NPPUtils.Log(fn, "connectId error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTID_ERROR);
			}
			var _connStruct = NPPILY.Connections.get(connectId);
			if (_connStruct.status != NPPILY.Enum.ConnectionStatus.Connected || !_connStruct.session) 
			{ 
				NPPUtils.Log(fn, "login or session error~");
				if (_connStruct.status == NPPILY.Enum.ConnectionStatus.Connecting)
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECTING);
				}
				else
				{
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_CONNECT_FAILED);
				}
			}
			
			var querys = queryConditions || {};
			
			if (!querys.puid || !NPPILY.puidRex.test(querys.puid))
			{
				NPPUtils.Log(fn, "querys.puid error~");
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_PUID_ERROR); 	
			}
			
			querys.diskLetter = querys.diskLetter || "";
			querys.beginTime = typeof querys.beginTime != "undefined" && !isNaN(querys.beginTime) ? querys.beginTime : 0;
			querys.endTime = typeof querys.endTime != "undefined" && !isNaN(querys.endTime) ? querys.endTime : 0;
			querys.channelSets = typeof querys.channelSets != "undefined" ? querys.channelSets : [0];
			querys.reasonSets = querys.reasonSets || [];
			querys.typeSets = querys.typeSets || [];
			
			if (querys.channelSets.constructor != Array)
			{
				querys.channelSets = [querys.channelSets];	
			}
			
			var xmlRequest = "",
				sgType = NPPILY.Enum.PuResourceType.Storager,
				sgIndex = querys.sgIndex = typeof querys.sgIndex != "undefined" && !isNaN(querys.sgIndex) ? querys.sgIndex : 0;
			
			switch (querys.requestID)
			{
				case NPPILY.Enum.CEFSRequestID.QueryRecord :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'" Channel="'+querys.channelSets[0]+'" />';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryLinkActionRecord :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'" Channel="'+querys.channelSets[0]+'"><Reasons>';
					if (querys.reasonSets.constructor != Array)
					{
						querys.reasonSets = [querys.reasonSets];	
					}
					if (querys.reasonSets.length <= 0)
					{
						for (reason in NPPILY.Enum.CEFSRecordReason)
						{
							xmlRequest += '<Reason>'+NPPILY.Enum.CEFSRecordReason[reason]+'</Reason>';	
						}
					}
					else
					{
						for (var i = 0; i < querys.reasonSets.length; i++)
						{
							if (typeof querys.reasonSets[i] != "undefined" && querys.reasonSets[i])
							{
								xmlRequest += '<Reason>'+querys.reasonSets[i]+'</Reason>';
							}	
						}	
					}
					xmlRequest += '</Reasons></Request>';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryPicture :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'" Channel="'+querys.channelSets[0]+'" />';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryLinkActionPicture :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'" >';
						xmlRequest += '<Channels>';
						for (var i = 0; i < querys.channelSets.length; i++)
						{
							if (typeof querys.channelSets[i] != "undefined" && !isNaN(querys.channelSets[i]))
							{
								xmlRequest += '<Channel>'+querys.channelSets[i]+'</Channel>';
							}	
						}
						xmlRequest += '</Channels>';
						
						xmlRequest += '<Reasons>';
						if (querys.reasonSets.constructor != Array)
						{
							querys.reasonSets = [querys.reasonSets];	
						}
						if (querys.reasonSets.length <= 0)
						{
							for (reason in NPPILY.Enum.CEFSPictureReason)
							{
								xmlRequest += '<Reason>'+NPPILY.Enum.CEFSPictureReason[reason]+'</Reason>';	
							}
						}
						else
						{
							for (var i = 0; i < querys.reasonSets.length; i++)
							{
								if (typeof querys.reasonSets[i] != "undefined" && querys.reasonSets[i])
								{
									xmlRequest += '<Reason>'+querys.reasonSets[i]+'</Reason>';
								}	
							}	
						}
						xmlRequest += '</Reasons>';
					xmlRequest += '</Request>';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryUserLog :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'" >';
						xmlRequest += '<Types>';
						if (querys.typeSets.constructor != Array)
						{
							querys.typeSets = [querys.typeSets];
						}
						if (querys.typeSets.length <= 0)
						{
							for (type in NPPILY.Enum.CEFSUserLogType)
							{
								xmlRequest += '<Type>'+NPPILY.Enum.CEFSUserLogType[type]+'</Type>';	
							}
						}
						else
						{
							for (var i = 0; i < querys.typeSets.length; i++)
							{
								if (typeof querys.typeSets[i] != "undefined" && querys.typeSets[i])
								{
									xmlRequest += '<Type>'+querys.typeSets[i]+'</Type>';
								}	
							}
						}
						xmlRequest += '</Types>';
					xmlRequest += '</Request>';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryAlarmEvent :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'">';
						xmlRequest += '<Channels>';
						for (var i = 0; i < querys.channelSets.length; i++)
						{
							if (typeof querys.channelSets[i] != "undefined" && !isNaN(querys.channelSets[i]))
							{
								xmlRequest += '<Channel>'+querys.channelSets[i]+'</Channel>';
							}	
						}
						xmlRequest += '</Channels>';
						
						xmlRequest += '<Types>';
						if (querys.typeSets.length <= 0)
						{
							for (type in NPPILY.Enum.CEFSAlarmEventType)
							{
								xmlRequest += '<Type>'+NPPILY.Enum.CEFSAlarmEventType[type]+'</Type>';	
							}
						}
						else
						{
							for (var i = 0; i < querys.typeSets.length; i++)
							{
								if (typeof querys.typeSets[i] != "undefined" && querys.typeSets[i])
								{
									xmlRequest += '<Type>'+querys.typeSets[i]+'</Type>';
								}	
							}
						}
						xmlRequest += '</Types>';
					xmlRequest += '</Request>';
					break;
				case NPPILY.Enum.CEFSRequestID.QueryGPSData :
					xmlRequest = '<Request ID="'+querys.requestID+'" DiskLetter="'+querys.diskLetter+'" BeginTime="'+querys.beginTime+'" EndTime="'+querys.endTime+'" />';
					break;
				default:
					NPPUtils.Log(fn, "querys.requestID undefined+ error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					break;
			}
			
			var operator = NPPILY.Control.CommonGet
			(
				connectId,
				{
					puid: querys.puid,
					resType: NPPILY.Enum.PuResourceType.Storager,
					resIdx: querys.sgIndex,
					controlID: "CTL_SG_TransparenceComXML",
					param: '<Param>' + xmlRequest + '</Param>',
					returnFlag: 0
				}
			);
			
			if (operator.rv == NrcapError.NRCAP_SUCCESS)
			{
				var filesArr = [];
				
				if (operator.response && operator.response.Response && operator.response.Response.Result == "0")
				{
					var nextBeginTime = operator.response.Response.NextBeginTime;
					var needNextQuery = nextBeginTime == 0 ? false : true;
							
					switch (querys.requestID)
					{
						case NPPILY.Enum.CEFSRequestID.QueryRecord :
						case NPPILY.Enum.CEFSRequestID.QueryLinkActionRecord :	
							if (typeof operator.response.Response.Record != "undefined")
							{
								var Record = operator.response.Response.Record;
								if (Record.constructor != Array)
								{
									Record = [Record];	
								}
								for (var i = 0; i < Record.length; i++)
								{
									filesArr.push(new NPPILY.Struct.CEFSRecordStruct(false, Record[i].BeginTime, Record[i].EndTime, Record[i].BitRate, Record[i].Reason, querys.puid, querys.channelSets[0]));
								}
								if (needNextQuery == true)
								{
									filesArr.push(new NPPILY.Struct.CEFSRecordStruct(true, nextBeginTime, 0, 0, 0, querys.puid, querys.channelSets[0]));
								}
							}
							break;
							
						case NPPILY.Enum.CEFSRequestID.QueryPicture :
						case NPPILY.Enum.CEFSRequestID.QueryLinkActionPicture :
							if (typeof operator.response.Response.Picture == "undefined")
							{
								if (typeof operator.response.Response.Record != "undefined")
								{
									operator.response.Response.Picture = operator.response.Response.Record;
								}
							}
							if (typeof operator.response.Response.Picture != "undefined")
							{
								var Picture = operator.response.Response.Picture;
								if (Picture.constructor != Array)
								{
									Picture = [Picture];	
								}
								for (var i = 0; i < Picture.length; i++)
								{
									filesArr.push(new NPPILY.Struct.CEFSPictureStruct(false, Picture[i].Time, Picture[i].NoInSecond, Picture[i].Reason, querys.puid, (typeof Picture[i].Channel != "undefined" ? Picture[i].Channel : querys.channelSets[0])));
								}
								if (needNextQuery == true)
								{
									filesArr.push(new NPPILY.Struct.CEFSPictureStruct(true, nextBeginTime, 0, 0, querys.puid, querys.channelSets));
								}
							}
							break;
							
						case NPPILY.Enum.CEFSRequestID.QueryUserLog :
							if (typeof operator.response.Response.UserLog != "undefined")
							{
								var UserLog = operator.response.Response.UserLog;
								if (UserLog.constructor != Array)
								{
									UserLog = [UserLog];	
								}
								for (var i = 0; i < UserLog.length; i++)
								{
									filesArr.push(new NPPILY.Struct.CEFSUserLogStruct(false, UserLog[i].Time, UserLog[i].Type, UserLog[i].Data, querys.puid));
								}
								if (needNextQuery == true)
								{
									filesArr.push(new NPPILY.Struct.CEFSUserLogStruct(true, nextBeginTime, 0, 0, querys.puid));
								}
							}
							break;
							
						case NPPILY.Enum.CEFSRequestID.QueryAlarmEvent :
							if (typeof operator.response.Response.AlarmEvent != "undefined")
							{
								var AlarmEvent = operator.response.Response.AlarmEvent;
								if (AlarmEvent.constructor != Array)
								{
									AlarmEvent = [AlarmEvent];	
								}
								for (var i = 0; i < AlarmEvent.length; i++)
								{
									filesArr.push(new NPPILY.Struct.CEFSAlarmEventStruct(false, AlarmEvent[i].Time, AlarmEvent[i].Type, AlarmEvent[i].Data, querys.puid, AlarmEvent[i].Channel));
								}
								if (needNextQuery == true)
								{
									filesArr.push(new NPPILY.Struct.CEFSAlarmEventStruct(true, nextBeginTime, 0, 0, querys.puid, querys.channelSets));
								}
							}
							break;
						case NPPILY.Enum.CEFSRequestID.QueryGPSData :
							if (typeof operator.response.Response.GPSData != "undefined")
							{
								var GPSData = operator.response.Response.GPSData;
								if (GPSData.constructor != Array)
								{
									GPSData = [GPSData];	
								}
								for (var i = 0; i < GPSData.length; i++)
								{
									filesArr.push(new NPPILY.Struct.CEFSGPSDataStruct(false, GPSData[i].Time, GPSData[i].Latitude, GPSData[i].Longitude, GPSData[i].Bearing, GPSData[i].Altitude, GPSData[i].OfflineFlag, GPSData[i].State, GPSData[i].Speed, GPSData[i].MaxSpeed, GPSData[i].MinSpeed, querys.puid));
								}
								if (needNextQuery == true)
								{
									filesArr.push(new NPPILY.Struct.CEFSGPSDataStruct(true, nextBeginTime, 0, 0, 0, 0, 0, 0, 0, 0, 0, querys.puid));
								}
							}
							break;
					} // end switch
				}
				
				operator.response = filesArr;
			
			} // end operator.response
			
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/*
	---
	fn: CommonResConfig
	desc: 资源描述配置
	author: 
		- huzw
	time: 2013.11.14
	params: 
		- connectId(string) * 连接ID
		- puid(string) * 设备PUID
		- resType(string) * 资源类型
		- resIdx(uint) * 资源索引
		- action(string) 获取get或设置set资源描述，缺省为get
		- paramObj(NPPILY.Struct.CommonResDescriptionStruct) 资源描述结构信息，action=set使用
	...
	*/
	CommonResConfig : function (connectId, puid, resType, resIdx, action, paramObj)
	{
		try
		{
			var fn = "NPPILY.CommonResConfig";
			
			var operator,
				o = paramObj || {};
			switch ((typeof action == "string" ? action.toLowerCase() : action))
			{
				case "set":
					operator = NPPILY.Config.SetComplex
					(
					 	connectId,
						{
							puid: puid,
							resType: resType,
							resIdx: resIdx,
							configID: "CFG_COMMONRES_Desc",
							streamType: "",
                    		param: '<Param><Res ResType="'+o.resType+'" ResIdx="'+o.resIdx+'" Name="'+o.name+'" Desc="'+o.description+'" Enable="'+o.enable+'" /></Param>',
							returnFlag: 0
						}
					);
					break;
				default:
					operator = NPPILY.Config.GetComplex
					(
					 	connectId,
						{
							puid: puid,
							resType: resType,
							resIdx: resIdx,
							configID: "CFG_COMMONRES_Desc",
							returnFlag: 0
						}
					);
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						var o = null;
						if (operator.response && typeof operator.response.Res != "undefined")
						{
							if (typeof operator.response.Res.Name != "undefined")
							{
								o = new NPPILY.Struct.CommonResDescriptionStruct
								(
									puid,
									operator.response.Res.ResType,
									operator.response.Res.ResIdx,
									operator.response.Res.Name,
									operator.response.Res.Desc,
									operator.response.Res.Enable
								);
							}
						}
						operator.response = o;
					}
					break;
			}; 
			return operator;
		}
		catch (e) {
			NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
			return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
		}
	},
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- s - remark: Folder Operation - 2013.12.14
    * ........................................................................................................
    **/
	// - 文件（夹）操作对象
	Folder :
	{
		/*
		---
		time: 2014.03.31
		...
		*/
		Init : function ()
		{
			try
			{
				var fn = "NPPILY.Folder.Init";
				
				// - 开启设备搜索库
				// NPPILY.Folder.PUDetectStartup();
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.name + "::" + e.message);
				return false;
			}
		},
		/*
		---
		desc: 切换WA调试
		params:
			- bValue(boolean) 1/true开启，0/false关闭（缺省）
		...
		*/
		DebugSwitch : function (bValue)
		{
			return NPPIF.Folder.DebugSwitch(NPPILY.Plug.wa, (bValue || 0));
		},
		// - 获取操作系统根目录
		GetSystemRoot : function ()
		{
			return NPPIF.Folder.GetSystemRoot(NPPILY.Plug.wa);
		},
		/*
		---
		desc: 打开目录选择对话框
		params:
			- dialogTitle(string) 对话框标题，缺省为"" 
		...
		*/
		GetFileFolder : function (dialogTitle)
		{
			return NPPIF.Folder.GetFileFolder(NPPILY.Plug.wa, (dialogTitle || ""));
		},
		// - 打开目录
		OpenFolder : function (folderPath)
		{
			return NPPIF.Folder.OpenFolder(NPPILY.Plug.wa, folderPath);
		},
		/*
		---
		desc: 检测是否允许文件操作
		time: 2015.04.03
		author: huzw
		returns: response : 0:正常， -1:异常
		...
		*/
		GetFileJurisdiction : function (fildName)
		{
			return NPPIF.Folder.GetFileJurisdiction(NPPILY.Plug.wa, fildName);
		},
		/*
		---
		desc: 创建文件夹
		params:
			- folderPath(string) 需要创建的目录全路径
		...
		*/
		CreateDirectory : function (folderPath)
		{
			return NPPIF.Folder.CreateDirectory(NPPILY.Plug.wa, folderPath);
		},
		// - 删除文件夹
		DeleteDirectory : function (folderPath)
		{
			return NPPIF.Folder.DeleteDirectory(NPPILY.Plug.wa, folderPath);
		},
		/*
		---
		desc: 删除文件
		params:
			- fileName(string) 需要删除的文件全路径名称
		...
		*/
		DeleteFile : function (fileName)
		{
			return NPPIF.Folder.DeleteFile(NPPILY.Plug.wa, fileName);
		},
		/*
		---
		desc: 检测文件是否存在
		returns:
			- response = 1存在，其他值不存在
		params:
			- fileName(string) 需要检测的文件全路径名称
		remark:
			- 返回值节点rv = NrcapError.NRCAP_SUCCESS，response = 1存在，0不存在 
			- rv为其他值时，表示调用不成功
		...
		*/
		FileExist : function (fileName)
		{
			try
			{
				var fn = "NPPILY.Folder.FileExist";
				
				if (NPPILY.Plug.wa)
				{
					var operator = NPPIF.Folder.FileExist(NPPILY.Plug.wa, (fileName || ""));
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						operator.response = (operator.response === true) ? 1 : 0;
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			} 
		},
		// - 读文件内容
		ReadFile : function (fileName)
		{
			return NPPIF.Folder.ReadFile(NPPILY.Plug.wa, (fileName || ""));
		},
		/*
		---
		desc: 写文件内容
		params:
			- fileName(string) 需要写文件的全路径名称，如C:/123.txt
			- content(string) 写的具体内容
			- contentLength(number) 内容真实长度
			- bValue(boolean) 1/true写追加，0/false写覆盖（缺省）
		remark:
			- 文件不存在可创建，前提是上级目录首先存在
		...
		*/
		WriteFile : function (fileName, content, contentLength, bValue)
		{
			return NPPIF.Folder.WriteFile(NPPILY.Plug.wa, (fileName || ""), content, contentLength, (bValue || 0));
		},
		/*
		---
		desc: 按类型获取目录下的文件列表
		params:
			- folderPath(string) 全路径文件夹名称
			- fileType(string) 为文件的类型，如"avi/AVI", "jpg", "doc"等等（不可省略）
			- bValue(uint) 是否深度递归获取，缺省为0
			- bReturnFullPath(uint) 是否返回全路径，缺省为0否
		remark:
			- 如果fileType为某个具体的类型时，理论上将返回此类型的全部文件
		...
		*/
		GetFolderFiles : function (folderPath, fileType, bValue, bReturnFullPath)
		{
			try
			{
				var fn = "NPPILY.Folder.GetFolderFiles";
				
				if (NPPILY.Plug.wa)
				{
					return NPPIF.Folder.GetFolderFiles(NPPILY.Plug.wa, folderPath, (fileType || ""), (bValue || 0), ( bReturnFullPath || 0));
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			} 
		},
		// - 获取目录下的文件夹列表
		GetFolders : function (folderPath, bValue, bReturnFullPath)
		{
			try
			{
				var fn = "NPPILY.Folder.GetFolders";
				
				if (NPPILY.Plug.wa)
				{
					return NPPIF.Folder.GetFolders(NPPILY.Plug.wa, folderPath, (bValue || 0), (bReturnFullPath || 0));
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			} 
		},
		/*
		---
		desc: 进行Base64编码
		params:
			- segment(string) 要编码的字符串
		...
		*/
		Base64Enc : function (segment)
		{
			return NPPIF.Folder.Base64Enc(NPPILY.Plug.wa, segment);
		},
		/*
		---
		desc: 进行Base64解码
		params:
			- base64EnStr(string) 要解码的字符串
			- 是否使用UTF8编码，缺省使用
		...
		*/
		Base64Dec : function (base64EnStr, bUsingUTF8)
		{
			return NPPIF.Folder.Base64Dec(NPPILY.Plug.wa, base64EnStr, bUsingUTF8);
		},
		// - Des编码
		DesEnc : function (base64Raw, base64Key)
		{
			return NPPIF.Folder.DesEnc(NPPILY.Plug.wa, base64Raw, base64Key);
		},
		// - Des解码
		DesDec : function (base64EnStr, base64KeyStr)
		{
			return NPPIF.Folder.DesDec(NPPILY.Plug.wa, base64EnStr, base64KeyStr);
		},
		GetRandTokenForUser : function (base64EnStr, keyStr)
		{
			return NPPIF.Folder.GetRandTokenForUser(NPPILY.Plug.wa, base64EnStr, keyStr);
		},
		SetRandTokenForUser : function (rawData, keyStr)
		{
			return NPPIF.Folder.SetRandTokenForUser(NPPILY.Plug.wa, rawData, keyStr);
		},
		/*
		---
		desc: 读取指定文件内容，经Base64编码后返回
		params:
			- fileName(string) 文件全路径，如图片C:/123.gif
		remark:
			- 请确保fileName合法存在
		...
		*/
		ReadFileEx : function (fileName)
		{
			return NPPIF.Folder.ReadFileEx(NPPILY.Plug.wa, (fileName || ""));
		},
		/*
		---
		desc: 将文件复制到指定目录下
		params:
			- srcFileName(string) 需要复制的文件全路径
			- dstFileName(string) 保存到目标目录下文件名，可以只是文件名，将放在srcFileName同一目录下
		remark:
			- 返回值节点rv = NrcapError.NRCAP_SUCCESS，response = 0复制成功（对于某些不合法的目标文件名，实际复制是不成功的），-1源文件应传入绝对路径，-2源文件不存在 
			- rv为其他值时，表示调用不成功
		...
		*/
		CopyFile : function (srcFileName, dstFileName)
		{
			try
			{
				var fn = "NPPILY.Folder.CopyFile";
				
				if (NPPILY.Plug.wa)
				{
					var operator = NPPIF.Folder.CopyFile(NPPILY.Plug.wa, srcFileName, dstFileName);
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						operator.response = operator.response == "" ? 0 : (operator.response == -1 ? -1 : -2); 
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			} 
		},
		
		/*
		---
		fn: StartHttpDownload
		desc: 开始下载解码库插件
		params: 
			- url(net location string) 网络地址，如http://127.0.0.1/npsdk/CreMedia7.0_Plugin_Setup.exe
			- saveDir(string) 本地下载保存目录，如C:/
			- autoRun(boolean) 下载完成后是否自动运行，1是0否，默认为1
		remark:
			- WA -> NPP_httpDownloadServer{ active: ?, url: ?, saveDir: ?, autoRun: ?, ...}
		...
		*/
		StartHttpDownload : function (url, saveDir, autoRun) 
		{
			try
			{
				var fn = "NPPILY.Folder.StartHttpDownload";
				if (NPPILY.Plug.wa)
				{
					// - 检测一下是否存在下载
					if (typeof NPPILY.Plug.wa["NPP_httpDownloadServer"] != "undefined")
					{
						if (NPPILY.Plug.wa["NPP_httpDownloadServer"]["active"] == true)
						{
							NPPUtils.Log(fn, "http download has existed~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_DOWNLOAD_EXISTED);
						}
					}
					if (!url || !saveDir)
					{
						NPPUtils.Log(fn, "url or saveDir error~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
					}
					var autoRun = !!(autoRun == false) ? 0 : 1;
					
					var operator = NPPIF.Folder.HttpDownload(NPPILY.Plug.wa, url, saveDir, autoRun);
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						NPPILY.Plug.wa["NPP_httpDownloadServer"] =
						{
							active: true, 
							url: url, 
							saveDir: saveDir, 
							autoRun: autoRun,
							status: null,
							desc: null,
							total_length: null,
							current_length: null,
							speed: null
						};
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		CloseHttpDownload : function () 
		{
			try
			{
				var fn = "NPPILY.Folder.CloseHttpDownload";
				if (NPPILY.Plug.wa)
				{
					if (typeof NPPILY.Plug.wa["NPP_httpDownloadServer"] != "undefined")
					{
						if (NPPILY.Plug.wa["NPP_httpDownloadServer"]["active"] == false)
						{
							NPPUtils.Log(fn, "http download closed~");
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
						}
					}
					else
					{
						NPPUtils.Log(fn, "http download not exist~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);	
					}
					var operator = NPPIF.Folder.CloseHttpDownload(NPPILY.Plug.wa);
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						NPPILY.Plug.wa["NPP_httpDownloadServer"]["active"] = false;
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		/*
		---
		remark:
			- 开始下载后，上层需要定时侦测下载的状态，当检测到下载完成时应停止下载
		...
		*/
		GetStatus : function ()
		{
			try
			{
				var fn = "NPPILY.Folder.GetStatus";
				if (NPPILY.Plug.wa)
				{
					if (typeof NPPILY.Plug.wa["NPP_httpDownloadServer"] != "undefined")
					{
						if (NPPILY.Plug.wa["NPP_httpDownloadServer"]["active"] == false)
						{
							NPPUtils.Log(fn, "http download not exist~");
							if (NPPILY.Plug.wa["NPP_httpDownloadServer"]["status"] != null)
							{
								return new NPPILY.Struct.ReturnValueStruct
								(
									NrcapError.NRCAP_SUCCESS, 
									new NPPILY.Struct.HttpDownloadStatusStruct
									(
										NPPILY.Plug.wa["NPP_httpDownloadServer"]["status"],
										NPPILY.Plug.wa["NPP_httpDownloadServer"]["desc"],
										NPPILY.Plug.wa["NPP_httpDownloadServer"]["speed"],
										NPPILY.Plug.wa["NPP_httpDownloadServer"]["total_length"],
										NPPILY.Plug.wa["NPP_httpDownloadServer"]["current_length"]
									)
								);	
							}
							return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
						}
					}
					else
					{
						NPPUtils.Log(fn, "http download not exist~");
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);	
					}
					
					var status_opt = NPPIF.Folder.GetStatus(NPPILY.Plug.wa);
					var speed_opt = NPPIF.Folder.GetSpeed(NPPILY.Plug.wa);
					var totalBytes_opt = NPPIF.Folder.GetTotalLength(NPPILY.Plug.wa);
					var curBytes_opt = NPPIF.Folder.GetDownloadLength(NPPILY.Plug.wa);
					
					NPPUtils.Log(fn, status_opt.response + "::" + speed_opt.response + "::" + totalBytes_opt.response + "::" + curBytes_opt.response);
					
					var status = status_opt.response || 0,
						desc = NPPILY.Enum.HttpDownloadStatusDesc[status][NPPILY.language] || "",
						speed = speed_opt.response || 0,
						totalBytes = totalBytes_opt.response || 0;
						curBytes = curBytes_opt.response || 0;
					
					NPPILY.Plug.wa["NPP_httpDownloadServer"]["status"] = status;
					NPPILY.Plug.wa["NPP_httpDownloadServer"]["desc"] = desc;
					NPPILY.Plug.wa["NPP_httpDownloadServer"]["speed"] = speed;
					NPPILY.Plug.wa["NPP_httpDownloadServer"]["total_length"] = totalBytes;
					NPPILY.Plug.wa["NPP_httpDownloadServer"]["current_length"] = curBytes;
					  
					return new NPPILY.Struct.ReturnValueStruct
					(
					 	NrcapError.NRCAP_SUCCESS, 
						new NPPILY.Struct.HttpDownloadStatusStruct
						(
							status,
							desc,
							speed,
							totalBytes,
							curBytes
						)
					);
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		/*
		---
		remark:
			- 获取解码库插件的版本号，如果响应为空或者版本号不是最新的（上层应规定一个版本，每次可以验证一下），那么版本太低需执行下载更新
		...
		*/
		GetPluginVersion : function (pluginName) 
		{
			try
			{
				var fn = "NPPILY.Folder.GetPluginVersion";
				return NPPIF.Folder.GetPluginVersion(NPPILY.Plug.wa, (pluginName || ""));
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		/*
		---
		time: 2014.03.27 add
		author: 
			- huzw
		fn:
			- PUDetectStartup
			- PUDetectGetPUList
			- PUDetectCleanup
		remark:
			- 页面使用时请Startup后，周期获取GetPUList，终止使用使用Cleanup
		...
		*/
		PUDetectStartup : function ()
		{
			try
			{
				var fn = "NPPILY.Folder.PUDetectStartup";
				
				if (NPPILY.Plug.wa)
				{
					NPPILY.Plug.wa["NPP_PUDetectStartupped"] = NPPILY.Plug.wa["NPP_PUDetectStartupped"] || false;
					if (NPPILY.Plug.wa["NPP_PUDetectStartupped"])
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
					}
					var operator =  NPPIF.Folder.PUDetectStartup(NPPILY.Plug.wa);
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						NPPILY.Plug.wa["NPP_PUDetectStartupped"] = true;	
					}
					else
					{
						NPPUtils.Log(fn, "wa PUDetectStartup failed~");
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e)
			{
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);	
			}
		},
		PUDetectGetPUList : function ()
		{
			try
			{
				var fn = "NPPILY.Folder.PUDetectGetPUList";
				
				if (NPPILY.Plug.wa)
				{
					// - 开启设备搜索初始化
					var operator = NPPILY.Folder.PUDetectStartup();
					if (operator.rv != NrcapError.NRCAP_SUCCESS)
					{
						return operator;
					}
					return NPPIF.Folder.PUDetectGetPUList(NPPILY.Plug.wa);
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e)
			{
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		PUDetectCleanup : function ()
		{
			try
			{
				var fn = "NPPILY.Folder.PUDetectCleanup";
				
				if (NPPILY.Plug.wa)
				{
					// - 关闭设备搜索
					NPPILY.Plug.wa["NPP_PUDetectStartupped"] = NPPILY.Plug.wa["NPP_PUDetectStartupped"] || false;
					if (!NPPILY.Plug.wa["NPP_PUDetectStartupped"])
					{
						return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
					}
					var operator =  NPPIF.Folder.PUDetectCleanup(NPPILY.Plug.wa);
					if (operator.rv == NrcapError.NRCAP_SUCCESS)
					{
						NPPILY.Plug.wa["NPP_PUDetectStartupped"] = false;	
					}
					else
					{
						NPPUtils.Log(fn, "wa PUDetectCleanup failed~");
					}
					return operator;
				}
				else
				{
					NPPUtils.Log(fn, "wa undefined error~");
					return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_FAILED);
				}
			}
			catch (e)
			{
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			}
		},
		
		/*
		---
		desc: 退出清除
		...
		*/
		UnLoad : function ()
		{
			try
			{
				var fn = "NPPILY.Folder.UnLoad";
				NPPILY.Folder.CloseHttpDownload();
				NPPILY.Folder.PUDetectCleanup();
			}
			catch (e) {
				NPPUtils.Log(fn, "excp error = " + e.message + "::" + e.name);
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR_THREAD);
			} 
		},
		end : true
	},
	
	/**
    * --------------------------------------------------------------------------------------------------------
    *	- e - remark: Folder Operation - 2013.12.14
    * ........................................................................................................
    **/
	
    /*
    ---
    fn: Debug 
    desc: 调试对象
    author:
        - zenghx  
    time: 2013.09.04 
    ... 
    */
    Debug : 
    {
        debug : false, // - 是否开启调试
        messages : new Array(), // - 调试信息数据
		maxCount : 1000, // - 最多保存条数
        callback : null, // - 回调函数
        Init : function (_ipStruct) 
        {
            try 
            {
                if (_ipStruct && _ipStruct instanceof NPPILY.Struct.InitParamStruct) 
                {
                    NPPILY.Debug.debug = _ipStruct.debug === true ? true : false;
                    if (typeof _ipStruct.callback == "function") 
                    {
                        NPPILY.Debug.callback = _ipStruct.callback || function () {};
                    }
                }
                if (typeof NPPUtils != "undefined") {
                    NPPUtils.Log = NPPILY.Debug.Note;
                }
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
            }
            catch (e) {
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
            }
        },
        Note : function (fn, log, _time, _mode) 
        {
            try 
            {
				if (_mode === true)
				{
                	return NrcapError.NRCAP_SUCCESS;
				}
                var _time = _time || NPPUtils.DateFormat(), _fn = fn || "_NPPILYSDKDebugger_", _log = log || "";
                var _message = new NPPILY.Struct.DebugMessageStruct( _time, _fn, _log );
                if (_message) 
                {
                    NPPILY.Debug.messages.push(_message);
					if (NPPILY.Debug.messages.length > NPPILY.Debug.maxCount)
					{
						NPPILY.Debug.messages.splice(0, NPPILY.Debug.maxCount);	
					}
                    if (NPPILY.Debug.debug) 
                    {
                        if (typeof NPPILY.Debug.callback == "function") 
                        {
                            NPPILY.Debug.callback(_message);
                        }
                        else 
                        {
                            alert("[time] " + _message.time + "\r\n[fn]" + _message.fn + "\r\n[msg]" + (typeof _message.msg == "object" && typeof Object.toJSON != "undefined" && NPPILY.browserType == NPPILY.Enum.BrowserType.IE ? Object.toJSON(_message.msg) : _message.msg));
                        }
                    }
                }
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_SUCCESS);
            }
            catch (e) {
				return new NPPILY.Struct.ReturnValueStruct(NrcapError.NRCAP_ERROR);
            }
        },
        end : true 
    },
    // - 结构体对象
    Struct : 
    { 
        /*
        ---
        fn: InitParamStruct
        desc: 初始化NPPILY对象参数结构
        author: 
            - Lingsen
            - huzw
        time: 2010.11.26 -> 2013.01.12
        modifytime: 2013.09.03
        params:
            - debug(boolean) 是否开始调试状态
            - cb(function) 调试信息输出回调函数
            - extraParams(object) 其他参数
            => {
                language(NPPILY.Enum.LanguageType) SDK语言对象
				warmTip(object):
				{
					active(boolean) 是否使能未加载插件时内部温馨提示
					pluginFile(string) 插件绝对地址或网络地址，默认"MediaPlugin7.exe"
					html(html code) 自定义网页提示代码
				}
            }
        remark:   
        ...
        */
        InitParamStruct : function (debug, cb, extraParams) 
        {
            this.debug = (typeof debug != "undefined" && debug === true ? true : false);
            this.callback = (typeof cb != "undefined" ? cb : null);
            var extraParams = extraParams || {};
            this.language = extraParams.language || "";
			
			var _wt = extraParams.warmTip = extraParams.warmTip || {};
			this.warmTip = {
				active : typeof _wt.active == "undefined" ? (NPPILY.Plug.Error.active || false) : (_wt.active || false),
				pluginFile : _wt.pluginFile || NPPILY.Plug.Error.pluginFile || "MediaPlugin7.exe",
				html : _wt.html || ""
			};
        },
        // - 调试信息结构
        DebugMessageStruct : function (time, fn, msg) 
        {
            this.time = time;
            this.fn = fn;
            this.msg = msg;
        },
		
		/*
		---
		desc: 返回值结构
		...
		*/
		ReturnValueStruct : NPPIF.Struct.ReturnValueStruct,
		
        /*
        ---
        desc: 初始化连接服务器参数结构
        params:
            - path(string) IP:Port, 如127.0.0.1:8866
            - username(string) 用户名
            - epId(string) 企业ID
            - password(string) 用户密码
            - bFixCUIAddress(bool) 是否透过网闸（1/true是，0/false否）
        ...
        */
        ConnParamStruct : NPPIF.Struct.ConnParamStruct,
		
		/*
        ---
        fn: PUNodeStruct
        desc: PU资源节点结构
        author:
                - huzw
        time: 2013.09.05
        params:
			- puid(string) 设备PUID
			- resType(string) 资源类型
			- resIdx(string) 资源索引
			- name(string) 资源名称
			- description(string) 资源描述
			- enable(string) 是否使能
			- online(string) 是否在线
			- immitted(string) 是否允许接入（0不允许，1允许）
			- modelName(string) 资源型号名称
			- modelType(string) 资源型号
			- manufactrueID(string) 厂商ID
			- hardwareVersion(string) 硬件版本
			- softwareVersion(string) 软件版本
			- deviceID(string) 设备ID
			- latitude(string) 固定点纬度
			- longitude(string) 固定点经度
			- _HANDLE(string) 设备资源句柄
			- childResource 子资源
		remark:
			- _HANDLE为保留属性，设备资源句柄，上层可以不用
        ...
        */
		PUNodeStruct : function (puid, resType, resIdx, name, description, enable, online, immitted, modelName, modelType, manufactureID, hardwareVersion, softwareVersion, deviceID, latitude, longitude, _HANDLE, childResource) 
		{
            this.puid = (typeof puid != "undefined" ? puid : "");
            this.resType = (typeof resType != "undefined" ? resType : NPPILY.Enum.PuResourceType.SELF);
            this.resIdx = (resIdx != null && typeof resIdx != "undefined" ? resIdx : "0");
            this.name = (typeof name != "undefined" ? name : "");
            this.description = (typeof description != "undefined" ? description : "");
            this.enable = (parseInt(enable) === 0 ? enable : "1");
            this.online = (parseInt(online) === 0 ? online : "1");
            this.immitted = (parseInt(immitted) === 0 ? "0" : "1");
            this.modelName = (typeof modelName != "undefined" ? modelName : "");
            this.modelType = (typeof modelType != "undefined" ? modelType : "");

            this.manufactrueID = (typeof manufactrueID != "undefined" ? manufactrueID : "");
            this.hardwareVersion = (typeof hardwareVersion != "undefined" ? hardwareVersion : "");
            this.softwareVersion = (typeof softwareVersion != "undefined" ? softwareVersion : "");
            this.deviceID = (typeof deviceID != "undefined" ? deviceID : "");
            this.latitude = (latitude ? latitude : "");
            this.longitude = (longitude ? longitude : "");
			this._HANDLE = _HANDLE || "";
            this.childResource = (childResource || []);
        },
		/*
        ---
        fn: PUResourceNodeStruct
        desc: PU子资源节点结构
        author:
                - huzw
        time: 2013.09.05
        params:
			- type(string) 资源类型
			- idx(string) 资源索引
			- name(string) 资源名称
			- description(string) 资源描述
			- enable(string) 是否使能 
			- _HANDLE(string) 设备子资源句柄
		remark:
			- _HANDLE为保留属性，设备子资源句柄，上层可以不用
        */
		PUResourceNodeStruct: function (type, idx, name, description, enable, _HANDLE) 
		{
            this.type = (typeof type != "undefined" ? type : "");
            this.idx = (idx != null && typeof idx != "undefined" ? idx : "");
            this.name = (typeof name != "undefined" ? name : "");
            this.description = (typeof description != "undefined" ? description : "");
            this.enable = (parseInt(enable) === 0 ? enable : "1");
			this._HANDLE = _HANDLE || "";
        },
		/*
        ---
        fn: LogicGroupStruct
        desc: ：逻辑分组信息结构
        author:
                - huzw
        time: 2013.11.15
        params:
			- index(string) 逻辑分组索引
			- name(string) 逻辑分组名称
			- lastRefreshTime(string) 最新刷新时间
			- refreshInterval(string) 刷新时间间隔
			- childResource(NPPILY.Struct.LogicGroupNodeStruct) 逻辑分组节点数组对象 
        */
		LogicGroupStruct : function (index, name, lastRefreshTime, refreshInterval, childResource)
		{
			this.index = (index != null && typeof index != "undefined" ? index : "0");
            this.name = (name != null && typeof name != "undefined" ? name : "");
            this.lastRefreshTime = (lastRefreshTime != null && typeof lastRefreshTime != "undefined" ? lastRefreshTime : "");
            this.refreshInterval = (refreshInterval != null && typeof refreshInterval != "undefined" ? refreshInterval : "");
            this.childResource = (childResource != null && typeof childResource == "object" && childResource.constructor == Array ? childResource : new Array());
		},
		/*
        ---
        fn: LogicGroupNodeStruct
        desc: ：逻辑分组节点信息结构
        author:
                - huzw
        time: 2013.11.15
        params:
			- index(uint) 逻辑分组节点索引
			- name(string) 逻辑分组节点名称
			- parentNode_Index(uint) 逻辑分组节点上级索引，根节点上级为0
			- childResource(NPPILY.Struct.LogicGroupNodeStruct|NPPILY.Struct.LogicGroupResourceStruct) 数组对象 
        */
		LogicGroupNodeStruct : function (index, name, parentNode_Index, childResource)
		{
			this.index = (index != null && typeof index != "undefined" ? index : "0");
            this.name = (name != null && typeof name != "undefined" ? name : "");
            this.parentNode_Index = (parentNode_Index != null && typeof parentNode_Index != "undefined" ? parentNode_Index : "0");
            this.childResource = (childResource != null && typeof childResource == "object" && childResource.constructor == Array ? childResource : new Array());	
		},
		/*
        ---
        fn: LogicGroupResourceStruct
        desc: ：逻辑分组节点下资源信息结构
        author:
                - huzw
        time: 2013.11.15
        params:
			- puid(string) 设备PUID
			- type(string) （视频）资源类型，一般为NPPILY.Enum.PuResourceType.VideoIn
			- idx(uint) （视频）资源索引
			- name(string) （视频）资源名称
			- description(string) （视频）资源描述
			- enable(uint) （视频）资源是否使能 
			- parentNode_Index(uint) 逻辑分组节点资源上级节点索引
        */
		LogicGroupResourceStruct: function (puid, type, idx, name, description, enable, parentNode_Index)
		{
            this.puid = (puid != null && typeof puid != "undefined" ? puid : "");
            this.type = (type != null && typeof type != "undefined" ? type : "");
            this.idx = (idx != null && typeof idx != "undefined" ? idx : "0");
            this.name = (name != null && typeof name != "undefined" ? name : "");
            this.description = (description != null && typeof description != "undefined" ? description : "");
            this.enable = (enable != null && typeof enable != "undefined" ? enable : "0");
            this.parentNode_Index = (parentNode_Index != null && typeof parentNode_Index != "undefined" ? parentNode_Index : "0");
        },
		/*
        ---
        fn: ConnectionStruct 
        desc: 连接对象信息结构
        author:
            - zenghx  
            - huzw 
        time: 2013.09.03 
        returns: 
            - NrcapError 
        params: 
            - connectId(string) 连接ID 
            - connParam(NPPILY.Struct.NrcapConnectParams) 连接参数 
        ... 
        */
        ConnectionStruct : function (connectId, connParam) 
        {
            var key = this.connectId = connectId || ""; 
            this.ncName = "";
            this.nc = null;
            // - 建立的连接类型 Server | Device
            this.connType = NPPILY.Enum.ConnectionType.Server;
            // - 建立的连接状态 Idle | Connecting | Connected | Failed
            this.status = NPPILY.Enum.ConnectionStatus.Idle;
            this.connParam = (connParam instanceof NPPILY.Struct.ConnParamStruct ? connParam : new NPPILY.Struct.ConnParamStruct());
            // - 建立的连接句柄，连接成功时有效
            this.session = null;
			// - 用户连接ID（CUID）
			this.CUID = null;
            this.systemName = "";
			this.userPriority = 1;
            this.domainRoad = [];
            // - 连接设备时可用
            this.resource = []; 
        },
		
		/*
        ---
        fn: WindowContainerStruct 
        desc: 窗口容器信息结构
        author:
            - zenghx  
            - huzw 
        time: 2013.09.05 
        params: 
            - container(string) 窗口插件的容器Dom对象
            - type(NPPILY.Enum.WindowType) 窗口类型对象
			- active(boolean) 窗口是否被激活
			- _window(NPPILY.Struct.WindowStruct) 窗口信息结构
			- description(object) 正在播放的视频资源描述 
        ... 
        */
		WindowContainerStruct : function (container, type, active, _window, description) 
		{
            this.container = (container && typeof container != "undefined" ? container : "");
            this.type = (type != NPPILY.Enum.WindowType.VOD ? NPPILY.Enum.WindowType.VIDEO : type);
            this.active = !!(active == true);
            this.window = (_window && typeof _window != "undefined" ? _window : null);
            this.description = (typeof description != "undefined" ? description : {});
        },
		
		/*
        ---
        fn: WindowStruct
        desc: 窗口信息结构
        author: 
			- huzw
			- zenghx
        mdftime: 2013.10.18
        params:
			- options(object) 可选参数
			{
				container(element) 窗口插件容器，优先判断container，其次containerId
				containerId(string) 窗口插件容器ID
				type(NPPILY.Enum.WindowType) 窗口类型	
				wnd(element) 窗口插件实例，优先判断wnd，其次wndName
				wndName(string) 窗口插件实例ID
				connectId(string) 连接ID
				wndHandle(string) 窗口插件实例句柄
				status(object) 视频状态参数
				style(object) 窗口样式（保留）
				customParams(object) 自定义参数
			}
        ...
        */
		WindowStruct : function (options) 
		{
			var _SELF = this;
			
			var options = options || {};
			
			this.type = typeof options.type != "undefined" && options.type == NPPILY.Enum.WindowType.VOD ? NPPILY.Enum.WindowType.VOD : NPPILY.Enum.WindowType.VIDEO;
			this.container = 
			(
				function() 
				{
					if (typeof options.container != "undefined" && typeof options.container.id != "undefined")
					{
						_SELF.containerId = options.container.id || document.getElementById(options.containerId || "");
						return options.container;
					}
					else
					{
						_SELF.containerId = options.containerId || "";
						return document.getElementById(_SELF.options.containerId);
					}
				}
			)();
			this.wnd = 
			(
				function() 
				{
					if (typeof options.wnd != "undefined" && typeof options.wnd.id != "undefined")
					{
						_SELF.wndName = options.wnd.id || document.getElementById(options.wndName || "");
						return options.wnd;
					}
					else
					{
						_SELF.wndName = options.wndName || "";
						return document.getElementById(_SELF.options.wndName);
					}
				}
			)();
			this.wndHandle = options.wndHandle || "";
			this.connectId = options.connectId || "";
			this.params = 
			{
				puid : "", // - 设备PUID
				idx : "", // - 资源索引 
				streamType : // - 默认播放流类型
				(
					function()
					{
						if (_SELF.type == NPPILY.Enum.WindowType.VIDEO)
						{
							return NPPILY.Enum.NrcapStreamType.REALTIME;
						}
						else
						{
							return NPPILY.Enum.NrcapStreamType.STORAGE;	
						}
					}
				)(),
				ivStreamHandle : "" , // - 视频流句柄
				iaStreamHandle : "" , // - 音频流句柄
				alg : "", // - 平台转码流编码算法
				resolution : "", // - 平台转码流分辨率
				bitRate : "", // - 平台转码流码率
				frameRate : "", // - 平台转码流帧率
				speed : 0, // - 点播速度
				relativeStartTime : 0, // - 相对文件播放开始时间
				beginTime : 0, // - 点播开始时间
				endTime : 0, // - 点播结束时间
				fileFullPath : null, // - 点播文件全路径 
				fileTimeLength : 0 // - 点播文件时长
			};
			this.status = 
			{
				isddrawing : (options.status ? !!(options.status.isddrawing == true) : false), islittledecodelib : (options.status ? !!(options.status.islittledecodelib == true) : false), 
				playvideoing : (options.status ? !!(options.status.playvoding == true) : false), 
				isplaybyP2P : (options.status ? !!(options.status.isplaybyP2P == true) : false), playaudioing : (options.status ? !!(options.status.playaudioing == true) : false), 
				recording : (options.status ? !!(options.status.recording == true) : false), playvideoing : (options.status ? !!(options.status.playvideoing == true) : false),
				playvoding : (options.status ? !!(options.status.playvoding == true) : false), isfullscreening: (options.status ? !!(options.status.isfullscreening == true) : false)
			};
			this.customParams = options.customParams || {};
			this.style = 
			{
				enableFullScreen : (options.style ? !!(options.style.enableFullScreen == true) : false),
				enableMask : (options.style ? !!(options.style.enableMask == true) : false), 
				enableMainPopMenu : (options.style ? !!(options.style.enableMainPopMenu == true) : true) 
			};
			this.SetStyle = function (style) 
			{
				var v = style ? !!(style.enableFullScreen == true) : false;
				this.style.enableFullScreen = v;
				// this.wnd.enableFullScreen(v ? 1 : 0);
				var v = style ? !!(style.enableMask == true) : false;
				this.style.enableMask = v;
				// this.wnd.enableMask(v ? 1 : 0);
				var v = style ? !!(style.enableMainPopMenu == true) : false;
				this.style.enableMainPopMenu = v;
				// this.wnd.enableMainPopMenu(v ? 1 : 0);
			};
		},
        
		/*
        ---
        fn: NCObjectNotifyStruct 
        desc: NC事件回调信息结构
        author:
            - zenghx  
            - huzw 
        time: 2013.09.16 
        params: 
            - eventName(string) 事件名称
            - _HANDLE(string) 句柄
			- status(number) 状态
			- errorCode(number) 错误码
			- keyData(object) 核心数据
        ... 
        */
		NCObjectNotifyStruct : function(eventName, _HANDLE, status, errorCode, keyData)
		{
			this.eventName = eventName || "";
			this._HANDLE = _HANDLE || "";
			if (typeof status != "undefined" && status != null && status !== "")
			{
				this.status = status || "0";
				this.statusDesc = "";
				if (NPPILY.Enum.StreamStatusDesc[this.status])
				{
					this.statusDesc = NPPILY.Enum.StreamStatusDesc[this.status][NPPILY.language] || "";
				}
			}
			this.errorCode = typeof errorCode != "undefined" ? (errorCode || "0") : "0";
			this.keyData =  typeof keyData != "undefined" ? (keyData || {}) : {};
		},
		
		/*
        ---
        fn: WindowEventStruct 
        desc: 窗口事件信息结构
        author:
            - zenghx  
            - huzw 
        time: 2013.09.26 
        params: 
			- lbtn_click(object) 鼠标左键点击
			- select_rect(object) 矩形框选择
			- ptz_control(object) 云台控制
			- fsw_show(object) 显示全屏
			- fsw_hide(object) 关闭全屏
			- redraw_window(object) 重绘窗口
			- menu_command(object) 自定义右键菜单项
        */
		WindowEventStruct : function(lbtn_click, select_rect, ptz_control, fsw_show, fsw_hide, redraw_window, menu_command)
		{
			// - 鼠标左键点击
			this.lbtn_click = 
			{
				name : "lbtn_click",
				status : (typeof lbtn_click != "undefined" && typeof lbtn_click.status != "undefined" ? !!(lbtn_click.status == true) : false),
				callback : (typeof lbtn_click != "undefined" && typeof lbtn_click.callback != "undefined" && lbtn_click.callback.constructor == Function ? lbtn_click.callback : function(){})
			};
			// - 矩形框选择
			this.select_rect = 
			{
				name: "select_rect",
				status : (typeof select_rect != "undefined" && typeof select_rect.status != "undefined" ? !!(select_rect.status == true) : false),
				callback : (typeof select_rect != "undefined" && typeof select_rect.callback != "undefined" && select_rect.callback.constructor == Function ? select_rect.callback : function(){})
			};
			
			// - 云台控制（拖拽、鼠标滚轮事件）
			this.ptz_control = 
			{
				name : "",
				status : (typeof ptz_control != "undefined" && typeof ptz_control.status != "undefined" ? !!(ptz_control.status == true) : false),
				callback : (typeof ptz_control != "undefined" && typeof ptz_control.callback != "undefined" && ptz_control.callback.constructor == Function ? ptz_control.callback : function(){}),
				
				// - 向上拖拽
				drag_up : {
					name : "drag_up",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.drag_up != "undefined" && typeof ptz_control.drag_up.status != "undefined" ? !!(ptz_control.drag_up.status == true) : true),
					callback : function() {}
				},
				// - 向下拖拽
				drag_down : 
				{
					name : "drag_down",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.drag_down != "undefined" && typeof ptz_control.drag_down.status != "undefined" ? !!(ptz_control.drag_down.status == true) : true),
					callback : function() {}
				},
				// - 向左拖拽
				drag_left : 
				{
					name : "drag_left",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.drag_left != "undefined" && typeof ptz_control.drag_left.status != "undefined" ? !!(ptz_control.drag_left.status == true) : true),
					callback : function() {}
				},
				// - 向右拖拽
				drag_right : 
				{
					name : "drag_right",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.drag_right != "undefined" && typeof ptz_control.drag_right.status != "undefined" ? !!(ptz_control.drag_right.status == true) : true),
					callback : function() {}
				},
				// - 停止拖拽
				drag_stop : 
				{
					name : "drag_stop",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.drag_stop != "undefined" && typeof ptz_control.drag_stop.status != "undefined" ? !!(ptz_control.drag_stop.status == true) : true),
					callback : function() {}
				},
				// - 鼠标滚轮向前
				mws_forward : 
				{
					name : "mouse_wheel_scroll_forward",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.mws_forward != "undefined" && typeof ptz_control.mws_forward.status != "undefined" ? !!(ptz_control.mws_forward.status == true) : true),
					callback : function() {}
				},
				// - 鼠标滚轮向后
				mws_backward : 
				{
					name : "mouse_wheel_scroll_backward",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.mws_backward != "undefined" && typeof ptz_control.mws_backward.status != "undefined" ? !!(ptz_control.mws_backward.status == true) : true),
					callback : function() {}
				},
				// - 停止鼠标滚轮
				mws_stop : 
				{
					name : "mouse_wheel_scroll_stop",
					status : (typeof ptz_control != "undefined" && typeof ptz_control.mws_stop != "undefined" && typeof ptz_control.mws_stop.status != "undefined" ? !!(ptz_control.mws_stop.status == true) : true),
					callback : function() {}
				}
			}; 
			
			// - 显示全屏
			this.fsw_show = 
			{
				name : "full_screen_window_show",
				status : (typeof fsw_show != "undefined" && typeof fsw_show.status != "undefined" ? !!(fsw_show.status == true) : true),
				callback : (typeof fsw_show != "undefined" && typeof fsw_show.callback != "undefined" && fsw_show.callback.constructor == Function ? fsw_show.callback : function(){})
			};
			// - 关闭全屏
			this.fsw_hide = 
			{
				name : "full_screen_window_hide",
				status : (typeof fsw_hide != "undefined" && typeof fsw_hide.status != "undefined" ? !!(fsw_hide.status == true) : true),
				callback : (typeof fsw_hide != "undefined" && typeof fsw_hide.callback != "undefined" && fsw_hide.callback.constructor == Function ? fsw_hide.callback : function(){})
			};
			// - 重绘窗口
			this.redraw_window =
			{
				name : "redraw_window",
				status : (typeof redraw_window != "undefined" && typeof redraw_window.status != "undefined" ? !!(redraw_window.status == true) : true),
				callback : (typeof redraw_window != "undefined" && typeof redraw_window.callback != "undefined" && redraw_window.callback.constructor == Function ? redraw_window.callback : function(){})
			},
			// - 自定义右键菜单项
			this.menu_command =
			{
				name : "menu_command",
				status : (typeof menu_command != "undefined" && typeof menu_command.status != "undefined" ? !!(menu_command.status == true) : false),
				callback : (typeof menu_command != "undefined" && typeof menu_command.callback != "undefined" && menu_command.callback.constructor == Function ? menu_command.callback : function(){}),
				menu : (function(_menuCommand) {
					if (typeof _menuCommand != "undefined" && typeof _menuCommand.menu == "object")
					{
						if (_menuCommand.menu.constructor != Array)
						{
							_menuCommand.menu = [_menuCommand.menu];
						}
						return _menuCommand.menu || [];
					}
					return [];
				})(menu_command)
			};
		},
		/*
        ---
        fn: WindowTextAddStruct
        desc: 视频窗口叠加文字信息结构
        time: 2013.10.15
        author: 
        	- huzw
        params:	- 10 -
			- wndBlockNo(number) 字符叠加的序号（默认为0）
			- left(number) 叠加字幕的横向坐标,取值范围不限
			- top(number) 叠加字幕的纵向坐标,取值范围不限
			- width(number) 每个字符的宽度,没有范围,视情况而定
			- height(number) 每个字符的高度,没有范围,视情况而定
			- color(string)  RGB(r,g,b)计算出来的值
			- enableTilt(number) 0表示不倾斜,1表示倾斜,默认不倾斜
			- enableUnderline(number) 0表示不带下划线,1表示带下划线,默认不带下划线
			- fontFamily(string) 字体的字样,宋体,华文行楷,隶书等等,此参数的最大长度为64
			- content(string) 叠加的字符,最大长度128　
        remark:
			- 在本地主机上对视频窗口进行叠加自定义文字
			- wndBlockNo
				= 同时支持16块叠加区域,可用序号0到15整型
				= 就是一个视频窗口最多可以叠加16个自定义的字符串
			- color RGB(r,g,b)计算得出的整数值
				= r(red), g(green), b(blue) -> value of 0~255
				= 公式为(65536 * b + 256 * g + r)
        ... 
        */
		WindowTextAddStruct : function (wndBlockNo, left, top, width, height, color, enableTilt, enableUnderline, fontFamily, content)
		{
            this.wndBlockNo = wndBlockNo || 0;
            this.left = left || 0;
            this.top = top || 0;
            this.width = width || 0;
            this.height = height || 0;
            this.color = isNaN(color) ? 0 : (color || 0);
            this.enableTilt = (isNaN(enableTilt) || NPPUtils.Array.indexOf([0, 1], enableTilt) == -1) ? 0 : (enableTilt || 0);
            this.enableUnderline = (isNaN(enableUnderline) || NPPUtils.Array.indexOf([0, 1], enableUnderline) == -1) ? 0 : (enableUnderline || 0);
            this.fontFamily = fontFamily || "";
            this.content = content || "";
		},
		/*
        ---
        fn: SCIVDateFileStruct
        desc: 中心存储文件信息结构
        time: 2013.10.30
        author: 
        	- huzw
        params:	- 10 -
			- fileName(string) 文件名称
			- filePath(string) 文件平台保存根目录
			- fileSize(uint) 文件大小，单位字节
			- beginTime(UTC timestamp) 文件开始时间
			- endTime(UTC timestamp) 文件结束时间
			- reason(String|Array) 文件原因（最终以英文竖线|连接多个原因字符串）
			- csuPuid(stirng) 中心存储器PUID
			- csuIndex(uint) 中心存储单元资源索引，缺省为0
			- puid(string) 所属设备PUID
			- type(string) 所属资源类型，一般固定为NPPILY.Enum.PuResourceType.VideoIn
			- idx(uint) 所属资源索引，缺省为0
        ... 
        */
		SCIVDateFileStruct : function (fileName, filePath, fileSize, beginTime, endTime, reason, csuPuid, csuIndex, puid, type, idx)
		{
			this.fileName = fileName || "";
			this.filePath = filePath || "";
			this.fileSize = typeof fileSize != "undefined" && !isNaN(fileSize) ? fileSize : 0;
			this.beginTime = typeof beginTime != "undefined" && !isNaN(beginTime) ? beginTime : 0;
			this.endTime = typeof endTime != "undefined" && !isNaN(endTime) ? endTime : 0;
			if (typeof reason == "object" && reason.constructor == Array)
			{
				reason = reason.join("|");
			}
			this.reason = reason || "";
			this.csuPuid = typeof csuPuid != "undefined" ? csuPuid : "";
			this.csuIndex = typeof csuIndex != "undefined" && !isNaN(csuIndex) ? csuIndex : 0;
			this.puid = typeof puid != "undefined" ? puid : ""; 
			this.type = type || NPPILY.Enum.PuResourceType.VideoIn;
			this.idx = typeof idx != "undefined" && !isNaN(idx) ? idx : 0;
		},
		/*
        ---
        fn: CEFSRecordStruct
        desc: 前端CEFS录像文件信息结构
        time: 2013.11.08
        author: 
        	- huzw
        params:
			- needNextQuery(boolean) 是否需要下次查询
			- beginTime(UTC timestamp) 文件开始时间
			- endTime(UTC timestamp) 文件结束时间
			- bitRate(uint) 这段录像的平均码率，单位kbps，可以估计出这段录像的大小
			- reason(NPPILY.Enum.CEFSRecordReason) 文件原因
			- puid(string) 所属设备PUID
			- resIdx(uint) 所属资源索引，缺省为0
		remark:
			- nextQueryBeginTime(UTC timestamp) 下次查询时间（needNextQuery=true时有此节点）
			- resType(string) 所属资源类型，一般固定为NPPILY.Enum.PuResourceType.VideoIn
        ... 
        */
		CEFSRecordStruct : function (needNextQuery, beginTime, endTime, bitRate, reason, puid, resIdx)
		{
			this.needNextQuery = typeof needNextQuery != "undefined" && needNextQuery == true ? true : false;
			if (this.needNextQuery == true)
			{
				this.nextQueryBeginTime = typeof beginTime != "undefined" && !isNaN(beginTime) ? beginTime : 0; 	
			}
			this.beginTime = typeof beginTime != "undefined" && !isNaN(beginTime) ? beginTime : 0; 
			this.endTime = typeof endTime != "undefined" && !isNaN(endTime) ? endTime : 0;
			this.bitRate = typeof bitRate != "undefined" && !isNaN(bitRate) ? bitRate : 0;
			this.reason = reason || "";
			this.puid = puid || "";
			this.resType = NPPILY.Enum.PuResourceType.VideoIn;
			this.resIdx = typeof resIdx != "undefined" && !isNaN(resIdx) ? resIdx : 0;
		},
		/*
        ---
        fn: CEFSPictureStruct
        desc: 前端CEFS图片文件信息结构
        time: 2013.11.08
        author: 
        	- huzw
        params:
			- needNextQuery(boolean) 是否需要下次查询
			- time(UTC timestamp) 文件开始时间
			- noInSecond(uint) 秒内编号，一秒内可能有多个图片
			- reason(NPPILY.Enum.CEFSPictureReason) 文件原因
			- puid(string) 所属设备PUID
			- resIdx(uint) 所属资源索引，缺省为0
		remark:
			- nextQueryBeginTime(UTC timestamp) 下次查询时间（needNextQuery=true时有此节点）
			- resType(string) 所属资源类型，一般固定为NPPILY.Enum.PuResourceType.VideoIn
        ...
        */
		CEFSPictureStruct : function (needNextQuery, time, noInSecond, reason, puid, resIdx)
		{
			this.needNextQuery = typeof needNextQuery != "undefined" && needNextQuery == true ? true : false;
			if (this.needNextQuery == true)
			{
				this.nextQueryBeginTime = typeof time != "undefined" && !isNaN(time) ? time : 0; 	
			}
			this.time = typeof time != "undefined" && !isNaN(time) ? time : 0;
			this.noInSecond = typeof noInSecond != "undefined" && !isNaN(noInSecond) ? noInSecond : 0;
			this.reason = reason || "";
			this.puid = puid || "";
			this.resType = NPPILY.Enum.PuResourceType.VideoIn;
			this.resIdx = typeof resIdx != "undefined" && !isNaN(resIdx) ? resIdx : 0;
		},
		/*
        ---
        fn: CEFSUserLogStruct
        desc: 前端CEFS用户日志信息结构
        time: 2013.11.08
        author: 
        	- huzw
        params:
			- needNextQuery(boolean) 是否需要下次查询
			- time(UTC timestamp) 文件开始时间
			- type(NPPILY.Enum.CEFSUserLogType) 用户日志类型
			- data(string) 用户日志数据（Base64编码的）
			- puid(string) 所属设备PUID
		remark:
			- nextQueryBeginTime(UTC timestamp) 下次查询时间（needNextQuery=true时有此节点）
        ...
        */
		CEFSUserLogStruct : function (needNextQuery, time, type, data, puid)
		{
			this.needNextQuery = typeof needNextQuery != "undefined" && needNextQuery == true ? true : false;
			if (this.needNextQuery == true)
			{
				this.nextQueryBeginTime = typeof time != "undefined" && !isNaN(time) ? time : 0; 	
			}
			this.time = typeof time != "undefined" && !isNaN(time) ? time : 0;
			this.type = type || "";
			this.data = data || "";
			this.puid = puid || "";
		},
		/*
        ---
        fn: CEFSAlarmEventStruct
        desc: 前端CEFS报警事件信息结构
        time: 2013.11.08
        author: 
        	- huzw
        params:
			- needNextQuery(boolean) 是否需要下次查询
			- time(UTC timestamp) 文件开始时间
			- type(NPPILY.Enum.CEFSAlarmEventType) 报警事件类型
			- data(string) 报警事件数据（Base64编码的）
			- puid(string) 所属设备PUID
			- resIdx(uint) 所属资源索引，缺省为
		remark:
			- nextQueryBeginTime(UTC timestamp) 下次查询时间（needNextQuery=true时有此节点）
			- resType(string) 所属资源类型，一般固定为NPPILY.Enum.PuResourceType.AlertIn
        ...
        */
		CEFSAlarmEventStruct : function (needNextQuery, time, type, data, puid, resIdx)
		{
			this.needNextQuery = typeof needNextQuery != "undefined" && needNextQuery == true ? true : false;
			if (this.needNextQuery == true)
			{
				this.nextQueryBeginTime = typeof time != "undefined" && !isNaN(time) ? time : 0; 	
			}
			this.time = typeof time != "undefined" && !isNaN(time) ? time : 0;
			this.type = type || "";
			this.data = data || "";
			this.puid = puid || "";
			this.resType = NPPILY.Enum.PuResourceType.AlertIn;
			this.resIdx = typeof resIdx != "undefined" && !isNaN(resIdx) ? resIdx : 0;
		},
		/*
        ---
        fn: CEFSGPSDataStruct
        desc: 前端GPS数据信息结构
        time: 2013.11.08
        author: 
        	- huzw
        params:
			- needNextQuery(boolean) 是否需要下次查询
			- time(UTC timestamp) 文件开始时间
			- latitude(uint) 纬度,浮点型字符串,取值范围[-90,90],北纬为正,南纬为负
			- longitude(uint) 经度,浮点型字符串,取值范围[-180,180),东经为正,西经为负
			- bearing(uint) 方向,浮点型字符串,取值范围[0,360),正北为0,正东为90,依次类推.
			- speed(uint) 速度,浮点型字符串,单位km/h
			- altitude(uint)海拔,浮点型字符串,单位m,小于等于-50000表示无效.
			- offlineFlag(uint) 离线标识,1表示下线是存的数据,0表示实时数据.
			- state(uint) GPS状态,0表示正常,1表示无信号,2表示无模块.
			- maxSpeed(uint) 最高限速,整型字符串,单位km/h
			- minSpeed(uint) 最低限速,整型字符串,单位km/h
			- puid(string) 所属设备PUID
		remark:
			- nextQueryBeginTime(UTC timestamp) 下次查询时间（needNextQuery=true时有此节点）
        ...
        */
		CEFSGPSDataStruct : function (needNextQuery, time, latitude, longitude, bearing, speed, altitude, offlineFlag, state, maxSpeed, minSpeed, puid)
		{
			this.needNextQuery = typeof needNextQuery != "undefined" && needNextQuery == true ? true : false;
			if (this.needNextQuery == true)
			{
				this.nextQueryBeginTime = typeof time != "undefined" && !isNaN(time) ? time : 0; 	
			}
			this.time = typeof time != "undefined" && !isNaN(time) ? time : 0;
			this.latitude = typeof latitude != "undefined" && !isNaN(latitude) ? latitude : 0;
			this.longitude = typeof longitude != "undefined" && !isNaN(longitude) ? longitude : 0;
			this.bearing = typeof bearing != "undefined" && !isNaN(bearing) ? bearing : 0;
			this.speed = typeof speed != "undefined" && !isNaN(speed) ? speed : 0;
			this.altitude = typeof altitude != "undefined" && !isNaN(altitude) ? altitude : 0;
			this.offlineFlag = typeof offlineFlag != "undefined" && !isNaN(offlineFlag) ? offlineFlag : 0;
			this.state = typeof state != "undefined" && !isNaN(state) ? state : 0;
			this.maxSpeed = typeof maxSpeed != "undefined" && !isNaN(maxSpeed) ? maxSpeed : 0;
			this.minSpeed = typeof minSpeed != "undefined" && !isNaN(minSpeed) ? minSpeed : 0;
			this.puid = puid || "";
		},
		
		/*
		---
		fn: CommonResDescriptionStruct
		desc: 资源描述信息结构
		author:
			- huzw
		time: 2013.11.14
		...
		*/
		CommonResDescriptionStruct : function (puid, resType, resIdx, name, description, enable)
		{
			this.puid = (typeof puid != "undefined" ? puid : "");
            this.resType = (typeof resType != "undefined" ? resType : "");
            this.resIdx = (typeof resIdx != "undefined" ? resIdx : "0");
            this.name = (typeof name != "undefined" ? name : "");
            this.description = (typeof description != "undefined" ? description : "");
            this.enable = (typeof enable != "undefined" ? enable : "1");
		},
		// - ：平台存储计划信息结构
		PlatformStoragePlanStruct : function (name, guard, cycle, cycleParam, guardTimeMap, serialNo, serialToken)
		{
            this.name = (typeof name != "undefined" ? name : "");
            this.guard = (typeof guard != "undefined" ? guard : "1");
            this.cycle = (typeof cycle != "undefined" ? cycle : "");
            this.cycleParam = (typeof cycleParam != "undefined" ? cycleParam : "");
            this.guardTimeMap = (typeof guardTimeMap != "undefined" ? guardTimeMap : "");
            this.serialNo = (typeof serialNo != "undefined" ? serialNo : "");
            this.serialToken = (typeof serialToken != "undefined" ? serialToken : "");
        },
		// - 平台存储计划资源信息结构
		PlatformStoragePlanResourceStruct: function (name, puid, resType, resIdx, optID, value)
		{
         	this.name = (typeof name != "undefined" ? name : "");
            this.puid = (typeof puid != "undefined" ? puid : "");
            this.resType = (typeof resType != "undefined" ? resType : "");
            this.resIdx = (typeof resIdx != "undefined" ? resIdx : "");
            this.optID = (typeof optID != "undefined" ? optID : "");
            this.value = (value != null || typeof value != "undefined" ? value : "");
        },
		
        // - 平台事件日志结构
        PlatformEventLogResourceStruct : function (puid, resType, resIdx, optID, value)
        {
        	
        },
        
		// - GPS数据存储资源结构
		GPSDataStorageResourceStruct : function (puid, resType, resIdx, optID, value)
		{
			this.puid = (typeof puid != "undefined" ? puid : "");
            this.resType = (typeof resType != "undefined" && resType ? resType : NPPILY.Enum.PuResourceType.GPS);
			this.resIdx = typeof resIdx != "undefined" && !isNaN(resIdx) ? resIdx : 0;;
            this.optID = (typeof optID != "undefined" ? optID : "");
            this.value = (value != null || typeof value != "undefined" ? value : NPPILY.Enum.NrcapStreamType.REALTIME);
		},
		// - 中心存储GPS数据文件信息结构
		CSUGPSDataFileStruct : function (time, latitude, longitude, bearing, speed, altitude, state, maxSpeed, minSpeed, timestamp, puid, resType, resIdx)
		{
			this.time = typeof time != "undefined" && !isNaN(time) ? time : 0;
			this.latitude = typeof latitude != "undefined" && !isNaN(latitude) ? latitude : 0;
			this.longitude = typeof longitude != "undefined" && !isNaN(longitude) ? longitude : 0;
			this.bearing = typeof bearing != "undefined" && !isNaN(bearing) ? bearing : 0;
			this.speed = typeof speed != "undefined" && !isNaN(speed) ? speed : 0;
			this.altitude = typeof altitude != "undefined" && !isNaN(altitude) ? altitude : 0;
			this.state = typeof state != "undefined" && !isNaN(state) ? state : 0;
			this.maxSpeed = typeof maxSpeed != "undefined" && !isNaN(maxSpeed) ? maxSpeed : 0;
			this.minSpeed = typeof minSpeed != "undefined" && !isNaN(minSpeed) ? minSpeed : 0;
			this.timestamp = typeof timestamp != "undefined" && !isNaN(timestamp) ? timestamp : 0;
			this.puid = puid || "";
			this.resType = resType || NPPILY.Enum.PuResourceType.GPS;
			this.resIdx = typeof resIdx != "undefined" && !isNaN(resIdx) ? resIdx : 0;;
		},
		
		// - 网络文件下载状态结构
        HttpDownloadStatusStruct: function (flag, desc, speed, total, current)
		{
            this.flag = flag || 0;
            this.description = desc || "";
            this.speed = speed || 0;
            this.totalLength = total || 0;
            this.currentLength = current || 0;
        },
		
        end : true 
    },
    // - 枚举对象
    Enum : 
    { 
		// - 流类型
        NrcapStreamType : NPPIF.Enum.NrcapStreamType,
		
		// - 云台控制命令
		PTZDirection : NPPIF.Enum.PTZDirection,
		
		// - NC对象方法列表
		NCObjectMethodList : NPPIF.Enum.NCObjectMethodList,
		
        // - 浏览器类型 
        BrowserType : 
		{
            "IE" : "IE", 
			"Chrome" : "Chrome",
			"FireFox" : "FireFox",
			"Other" : "Other" 
        },
        /*
        ---
        author:
                - huzw
        time: 2013.09.03
        remark:
            - NPPILYSDK支持的语言
        ...
        */
        LanguageType : 
		{
            zh_CN : "zh_CN", /* 中文 */
            en : "en" /* 英文 */
        },
        // - 建立的连接类型
        ConnectionType : 
		{
            Server : "Server", // - 连接C7平台服务器
            Device : "Device" // - 直连设备
        },
        // - 建立的连接状态
        ConnectionStatus : 
        {
            Idle : "Idle", // - 初始状态
            Connecting : "Connecting", // - 正在建立连接
            Connected : "Connected", // - 连接已建立
            Failed : "Failed" // - 建立连接失败
        },
		// - 请求的命令类型
		CmdType :
		{
			"GET" : "GET", // - 获取命令
			"SET" : "SET", // - 设置命令
			"PREV" : "PREV", // - 预览命令
			"CTL" : "CTL" // - 控制命令
		},
		/*
        ---
        author:
            - huzw
        time: 2013.10.18
        remark:
            - 窗口信息结构类型
        ...
        */
		WindowType : 
		{
			VIDEO : "VIDEO", // - 实时视频
			VOD : "VOD" // - 录像回放
		},
		// - 存储文件类型
		StorageFileType :
		{
			Platform : "Platform", // - 中心存储
			CEFS : "CEFS", // - 前端CEFS存储
			FAT32 : "FAT32" // - 前端FAT32存储		
		},
		// - CEFS查询命令
		CEFSRequestID : 
		{
			QueryRecordDate : "QueryRecordDate", // - 查询录像日期命令
			QueryRecord : "QueryRecord", // - 查询录像命令
			QueryLinkActionRecord : "QueryLinkActionRecord", // - 查询联动录像命令
			QueryPictureDate : "QueryPictureDate", // - 查询图片日期命令
			QueryPicture : "QueryPicture", // - 查询图片命令
			QueryLinkActionPicture : "QueryLinkActionPicture", // - 查询联动抓图命令
			QueryPictureHalfHour : "QueryPictureHalfHour", // - 查询半小时图片命令
			QueryUserLog : "QueryUserLog", // - 查询用户日志命令
			QueryUserLogDate : "QueryUserLogDate", // - 查询用户日志日期命令
			QueryUserLogHalfHour : "QueryUserLogHalfHour", // - 查询半小时用户日志命令
			QueryAlarmEvent : "QueryAlarmEvent", // - 查询报警事件命令
			QueryAlarmEventDate : "QueryAlarmEventDate", // - 查询报警事件日期命令
			QueryAlarmEventHalfHour : "QueryAlarmEventHalfHour", // - 查询半小时报警事件命令
			QueryGPSData : "QueryGPSData", // - GPS数据查询命令
			QueryGPSDataDate : "QueryGPSDataDate" // - 查询GPS数据日期命令
		},
		// - CEFS录像原因
		CEFSRecordReason :
		{
			Schedule : "Schedule", // - 前端计划录像
			Manual : "Manual", // - 手动录像
			AlertIn : "LinkAction(AlertIn)", // - 联动录像（发生报警）
			MotionDetected : "LinkAction(MotionDetected)", // - 联动录像（侦测到移动）
			SignalLost : "LinkAction(SignalLost)" // - 联动录像（视频信号丢失）
		},
		// - CEFS录像原因描述
		CEFSRecordReasonDesc :
		{
			Schedule : {"zh_CN" : "前端计划录像", "en" : "Front plan video"},
			Manual : {"zh_CN" : "手动录像", "en" : "Menual video"},
			"LinkAction(AlertIn)" : {"zh_CN" : "联动录像（发生报警）", "en" : "LinkAction video(Alarm)"},
			"LinkAction(MotionDetected)" : {"zh_CN" : "联动录像（侦测到移动）", "en" : "LinkAction video(Motion Detected)"},
			"LinkAction(SignalLost)" : {"zh_CN" : "联动录像（视频信号丢失）", "en" : "LinkAction video(Signal Lost)"}
		},
		// - CEFS抓拍原因
		CEFSPictureReason :
		{
			Schedule : "Schedule", // - 前端抓拍录像
			Manual : "Manual", // - 手动抓拍
			AlertIn : "LinkAction(AlertIn)", // - 联动抓拍（发生报警）
			MotionDetected : "LinkAction(MotionDetected)", // - 联动抓拍（侦测到移动）
			SignalLost : "LinkAction(SignalLost)" // - 联动抓拍（视频信号丢失）
		},
		// - CEFS抓拍原因描述
		CEFSPictureReasonDesc :
		{
			Schedule : {"zh_CN" : "前端抓拍录像", "en" : "Front plan snapshot"},
			Manual : {"zh_CN" : "手动抓拍", "en" : "Menual snapshot"},
			"LinkAction(AlertIn)" : {"zh_CN" : "联动抓拍（发生报警）", "en" : "LinkAction snapshot(Alarm)"},
			"LinkAction(MotionDetected)" : {"zh_CN" : "联动抓拍（侦测到移动）", "en" : "LinkAction snapshot(Motion Detected)"},
			"LinkAction(SignalLost)" : {"zh_CN" : "联动抓拍（视频信号丢失）", "en" : "LinkAction snapshot(Signal Lost)"}
		},
		// CEFS用户日志类型
		CEFSUserLogType :
		{
			UserLogin : "UserLogin", // - 用户登录
			UserLogout : "UserLogout", // - 用户退出
			Booted : "Booted", // - 系统启动
			Reboot : "Reboot", // - 系统重启
			AdjustTime : "AdjustTime", // - 修改系统时间
			Formatted : "Formatted", // - 完成格式化
			OpenDoor : "OpenDoor", // - 打开挡板
			CloseDoor : "CloseDoor", // - 关闭挡板
			PowerOff : "PowerOff" // - 系统关机
		},
		// CEFS用户日志类型描述
		CEFSUserLogTypeDesc :
		{
			UserLogin : {"zh_CN" : "用户登录", "en" : "User Logon"},
			UserLogout : {"zh_CN" : "用户退出", "en" : "User Logoff"},
			Booted : {"zh_CN" : "系统启动", "en" : "System Start"},
			Reboot : {"zh_CN" : "系统重启", "en" : "System Reboot"},
			AdjustTime : {"zh_CN" : "修改系统时间", "en" : "Modify System Time"},
			Formatted : {"zh_CN" : "完成格式化", "en" : "Done Format"},
			OpenDoor : {"zh_CN" : "打开挡板", "en" : "Open Baffle plate"},
			CloseDoor : {"zh_CN" : "关闭挡板", "en" : "Close Baffle plate"},
			PowerOff : {"zh_CN" : "系统关机", "en" : "System Power Off"}
		},
		// - 报警事件类型
		CEFSAlarmEventType : 
		{
			AlertIn : "AlertIn", // - 报警输入发生报警
			MotionDetected : "MotionDetected", // - 视频侦测到移动
			SignalLost : "SignalLost" // - 视频信号丢失
		},
		// - 报警事件类型描述
		CEFSAlarmEventTypeDesc : 
		{
			AlertIn : {"zh_CN" : "报警输入发生报警", "en" : "Alarm"}, 
			MotionDetected : {"zh_CN" : "视频侦测到移动", "en" : "Motion Detected"}, 
			SignalLost : {"zh_CN" : "视频信号丢失", "en" : "Signal Lost"} 
		},
		/*
        ---
        author:
            - huzw
        time: 2013.09.05
        remark:
            - 获取或构建资源级别
        ...
        */
		ForkResourceLevel : 
		{
			nppForkPUInfo : "nppForkPUInfo", // - 获取PU节点信息
			nppForkPUResourceInfo : "nppForkPUResourceInfo", // - 获取PU节点资源信息
			nppForkOnePUInfo : "nppForkOnePUInfo" // - 获取一个PU节点信息
		},
		/*
        ---
        author:
                - huzw
        time: 2013.09.09
        remark:
            - 设备类型
        ...
        */
		PuModelType :
		{
			"ENC" : "ENC", /* 有线编码器 */
		    "WENC" : "WENC", /* 无线编码器 */
		    "DEC" : "DEC", /* 有线解码器 */
		    "WDEC" : "WDEC", /* 无线解码器 */
		    "CSU" : "CSU", /* 中心存储单元 */
		    "ESU" : "ESU" /* 企业自建存储单元 */
		},
		/*
        ---
        author:
                - huzw
        time: 2013.09.05
        remark:
            - 资源类型
        ...
        */
		PuResourceType : 
		{
			"GPS" : "GPS", /* GPS模块 */
		    "WIFI" : "WIFI", /* WIFI模块 */
		    "AudioIn" : "IA", /* 输入音频 */
		    "AlertIn" : "IDL", /* 输入报警 */
		    "AudioOut" : "OA", /* 输出音频 */
		    "AlertOut" : "ODL", /* 输出报警 */
		    "VideoIn" : "IV", /* 输入视频 */
		    "VideoOut" : "OV", /* 输出视频 */
		    "PTZ" : "PTZ", /* 云台 */
		    "SELF" : "SELF", /* 设备本身 */
		    "Storager" : "SG", /* 存储器(前端存储) */
		    "SC" : "SC", /* 存储器(中心存储) */
		    "SerialPort" : "SP", /* 设备串口 */
		    "Wireless" : "WM" /* 无线模块 */
		},
		
		// - 计划取值范围
		PlanCycleValue :
		{
			Weekly : "Weekly", // - 每周
			Everyday : "Everyday", // - 每天
			Once : "Once" // - 一次性
		},
		/*
        ---
        author:
                - huzw
        time: 2013.09.09
        remark:
            - nc事件对象
        ...
        */
		NCObjectNotify :
		{
			"event_notify" : "event_notify", /* 接收平台（设备）事件通知 */
		    "stream_status_notify" : "stream_status_notify", /* 接收流状态通知 */
		    "gps_data_notify" : "gps_data_notify", /* 接收GPS信息通知 */
			"copy_file_notify" : "copy_file_notify" /* 外接磁盘存储拷贝文件通知 */
		},		
		// - 流状态描述
		StreamStatusDesc : {
			"-1" : {"zh_CN" : "流已断开", "en" : "Stream Broken"}, // - 流已断开
			"0" : {"zh_CN" : "正在缓冲", "en" : "Buffering"}, // - 正在缓冲
			"1" : {"zh_CN" : "正在播放", "en" : "Playing"}, // - 正在播放
			"2" : {"zh_CN" : "正在下载", "en" : "Downloading"}, // - 正在下载
			"3" : {"zh_CN" : "正在上传", "en" : "Uploading"}, // - 正在上传
			"4" : {"zh_CN" : "下载完成", "en" : "Completed"} // - 下载完成
		},	
		// - 外接磁盘下载状态描述
		RecordQRCopyFileStatusDesc : {
			"-1" : {"zh_CN" : "下载异常", "en" : "Threading"}, // - 流已断开
			"0" : {"zh_CN" : "正在下载", "en" : "Downloading"}, // - 正在缓冲
			"1" : {"zh_CN" : "下载完成", "en" : "Completed"} // - 下载完成
		},
        // - 温馨提示
        "warmTip" : 
        {
            "zh_CN" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<b>温馨提示</b>]插件装载失败，请您检查一下是否成功安装插件！&nbsp;&nbsp;<a href=\"#(0)\">这里下载</a>&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"window.location.reload();\">刷新重试</a><br />", 
            "en" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<b>Warning</b>]Plug-in load failed, please check whether it was installed plug-in success or not!&nbsp;&nbsp;<a href=\"#(0)\">Download here</a>&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"window.location.reload();\">Refresh page</a><br />",
			NCNotLastVersion :
			{
				"zh_CN" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<b>温馨提示</b>]插件装载失败，经检测本机已安装的插件不是最新版本的插件！请点击<a href=\"#(0)\">这里</a>下载最新版本的插件，然后关闭网页再手动进行安装！&nbsp;<a href=\"javascript:void(0);\" onclick=\"window.location.reload();\">刷新重试</a><br />", 
				"en" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<b>Warning</b>]Failed to load plug-in, after testing the machine installed plugin is not the latest version of the plugin! Please click <a href=\"#(0)\">Here</a> to download the last new verion plug-in, next step to close the webpage then manually install it! &nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"window.location.reload();\">Refresh page</a><br />",
				end: true
			},
            end : true 
        },
		
		// - 网络文件下载状态描述
		HttpDownloadStatusDesc : 
		{
			"-1" : {"zh_CN" : "下载失败", "en" : "Failed"},
			"0" : {"zh_CN" : "下载完成", "en" : "Completed"},
			"1" : {"zh_CN" : "正在下载", "en" : "Downloading"}
		},
		
        end : true 
    },
	
    end : true
};
