//欢迎信息
layer.ready(function () {

    var html = $('#welcome-template').html();
    $('a.viewlog').click(function () {
        parent.layer.open({
            title: '初见倾心',
            type: 1,
            area: ['700px', 'auto'],
            content: html,
            btn: ['确定', '取消']
        });
        return false;
    });

    if ($(this).width() > 768) {
        setTimeout(function () {
            parent.layer.closeAll();
            parent.layer.open({
                title: '欢迎访问H+主页',
                type: 1,
                area: ['700px', 'auto'],
                content: html,
                btn: ['确定', '取消']
            });
        }, 5000);
    }
    
    console.log('欢迎使用H+，请在服务器环境下运行本示例（如localhost等），如果您在使用的过程中有碰到问题，可以参考bootstrap官方文档或具体插件的官方文档，感谢您的支持。');
    console.log('Bootstrap中文文档：http://v3.bootcss.com/');

});