jQuery(document).ready(function(){
	changeCode();
	jQuery("#codeImg").bind("click", changeCode);
	///// TRANSFORM CHECKBOX /////							
	jQuery('input:checkbox').uniform();
	
	///// LOGIN FORM SUBMIT /////
	jQuery('#login').submit(function(){
	
		if(jQuery('#loginname').val() == '') {
			jQuery('.nousername').fadeIn();
			jQuery('.nopassword').hide();
			jQuery('.nologincode').hide();
			jQuery('.errarginfo').hide();
			jQuery('.errTimeinfo').hide();
			jQuery('.errscodeinfo').hide();
			jQuery('.erruserinfo').hide();
			jQuery('.userVisitorNoStart').hide();
			return false;	
		}
		else if(jQuery('#password').val() == '') {
//			jQuery('.nopassword').fadeIn().find('.userlogged h4, .userlogged a span').text(jQuery('#loginname').val());
			//jQuery('.nousername,.username').hide();
			jQuery('.nousername').hide();
			jQuery('.nologincode').hide();
			jQuery('.nopassword').fadeIn();
			jQuery('.errarginfo').hide();
			jQuery('.errTimeinfo').hide();
			jQuery('.errscodeinfo').hide();
			jQuery('.erruserinfo').hide();
			jQuery('.userVisitorNoStart').hide();
			return false;
		}
		else if(jQuery('#code').val() == '') {
			//jQuery('.nologin_code').fadeIn().find('.userlogged h4, .userlogged a span').text(jQuery('#loginname').val());
			jQuery('.nousername').hide();
			jQuery('.nopassword').hide();
			jQuery('.nologincode').fadeIn();
			jQuery('.errarginfo').hide();
			jQuery('.errTimeinfo').hide();
			jQuery('.errscodeinfo').hide();
			jQuery('.erruserinfo').hide();
			jQuery('.userVisitorNoStart').hide();
			return false;
		}
		else{
			severCheck();
			return false;
		}
	});
	
	///// ADD PLACEHOLDER /////
	jQuery('#loginname').attr('placeholder','请输入账号');
	jQuery('#password').attr('placeholder','请输入密码');
	jQuery('#code').attr('placeholder','请输入验证码');
	//处理cookie 显示记住的账号和密码 
	var loginname = jQuery.cookie('loginname');
	var password = jQuery.cookie('password');
	if (typeof(loginname) != "undefined"
			&& typeof(password) != "undefined" && loginname!=null && password!=null) {
		jQuery("#loginname").val(loginname);
		jQuery("#password").val(password);
		jQuery("#saveid").attr("checked", true);
		jQuery('input:checkbox').uniform();
		jQuery("#code").focus();
	}
	
});

function savePaw() {
	if (!jQuery("#saveid").attr("checked")) {
		jQuery.cookie('loginname', '', {
			expires : -1
		});
		jQuery.cookie('password', '', {
			expires : -1
		});
		jQuery("#loginname").val('');
		jQuery("#password").val('');
	}
}

function saveCookie() {
	if (jQuery("#saveid").attr("checked")) {
		jQuery.cookie('loginname', jQuery("#loginname").val(), {
			expires : 7
		});
		jQuery.cookie('password', jQuery("#password").val(), {
			expires : 7
		});
	}
}

//服务器校验
function severCheck(){
		var loginname = jQuery("#loginname").val();
		var password = jQuery("#password").val();
		var code = "maryunMY"+loginname+",maryun,"+password+"maryunMY"+",maryun,"+jQuery("#code").val();
		jQuery.ajax({
			type: "POST",
			url: 'login_login',
	    	data: {KEYDATA:code,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				console.info(data.result);
				if("success" == data.result){
					saveCookie();
					window.location.href="main/index";
				}else if("usererror" == data.result){
					changeCode();
					jQuery('.nousername').hide();
					jQuery('.nopassword').hide();
					jQuery('.nologincode').hide();
					jQuery('.errarginfo').hide();
					jQuery('.errTimeinfo').hide();
					jQuery('.errscodeinfo').hide();
					jQuery('.erruserinfo').fadeIn();
					jQuery('.userVisitorNoStart').hide();
					jQuery("#loginname").focus();
				}else if("codeerror" == data.result){
					changeCode();
					jQuery('.errscodeinfo').fadeIn();
					jQuery('.nousername').hide();
					jQuery('.nopassword').hide();
					jQuery('.nologincode').hide();
					jQuery('.errarginfo').hide();
					jQuery('.errTimeinfo').hide();
					jQuery('.erruserinfo').hide();
					jQuery('.userVisitorNoStart').hide();
					jQuery("#code").focus();
				}else if("errTimeinfo" == data.result){
					changeCode();
					jQuery('.nousername').hide();
					jQuery('.nopassword').hide();
					jQuery('.nologincode').hide();
					jQuery('.errarginfo').hide();
					jQuery('.errscodeinfo').hide();
					jQuery('.errTimeinfo').fadeIn();
					jQuery('.userVisitorNoStart').hide();
					jQuery("#loginname").focus();
				}else if("userNoStart" == data.result){
					changeCode();
					jQuery('.nousername').hide();
					jQuery('.nopassword').hide();
					jQuery('.nologincode').hide();
					jQuery('.errarginfo').hide();
					jQuery('.errscodeinfo').hide();
					jQuery('.errTimeinfo').hide();
					jQuery('.userVisitorNoStart').fadeIn();
					jQuery("#loginname").focus();
				}else{
					changeCode();
					jQuery('.nousername').hide();
					jQuery('.nopassword').hide();
					jQuery('.nologincode').hide();
					jQuery('.errarginfo').fadeIn();
					jQuery('.errTimeinfo').hide();
					jQuery('.errscodeinfo').hide();
					jQuery('.erruserinfo').hide();
					jQuery('.userVisitorNoStart').hide();
					jQuery("#loginname").focus();
				}
			}
		});
}

function genTimestamp() {
	var time = new Date();
	return time.getTime();
}

function changeCode() {
	jQuery("#codeImg").attr("src", "code.do?t=" + genTimestamp());
}