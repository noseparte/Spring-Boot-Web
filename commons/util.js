function myBrowser(){
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
    var isFF = userAgent.indexOf("Firefox") > -1; //判断是否Firefox浏览器
    var isSafari = userAgent.indexOf("Safari") > -1; //判断是否Safari浏览器
    var isChrome = userAgent.indexOf("Chrome") > -1; //判断是否Chrome浏览器
    if (isIE) {
        var IE5 = IE55 = IE6 = IE7 = IE8 = IE10 = IE11 = false;
        var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
        reIE.test(userAgent);
        var fIEVersion = parseFloat(RegExp["$1"]);
        IE55 = fIEVersion == 5.5;
        IE6 = fIEVersion == 6.0;
        IE7 = fIEVersion == 7.0;
        IE8 = fIEVersion == 8.0;
        IE10 = fIEVersion == 10.0;
        IE11 = fIEVersion == 11.0;
        if (IE55) {
            return "IE55";
        }
        if (IE6) {
            return "IE6";
        }
        if (IE7) {
            return "IE7";
        }
        if (IE8) {
            return "IE8";
        }
        if (IE10) {
            return "IE10";
        }
        if (IE11) {
            return "IE11";
        }
    }//isIE end
    if (isFF) {
        return "FF";
    }
    if (isOpera) {
        return "Opera";
    }
    if(isChrome){
    	return "Chrome";
    }
}//myBrowser() end
/**获取浏览器版本.*/
function getBrowser(){
    //注意关键字大小写
    var ua_str = navigator.userAgent.toLowerCase(), ie_Tridents, trident, match_str, ie_aer_rv, browser_chi_Type;
    //判断IE 浏览器, 
    if("ActiveXObject" in self){
        // ie_aer_rv:  指示IE 的版本.
        // It can be affected by the current document mode of IE.
        ie_aer_rv= (match_str = ua_str.match(/msie ([\d.]+)/)) ? match_str[1] : (match_str = ua_str.match(/rv:([\d.]+)/)) ?match_str[1] : 0;
        // ie: Indicate the really version of current IE browser.
        ie_Tridents = {"trident/7.0": 11, "trident/6.0": 10, "trident/5.0": 9, "trident/4.0": 8};
        //匹配 ie8, ie11, edge
        trident = (match_str = ua_str.match(/(trident|edge\/[\d.]+)/)) ?match_str[1] : undefined;
        browser_chi_Type = (ie_Tridents[trident] || ie_aer_rv) > 0 ? "ie" : undefined;
    }else{
		//判断 windows edge 浏览器
        // match_str[1]: 返回浏览器及版本号,如: "edge/13.10586"
        // match_str[1]: 返回版本号,如: "edge" 
		browser_chi_Type = (match_str = ua_str.match(/edge\/([\d.]+)/)) ? "edge" :
        //判断firefox 浏览器
          (match_str = ua_str.match(/firefox\/([\d.]+)/)) ? "firefox" : 
        //判断chrome 浏览器
          (match_str = ua_str.match(/chrome\/([\d.]+)/)) ? "chrome" : 
        //判断opera 浏览器
          (match_str = ua_str.match(/opera.([\d.]+)/)) ? "opera" : 
        //判断safari 浏览器
          (match_str = ua_str.match(/version\/([\d.]+).*safari/)) ? "safari" : undefined;
    }
    //返回浏览器类型和版本号
    return browser_chi_Type;
}
//Javascript下载文件
function downloadFile(fileName, aLinkHref){
	var aLink = document.createElement("a"),
    evt = document.createEvent("HTMLEvents");
    evt.initEvent("click", false, true);
    aLink.download = fileName;
    aLink.href = aLinkHref;
    aLink.dispatchEvent(evt);
}
function downloadFileOther(aLinkHref){
	try{ 
        var elemIF = document.createElement("iframe");   
        elemIF.src = aLinkHref;
        elemIF.style.display = "none";
        document.body.appendChild(elemIF);
    }catch(e){
    	console.info(e);
    } 
}