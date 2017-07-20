/**
 * 
 */
$(function(){
	$('#password').keyup(function () {
		var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
		var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
		var enoughRegex = new RegExp("(?=.{6,}).*", "g");
		if (false == enoughRegex.test($(this).val())) { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass(' pw-defule'); 
			 //密码小于六位的时候，密码强度图片都为灰色 
		} 
		else if (strongRegex.test($(this).val())) { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass(' pw-strong'); 
			 //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
		} 
		else if (mediumRegex.test($(this).val())) { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass(' pw-medium'); 
			 //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
		} 
		else { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass('pw-weak'); 
			 //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
		} 
		return true; 
	});
	$('#newpassword').keyup(function () {
		var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
		var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
		var enoughRegex = new RegExp("(?=.{6,}).*", "g");
		if (false == enoughRegex.test($(this).val())) { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass(' pw-defule'); 
			 //密码小于六位的时候，密码强度图片都为灰色 
		} 
		else if (strongRegex.test($(this).val())) { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass(' pw-strong'); 
			 //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
		} 
		else if (mediumRegex.test($(this).val())) { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass(' pw-medium'); 
			 //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
		} 
		else { 
			$('#passwordLevel').removeClass('pw-weak'); 
			$('#passwordLevel').removeClass('pw-medium'); 
			$('#passwordLevel').removeClass('pw-strong'); 
			$('#passwordLevel').addClass('pw-weak'); 
			 //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
		} 
		return true; 
	});
}) 