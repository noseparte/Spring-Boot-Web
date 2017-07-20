/**
 * Created by mac on 16/6/29.
 */
var WebClient = {
    connectId : null,
    resource : new NPPUtils.Hash(),
    Load:function(){
        try {
            $.browser = {};

            // 首先初始化NPPILY，加载插件
            var operator = NPPILY.Init(new NPPILY.Struct.InitParamStruct(false, null, null));
            if (operator.rv != 0) {
                // 初始化不成功
                alert(NrcapError.Detail(operator.rv));
            }

            // 存储窗口容器信息
            if ($("#windowbox")[0]) {
                // 存放窗口容器信息，只有一个窗口
                NPPILY.WindowContainers.set(
                    "windowbox",
                    new NPPILY.Struct.WindowContainerStruct(
                        $("#windowbox")[0],
                        NPPILY.Enum.WindowType.VIDEO, // 实时视频
                        true, // 只要一个窗口默认是激活的
                        null, // 视频窗口对象开始为空
                        null
                    )
                );
            }

            // 建立连接
            WebClient.Connect();
        }
        catch (e) {
            alert("excep error -> " + e.name + "::" + e.message);
            return false;
        }
    },
    // - 创建连接，连接信息记录在NPPILY.Connections全局变量中
    Connect: function() {
        var path = _npc.connParams.path;
        var username = _npc.connParams.username;
        var password = _npc.connParams.password;
        var epId = _npc.connParams.epId; //登陆参数：企业id
        var bfix = _npc.connParams.bfix;

        // 调用建立连接函数
        var operator = NPPILY.Connect
        (
            new NPPILY.Struct.ConnParamStruct
            (
                path,
                username,
                epId,
                password,
                bfix
            )
        );
        if (operator.rv == 0) {
            // 此即是当前连接ID，记录下来
            WebClient.connectId = operator.response;

            // 注册绑定NC事件回调，所有的视频状态、喊话对讲、音频状态等信息都是通过回调通知
            NPPILY.NCNotifyManager.Add(
                NPPILY.Enum.NCObjectNotify.stream_status_notify,
                function (notify) {
                    // 更新视频状态回调，等有视频播放的时候就会有调用
                    WebClient.UpdateVideoStatus(notify);
                }
            );
        }
        else {
            if ($("#loginMsg").get(0)) {
                $("#loginMsg").html(NrcapError.Detail(operator.rv) + "<br />");
            }
        }
    },
    /*
     获取资源(FetchResource)
     connectId(string) 连接ID
     forkLevel(NPPILY.Enum.ForkResourceLevel) 构建资源级别
     offset(uint) 分页查询开始索引
     count(unit) 分页查询每次最大个数
     */
    FetchResource: function () {
        try {
            var connectId = WebClient.connectId;
            if (!connectId || !NPPILY.Connections.get(connectId)) {
                alert("连接信息不存在，获取资源失败");
                return false;
            }
            var _connStruct = NPPILY.Connections.get(connectId),
                rootName = "",
                resource = [],
                style = "cr",
                offset = 0,
                count = 200,
                html = [];

            if (_connStruct.connType == NPPILY.Enum.ConnectionType.Server) {
                rootName = _connStruct.systemName || "网络视频监控系统";

                while(true) {
                    // 分页获取所有设备资源
                    var operator = NPPILY.ForkResource
                    (
                        connectId,
                        NPPILY.Enum.ForkResourceLevel.nppForkPUInfo,
                        offset,
                        count,
                        "" // 为空获取根平台的资源
                    );
                    if (operator.rv == 0 && operator.response) {
                        resource = resource.concat(operator.response);

                        if (operator.response.length >= count) {
                            // 继续获取
                            offset = offset + count;
                        }
                        else {
                            break;
                        }
                    }
                    else {
                        // 其他错误跳出循环
                        break;
                    }
                };
                // 进行在线排序
                var onlines = [], offlines = [];
                $.each(resource, function (index, item) {
                    if (item.online == 1 && item.enable == 1) {
                        onlines.push(item);
                    }
                    else {
                        offlines.push(item);
                    }
                });
                resource = [];
                resource = resource.concat(onlines);
                resource = resource.concat(offlines);
            }
            else {
                // 直连设备
                var operator = NPPILY.ForkResource(connectId);
                if (operator.rv == 0 && operator.response) {
                    resource = [operator.response];

                    rootName = operator.response.name || "";
                }
            }
            // 记录资源信息
            WebClient.resource.set(connectId, resource);

            if ($("#resourceTree")[0]) {
                var lastnode = "",
                    idRootPfx = style + '_cesSystemManagement';

                html.push('<div id="' + idRootPfx + '" style="white-space:nowrap;margin-top:2px !important; margin-top:2px;">');
                html.push('<input id="'+idRootPfx+'_img_title" type="button" class="minus" onfocus="this.blur();" onclick="WebClient.Expandsion($(\'#'+idRootPfx+'_childresourcebox\')[0], $(\'#'+idRootPfx+'_img_title\')[0]);" />');
                html.push('<input id="'+idRootPfx+'_img_ico" type="button" class="root" onfocus="this.blur();" onclick="WebClient.Expandsion($(\'#'+idRootPfx+'_childresourcebox\')[0], $(\'#'+idRootPfx+'_img_title\')[0]);" />');
                html.push('<a href="javascript:void(0);" onclick="WebClient.Expandsion($(\'#'+idRootPfx+'_childresourcebox\')[0], $(\'#'+idRootPfx+'_img_title\')[0]);" title="' + rootName + '">' + rootName + '</a>');
                html.push('</div>');

                html.push('<div id="'+idRootPfx+'_childresourcebox" class="childresourcebox_blankline" style="padding-left:15px;">');
                // 遍历资源
                $.each(resource, function (index, item) {
                    var prefix = "station", suffix = "_disabled", idPfx = style + "_" + item.puid;

                    if (_connStruct.connType == NPPILY.Enum.ConnectionType.Server) {
                        switch (item.modelType) {
                            case NPPILY.Enum.PuModelType.ENC:
                                prefix = "station";
                                break;
                            case NPPILY.Enum.PuModelType.WENC:
                                prefix = "gateway";
                                break;
                            default:
                                return true;
                                break;
                        }
                    }

                    if (item.online == 1 && item.enable == 1) {
                        suffix = "";
                    }
                    var clsname = prefix + "" + suffix;

                    html.push('<div style="white-space:nowrap;">');
                    html.push('<input id="'+idPfx+'_img_title" type="button" class="plus" onfocus="this.blur();" onclick="WebClient.FetchChildResource(\'' + item.puid + '\', \'' + style + '\');" />');
                    html.push('<input id="'+idPfx+'_img_ico" type="button" class="'+clsname+'" onfocus="this.blur();" onclick="WebClient.FetchChildResource(\'' + item.puid + '\', \'' + style + '\');" />');
                    html.push('<a href="javascript:void(0);" onclick="WebClient.FetchChildResource(\'' + item.puid + '\', \'' + style + '\');" title="' + item.name + '">' + item.name + '</a>');
                    html.push('</div>');
                    html.push('<div id="'+idPfx+'_childresourcebox" class="childresourcebox_directline" style="height:auto;display:none;padding-left:15px;">');
                    html.push('</div>');

                    lastnode = idPfx + '_childresourcebox';
                });
                if (resource.length <= 0) {
                    html.push('<div style="font-style:italic;">（无设备资源）</div>');
                }
                html.push('</div>');

                $("#resourceTree")
                    .html(html.join(""))
                    .find("#" + lastnode)
                    .attr("class", "childresourcebox_blankline");
            }
        }
        catch (e) {
            alert("excep error -> " + e.name + "::" + e.message);
            return false;
        }
    },

    /*获取子资源(FetchChildResource)
     puid(string) 设备PUID
     connectId(string) 连接ID
     forkLevel(NPPILY.Enum.ForkResourceLevel.nppForkPUResourceInfo) 构建资源级别
     */
    FetchChildResource: function (puid, style) {
        try {
            var idPfx = style + "_" + puid,
                idChildresbox = idPfx + "_childresourcebox",
                idPUTitle = idPfx + "_img_title";

            var connectId = WebClient.connectId;
            if (!connectId || !NPPILY.Connections.get(connectId)) {
                alert("连接信息不存在，获取资源失败");
                return false;
            }
            var _connStruct = NPPILY.Connections.get(connectId);

            if ($("#" + idChildresbox)[0]) {
                if ($("#" + idChildresbox).html() == "") {
                    // 是否存在相关子资源信息
                    var puInfo, puChildres = [];
                    $.each(WebClient.resource.get(connectId), function(index, item) {
                        if (item.puid == puid) {
                            puInfo = item;
                            puChildres = item.childResource || [];
                            return false;
                        }
                    });
                    // 为空就去获取子资源信息
                    if (!puChildres || puChildres.length <= 0) {
                        var operator = NPPILY.ForkResource
                        (
                            connectId,
                            NPPILY.Enum.ForkResourceLevel.nppForkPUResourceInfo,
                            null,
                            null,
                            null,
                            {
                                PUID: puid
                            }
                        );
                        if (operator.rv == 0) {
                            puChildres = operator.response;
                        }
                    }

                    var html = [],
                        lastnode = "";

                    if (puInfo && puChildres && puChildres.length > 0) {
                        $.each(puChildres, function (index, item) {
                            var prefix = "inputvideo", suffix = "";

                            if (item.type != NPPILY.Enum.PuResourceType.VideoIn) {
                                return true;
                            }

                            if (puInfo.online == 0 || puInfo.enable == 0 || item.enable == 0) {
                                suffix = "_disabled";
                            }

                            var clsname = prefix + "" + suffix;

                            var idChildPfx = idPfx + "_" + item.type + "_" + item.idx;

                            html.push('<div style="white-space:nowrap;">');
                            html.push('<input id="'+idChildPfx+'_img_title" type="button" class="outline" onfocus="this.blur();" onclick="WebClient.treeCallBack(\'' + puid + '\',\'' + item.idx + '\',\'' + style + '\',\'' + item.name + '\');" />');
                            html.push('<input id="'+idChildPfx+'_img_ico" type="button" class="'+clsname+'" onfocus="this.blur();" onclick="WebClient.treeCallBack(\'' + puid + '\',\'' + item.idx + '\',\'' + style + '\',\'' + item.name + '\');" />');
                            html.push('<a href="javascript:void(0);" onclick="WebClient.treeCallBack(\'' + puid + '\',\'' + item.idx + '\',\'' + style + '\',\'' + item.name + '\');" title="' + item.name + '">' + item.name + '</a>');
                            html.push('</div>');

                            lastnode = idChildPfx + "_img_title";
                        });
                    }
                    else {
                        html.push('<div style="font-style:italic;">（无视频资源）</div>');
                    }

                    $("#" + idChildresbox)
                        .html(html.join(""))
                        .find("#" + lastnode)
                        .attr("class", "endline");

                } // end if html()

                WebClient.Expandsion($("#" + idChildresbox)[0], $("#" + idPUTitle)[0]);
            }
        }
        catch (e) {
            alert("excep error -> " + e.name + "::" + e.message);
            return false;
        }
    },

    treeCallBack: function(puid, idx, type, name) {
        WebClient.PlayVideo(puid, idx, name);
    },
    /*
     创建窗口以及播放：
     connectId(string) 连接ID
     containerOrId(dom element | dom id) 窗口插件容器或ID
     windowType(NPPILY.Enum.WindowType) 窗口类型
     windowAttachEvent(NPPILY.Struct.WindowEventStruct) 绑定窗口事件
     customParams(object) 自定义参数
     wnd 窗口对象
     puid (string) 设备ID
     idx (string)  资源索引
     streamType (string)	流类型
     */
    PlayVideo: function (puid, idx, name) {
        try {
            if (!puid || typeof idx == "undefined") return false;

            // 只含有一个窗口信息
            var node = NPPILY.WindowContainers.get("windowbox");
            if (node) {

                // 是否存在相同的视频在播放中，可以播放不同的视频流，同一流类型只允许播
                if (node.window && node.window.status.playvideoing) {
                    if (node.window.params.puid == puid && node.window.params.idx == idx && node.window.params.streamType == NPPILY.Enum.NrcapStreamType.REALTIME) {
                        alert("请注意该视频已经在播放中...");
                        return false;
                    }
                }

                // 播放视频
                var create = true;
                if (node.window) {
                    create = false;
                    if (node.window.status.playvideoing) {
                        // 原先有播放的就先停止播放
                        WebClient.StopVideo();
                    }
                }

                if (create) {
                    var winevt = new NPPILY.Struct.WindowEventStruct();
                    // 单击事件
                    winevt.lbtn_click.status = true;
                    winevt.lbtn_click.callback = function () {
                        WebClient.ResponseOperation("ActiveWindow");
                    };
                    // 视频窗口（退出）全屏回调
                    winevt.fsw_show.callback = winevt.fsw_hide.callback = function () {
                        WebClient.ResponseOperation("BackFullScreen");
                    };
                    // 窗口内云台控制允许
                    winevt.ptz_control.status = true;
                    // 右键菜单
                    winevt.menu_command.status = true;
                    winevt.menu_command.menu = [{
                        key: "stopvideo", text: "停止视频"
                    }, {
                        key: "playaudio", text: "播放音频"
                    }, {
                        key: "localsnapshot", text: "本地抓拍"
                    }, {
                        key: "localrecord", text: "开启本地录像"
                    }, {
                        key: "separator", text: "first"
                    }, {
                        key: "fullscreen", text: "全屏"
                    }];
                    winevt.menu_command.callback = function (menukey) {
                        WebClient.ResponseOperation("menu_command", menukey);
                    };

                    // - 创建窗口
                    var win_operator = NPPILY.CreateWindow
                    (
                        WebClient.connectId,
                        node.container,
                        NPPILY.Enum.WindowType.VIDEO,
                        winevt
                    );
                    if (win_operator.rv == 0) {
                        node.window = win_operator.response;
                    }
                    else {
                        alert("创建窗口失败 -> " + NrcapError.Detail(win_operator.rv));
                    }
                } // end create

                // 播放视频
                var operator = NPPILY.PlayVideo
                (
                    WebClient.connectId,
                    node.window,
                    puid,
                    idx,
                    NPPILY.Enum.NrcapStreamType.REALTIME // 这里默认播放实时流
                );
                if (operator.rv != 0) {
                    alert("播放视频失败 -> " + NrcapError.Detail(operator.rv));
                }
                else {
                    // 视频名称
                    node.window.customParams.ivName = name;

                    // 把视频插件宽高置为100%自适应窗口容器
                    NPPILY.ResizeWindowDimension(node.window, "100%", "100%");
                }
            }
        }
        catch (e) {
            alert("excep error = " + e.name + "::" + e.message);
            return false;
        }
    },

    // 响应窗口回调
    ResponseOperation: function (action) {
        try {
            switch (action) {
                case "ActiveWindow":
                    $("#loginMsg").html("鼠标单击窗口回调");
                    break;
                case "BackFullScreen":
                    // （退出）全屏回调
                    $("#loginMsg").html("视频窗口（退出）全屏回调");
                    WebClient.BackFullScreen();
                    break;
                case "menu_command":

                    $("#loginMsg").html("点击窗口右键菜单项回调");

                    // 右键菜单项回调
                    var menuKey = arguments[1];
                    switch (menuKey) {
                        case "stopvideo": // 停止视频
                            WebClient.StopVideo();
                            break;
                        case "playaudio": // 播放/停止音频
                            WebClient.PlayAudio();
                            break;
                        case "localsnapshot": // 本地抓拍
                            WebClient.LocalSnapshot();
                            break;
                        case "localrecord": // 本地录像
                            WebClient.LocalRecord();
                            break;
                        case "fullscreen": // （退出）全屏
                            WebClient.FullScreen();
                            break;
                    };
                    break;
            };
        }
        catch (e) {
            alert("excep error = " + e.name + "::" + e.message);
            return false;
        }
    },
    // 响应（退出）全屏事件
    BackFullScreen: function () {
        try {
            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window) {
                var customMenus = [];
                if (node.window.status.isfullscreening) {
                    customMenus.push({key: "fullscreen", text: "退出全屏"});
                }
                else {
                    customMenus.push({key: "fullscreen", text: "全屏"});
                }
                // 更新菜单项
                NPPILY.WindowAttachEvent.UpdateMenuCommand(node.window, customMenus);
            }
        }
        catch (e) {
            alert("excep error = " + e.name + "::" + e.message);
            return false;
        }
    },

    // 停止视频
    StopVideo: function () {
        try {
            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window) {
                var puid = node.window.params.puid;

                // 把设备的喊话对讲先给停止了
                NPPILY.CallTalkControl.Stop(WebClient.connectId, puid, 0);
                // 更新喊话对讲按钮状态
                WebClient.UpdateCallTalkButtonStatus();


                // 然后停止视频
                NPPILY.StopVideo(node.window);
                // 把视频插件宽高置为0，注意本身及其所有祖先容器不可设置成隐藏（尤其在非IE浏览器中）
                NPPILY.ResizeWindowDimension(node.window, 0, 0);

                $("#windowtitle").html("&nbsp;无视频");
                $("#loginMsg").html();
            }
        }
        catch (e) {
            alert("excep error = " + e.name + "::" + e.message);
            return false;
        }
    },

    // 播放/关闭音频
    PlayAudio: function () {
        try {
            var fn = "WebClient.PlayAudio";

            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window) {
                NPPILY.PlayAudio(node.window);
                // 更新菜单项
                if (node.window.status.playvideoing) {
                    var customMenus = [];
                    if (node.window.status.playaudioing) {
                        customMenus.push({key: "playaudio", text: "停止音频"});
                    }
                    else {
                        customMenus.push({key: "playaudio", text: "播放音频"});
                    }
                    NPPILY.WindowAttachEvent.UpdateMenuCommand(node.window, customMenus);
                }
            }
        }
        catch (e) {
        }
    },
    // 本地抓拍
    LocalSnapshot: function () {
        try {
            var fn = "WebClient.LocalSnapshot";

            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window) {
                NPPILY.Snapshot(node.window, "C:/"); // 默认存放在C盘
            }
        }
        catch (e) {
            alert("excep error = " + e.name + "::" + e.message);
            return false;
        }
    },
    // 本地录像
    LocalRecord: function () {
        try {
            var fn = "WebClient.LocalRecord";

            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window) {
                NPPILY.LocalRecord(node.window, "C:/"); // 默认存放在C盘
                // 更新菜单项
                if (node.window.status.playvideoing) {
                    var customMenus = [];
                    if (node.window.status.recording) {
                        customMenus.push({key: "localrecord", text: "停止本地录像"});
                    }
                    else {
                        customMenus.push({key: "localrecord", text: "开启本地录像"});
                    }
                    NPPILY.WindowAttachEvent.UpdateMenuCommand(node.window, customMenus);
                }
            }
        }
        catch (e) {
            alert("excep error = " + e.name + "::" + e.message);
            return false;
        }
    },
    // （退出）全屏
    FullScreen: function (windowKey) {
        try {
            var fn = "WebClient.FullScreen";

            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window) {
                NPPILY.LocalRecord(node.window, "C:/"); // 默认存放在C盘
                if (node.window.status.playvideoing) {
                    if (node.window.status.isfullscreening) {
                        NPPILY.ExitFullScreen(node.window); // 退出全屏
                    }
                    else {
                        NPPILY.FullScreen(node.window); // 全屏
                    }
                }
            }
        }
        catch (e) {
            alert("excep error = " + e.name + "::" + e.message);
            return false;
        }
    },
    // 更新显示视频状态信息
    UpdateVideoStatus: function (notify) {
        try {
            if (notify && notify._HANDLE) {
                NPPILY.WindowContainers.each(function (item) {
                    var node = item.value;
                    if (node.window && node.window.status.playvideoing) {
                        // 根据句柄匹配
                        if (node.window.params.ivStreamHandle == notify._HANDLE) {
                            if (notify.errorCode == 0) {
                                if (notify.status == -1) {
                                    // 流断开，必要时去重新播放视频，这里不做处理了，请自行处理
                                    return false;
                                }

                                var html = [];
                                // 视频名称
                                html.push(node.window.customParams.ivName);
                                if (typeof notify.statusDesc != "undefined" && notify.statusDesc != "") {
                                    html.push("&nbsp;");
                                    html.push(notify.statusDesc);
                                }
                                html.push(",帧率=" + (notify.keyData.frame_rate || 0));
                                html.push(",码率=" + ((notify.keyData.bit_rate || 0)/1000).toFixed(0) + "kb");

                                if (node.window.status.playaudioing) {
                                    html.push(",正在播放声音");
                                }
                                if (node.window.status.recording) {
                                    html.push(",正在录像");
                                }
                                // 是否有喊话对讲
                                var oaStatus_operator = NPPILY.CallTalkControl.GetStatus(WebClient.connectId, node.window.params.puid, 0);
                                if (oaStatus_operator.rv == 0) {
                                    var oaStatus = oaStatus_operator.response;
                                    if (oaStatus && oaStatus.oaStreamHandle) {
                                        html.push(",正在" + (oaStatus.call ? "喊话" : "对讲"));
                                    }
                                }

                                $("#windowtitle")
                                    .html(html.join(""))
                                    .attr("title", html.join("").replace(/(\&nbsp;)/gm, ""));

                            } // end errorCode
                        }
                    }
                });
            }
        }
        catch (e) {
            return false;
        }
    },
    /*
     ---
     desc: 视频窗口区域右侧按钮操作
     remark:
     <div><input type="button" value="关闭" onclick="WebClient.ButtonsOperation('stopvideo');"/></div>
     <div><input type="button" value="向上" onmousedown="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.turnup);" onmouseup="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.stopturn);"/></div>
     <div><input type="button" value="向下" onmousedown="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.turndown);" onmouseup="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.stopturn);"/></div>
     <div><input type="button" value="向左" onmousedown="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.turnleft);" onmouseup="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.stopturn);"/></div>
     <div><input type="button" value="向右" onmousedown="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.turnright);" onmouseup="WebClient.ButtonsOperation('ptzcontrol', NPPIF.Enum.PTZDirection.stopturn);"/></div>
     <div><input type="button" value="抓拍" onclick="WebClient.ButtonsOperation('localsnapshot');"/></div>
     <div><input type="button" value="录像" onclick="WebClient.ButtonsOperation('localrecord');"/></div>
     <div><input type="button" value="音频" onclick="WebClient.ButtonsOperation('playaudio');"/></div>
     <br />
     <div><input id="opt_call" type="button" value="开启喊话" onclick="WebClient.ButtonsOperation('startCall');"/></div>
     <div><input id="opt_talkback" type="button" value="开启对讲" onclick="WebClient.ButtonsOperation('startTalk');"/></div>
     ...
     */
    ButtonsOperation: function (action) {
        try {
            var fn = "WebClient.ButtonsOperation";

            switch (action) {
                case "stopvideo": // 停止视频
                    WebClient.StopVideo();
                    break;
                case "playaudio": // 播放/停止音频
                    WebClient.PlayAudio();
                    break;
                case "localsnapshot": // 本地抓拍
                    WebClient.LocalSnapshot();
                    break;
                case "localrecord": // 本地录像
                    WebClient.LocalRecord();
                    break;
                case "ptzcontrol": // 云台控制
                    WebClient.PTZControl(arguments[1]);
                    break;

                case "startCall":
                case "startTalk":
                    WebClient.CallTalkControl(action);
                    break;
            };
        }
        catch (e) {
            return false;
        }
    },

    // 云台控制
    PTZControl: function (mode) {
        try {
            var node = NPPILY.WindowContainers.get("windowbox");
            if (mode && node && node.window && node.window.status.playvideoing) {
                var puid = node.window.params.puid,
                    ptz_idx = node.window.params.idx; // 云台资源基本上与视频资源一一对应的，这里先不进行判断是否有云台资源

                var operator = NPPILY.PTZ.Control(WebClient.connectId, puid, ptz_idx, mode);
                if (operator.rv != 0) {
                    alert("操作云台失败，错误码：" + operator.rv);
                }
            }
        }
        catch (e) {
            return false;
        }
    },

    // 喊话或对讲控制
    CallTalkControl: function (action) {
        try {
            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window && node.window.status.playvideoing) {
                // 喊话对讲针对的是设备层面，与具体的视频资源没有关系，不应搞对应
                // 这里音频输出资源索引，一般情况下为0，这里没有去判断是否具有音频输出资源，自行判断
                var puid = node.window.params.puid,
                    oa_idx = 0;

                // 判断是否处在喊话对讲中
                var oaStatus_operator = NPPILY.CallTalkControl.GetStatus(WebClient.connectId, puid, oa_idx);
                if (oaStatus_operator.rv == 0) {
                    var oaStatus = oaStatus_operator.response;
                    if (oaStatus) {
                        // 如果喊话对讲句柄存在，那么就处在喊话对讲中
                        if (oaStatus.oaStreamHandle) {
                            var needStop = false;
                            // 如果是同一按钮操作的就应该停止
                            if ((oaStatus.call && action == "startCall") || (oaStatus.talk && action == "startTalk")) {
                                needStop = true;
                            }
                            if (needStop) {
                                // 停止喊话对讲
                                NPPILY.CallTalkControl.Stop(WebClient.connectId, puid, oa_idx);
                            }
                            else {
                                alert("同一个设备的喊话对讲应该互斥操作");
                                return false;
                            }
                        }
                        else {
                            var operator = null;
                            if (action == "startCall") {
                                // 开启喊话
                                operator = NPPILY.CallTalkControl.StartCall(WebClient.connectId, puid, oa_idx);
                            }
                            else {
                                // 开启对讲
                                operator = NPPILY.CallTalkControl.StartTalk(WebClient.connectId, puid, oa_idx);
                            }
                            if (operator.rv != 0) {
                                alert("喊话对讲失败 ->" + NrcapError.Detail(operator.rv));
                            }
                        }

                        // 更新喊话对讲按钮状态
                        WebClient.UpdateCallTalkButtonStatus();
                    }
                }
                else {
                    // 可能不支持喊话或对讲，也可能需要稍候重试即可
                    alert("获取喊话对讲状态失败 ->" + NrcapError.Detail(oaStatus_operator.rv));
                }
            }
        }
        catch (e) {
            return false;
        }
    },
    // 更新喊话对讲按钮状态
    UpdateCallTalkButtonStatus: function () {
        try {

            var node = NPPILY.WindowContainers.get("windowbox");
            if (node && node.window && node.window.status.playvideoing) {
                var puid = node.window.params.puid,
                    oa_idx = 0;
                var oaStatus_operator = NPPILY.CallTalkControl.GetStatus(WebClient.connectId, puid, oa_idx);
                if (oaStatus_operator.rv == 0) {
                    var oaStatus = oaStatus_operator.response;
                    if (oaStatus && oaStatus.oaStreamHandle) {
                        if (oaStatus.call) {
                            $("#opt_call").val("停止喊话");
                        }
                        else {
                            $("#opt_call").val("开启喊话");
                        }
                        if (oaStatus.talk) {
                            $("#opt_talkback").val("停止对讲");
                        }
                        else {
                            $("#opt_talkback").val("开启对讲");
                        }
                        return false;
                    }
                }
            }
            // 其他情况
            $("#opt_call").val("开启喊话");
            $("#opt_talkback").val("开启对讲");
        }
        catch (e) {
            return false;
        }
    },

    // 列表控制
    Expandsion: function (obj, title, ico) {
        if (obj) {
            if (obj.style.display == "none") {
                if (obj.innerHTML == "") return;
                obj.style.display = "block";
                if (title) title.className = "minus";
                if (ico) {
                    ico.className = "stationmodel_expand";
                }
            }
            else {
                obj.style.display = "none";
                if (title) title.className = "plus";
                if (ico) {
                    ico.className = "stationmodel_collapse";
                }
            }
        }
    },

    // - 卸载插件
    UnLoad:function() {
        NPPILY.UnLoad();
    },
    end:true
}

