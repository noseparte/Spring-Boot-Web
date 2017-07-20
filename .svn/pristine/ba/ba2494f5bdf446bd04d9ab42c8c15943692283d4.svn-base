//选项卡
$(function () {

    //通过遍历给菜单项加上data-index属性
    $(".J_menuItem").each(function (index) {
        if (!$(this).attr('data-index')) {
            $(this).attr('data-index', index);
        }
    });

    function menuItem() {

        // 获取标识数据
        var dataUrl = $(this).attr('href'),
            dataIndex = $(this).data('index'),
            menuName = $.trim($(this).text()),
            flag = true;

        // 选项卡菜单已存在
        $('.J_menuTab').each(function () {
            if ($(this).data('id') == dataUrl) {
                if (!$(this).hasClass('active')) {
                    $(this).addClass('active').siblings('.J_menuTab').removeClass('active');

                    // 显示tab对应的内容区
                    $('.J_mainContent .J_iframe').each(function () {
                        if ($(this).data('id') == dataUrl) {
                            $(this).show().siblings('.J_iframe').hide();
                            return false;
                        }
                    });
                }
                flag = false;
                return false;
            }
        });

        // 选项卡菜单不存在
        if (flag) {
            var str = '<a href="javascript:;" class="active J_menuTab" data-id="' + dataUrl + '">' + menuName + ' <i class="fa fa-times-circle"></i></a>';
            $('.J_menuTab').removeClass('active');

            // 添加选项卡对应的iframe
            var str1 = '<iframe class="J_iframe" name="iframe' + dataIndex + '" width="100%" height="100%" src="' + dataUrl + '" frameborder="0" data-id="' + dataUrl + '" seamless></iframe>';
            $('.J_mainContent').find('iframe.J_iframe').hide().parents('.J_mainContent').append(str1);

            //显示loading提示
            var loading = layer.load();

            $('.J_mainContent iframe:visible').load(function () {
                //iframe加载完成后隐藏loading提示
                layer.close(loading);
            });


            // 添加选项卡
            $('.J_menuTabs .page-tabs-content').append(str);

            // 总宽度
            var countWidth = $(".content-tabs").width() - 80;

            // 可视区域宽度
            var visibleWidth = $('.page-tabs-content').width();

            // 可视区域的宽度大于总宽度
            if (visibleWidth > countWidth) {

                // 移动元素的marginLeft值
                var marginLeftVal = parseInt($('.page-tabs-content').css('margin-left'));
                var areaWidth = visibleWidth - countWidth
                $('.page-tabs-content').animate({
                    marginLeft: '-' + areaWidth + 'px'
                }, "fast");
            }

        }

        return false;
    }
    $('.J_menuItem').on('click', menuItem);

    // 关闭选项卡菜单
    function closeTab() {

        var closeTabId = $(this).parents('.J_menuTab').data('id');
        var currentWidth = $(this).parents('.J_menuTab').width();

        // 当前元素处于活动状态
        if ($(this).parents('.J_menuTab').hasClass('active')) {

            // 当前元素后面有同辈元素，使后面的一个元素处于活动状态
            if ($(this).parents('.J_menuTab').next('.J_menuTab').size()) {

                var activeId = $(this).parents('.J_menuTab').next('.J_menuTab:eq(0)').data('id');
                $(this).parents('.J_menuTab').next('.J_menuTab:eq(0)').addClass('active');

                $('.J_mainContent .J_iframe').each(function () {
                    if ($(this).data('id') == activeId) {
                        $(this).show().siblings('.J_iframe').hide();
                        return false;
                    }
                });

                var marginLeftVal = parseInt($('.page-tabs-content').css('margin-left'));
                console.log((marginLeftVal + currentWidth));
                if (marginLeftVal < 0) {
                    $('.page-tabs-content').animate({
                        marginLeft: (marginLeftVal + currentWidth) + 'px'
                    }, "fast");
                }

                //  移除当前选项卡
                $(this).parents('.J_menuTab').remove();

                // 移除tab对应的内容区
                $('.J_mainContent .J_iframe').each(function () {
                    if ($(this).data('id') == closeTabId) {
                        $(this).remove();
                        return false;
                    }
                });


            }

            // 当前元素后面没有同辈元素，使当前元素的上一个元素处于活动状态
            if ($(this).parents('.J_menuTab').prev('.J_menuTab').size()) {
                var activeId = $(this).parents('.J_menuTab').prev('.J_menuTab:last').data('id');
                $(this).parents('.J_menuTab').prev('.J_menuTab:last').addClass('active');
                $('.J_mainContent .J_iframe').each(function () {
                    if ($(this).data('id') == activeId) {
                        $(this).show().siblings('.J_iframe').hide();
                        return false;
                    }
                });

                //  移除当前选项卡
                $(this).parents('.J_menuTab').remove();

                // 移除tab对应的内容区
                $('.J_mainContent .J_iframe').each(function () {
                    if ($(this).data('id') == closeTabId) {
                        $(this).remove();
                        return false;
                    }
                });
            }

        }

        // 当前元素不处于活动状态
        else {

            //  移除当前选项卡
            $(this).parents('.J_menuTab').remove();

            // 移除相应tab对应的内容区
            $('.J_mainContent .J_iframe').each(function () {
                if ($(this).data('id') == closeTabId) {
                    $(this).remove();
                    return false;
                }
            });
        }

        // 总宽度
        var countWidth = $(".content-tabs").width() - 80;

        // 可视区域宽度
        var visibleWidth = $('.page-tabs-content').width();

        // 移动元素的marginLeft值
        var marginLeftVal = parseInt($('.page-tabs-content').css('margin-left'));

        // 可视区域的宽度大于总宽度
        if (visibleWidth > countWidth) {

            // 已到左边
            if (marginLeftVal == 0) {
                if (visibleWidth + marginLeftVal > countWidth) {
                    $('.page-tabs-content').animate({
                        marginLeft: marginLeftVal + (-100) + 'px'
                    }, "fast");
                    console.log(1);
                }
                return
            }

            if (marginLeftVal + 100 > 0) {
                $('.page-tabs-content').animate({
                    marginLeft: marginLeftVal - marginLeftVal + 'px'
                }, "fast");
                console.log(2);
                return;
            }

            // 超过左边
            if (marginLeftVal < 0) {
                console.log("3");
                if (visibleWidth > countWidth) {
                    console.log("33")
                    $('.page-tabs-content').animate({
                        marginLeft: marginLeftVal + (100) + 'px'
                    }, "fast");
                    return
                }

            }

        } else if (visibleWidth < countWidth) {
            console.log("else 1");
            if (marginLeftVal + 100 > 0) {
                $('.page-tabs-content').animate({
                    marginLeft: marginLeftVal - marginLeftVal + 'px'
                }, "fast");
                console.log('else' + 2);
                return;
            } else {
                $('.page-tabs-content').animate({
                    marginLeft: marginLeftVal + (100) + 'px'
                }, "fast");
            }
        }

        return false;
    }
    $('.J_menuTabs').on('click', '.J_menuTab i', closeTab);

    // 点击选项卡菜单
    function activeTab() {
        if (!$(this).hasClass('active')) {
            var currentId = $(this).data('id');

            // 显示tab对应的内容区
            $('.J_mainContent .J_iframe').each(function () {
                if ($(this).data('id') == currentId) {
                    $(this).show().siblings('.J_iframe').hide();
                    return false;
                }
            });
            $(this).addClass('active').siblings('.J_menuTab').removeClass('active');
        }
    }
    $('.J_menuTabs').on('click', '.J_menuTab', activeTab);

    //刷新iframe
    function refreshTab() {

        var target = $('.J_iframe[data-id="' + $(this).data('id') + '"]');
        var url = target.attr('src');

        //显示loading提示
        var loading = layer.load();

        target.attr('src', url).load(function () {

            //关闭loading提示
            layer.close(loading);

        });
    }
    $('.J_menuTabs').on('dblclick', '.J_menuTab', refreshTab);

    // 右移按扭
    $('.J_tabRight').on('click', function () {

        // 移动元素的marginLeft值
        var marginLeftVal = parseInt($('.page-tabs-content').css('margin-left'));

        if (marginLeftVal + 100 >= 0) {
            $('.page-tabs-content').animate({
                marginLeft: marginLeftVal - marginLeftVal + 'px'
            }, "fast");
            return;

        }
        if ((marginLeftVal + 100) < 0) {
            $('.page-tabs-content').animate({
                marginLeft: marginLeftVal + 100 + 'px'
            }, "fast");

        }

    });

    // 左移按扭
    $('.J_tabLeft').on('click', function () {

        // 总宽度
        var countWidth = $(".content-tabs").width() - 80;

        // 可视区域宽度
        var visibleWidth = $('.page-tabs-content').width();

        // 移动元素的marginLeft值
        var marginLeftVal = parseInt($('.page-tabs-content').css('margin-left'));

        // 可视区域的宽度大于总宽度
        if (visibleWidth > countWidth) {

            // 已到左边
            if (marginLeftVal == 0) {
                $('.page-tabs-content').animate({
                    marginLeft: marginLeftVal + (-100) + 'px'
                }, "fast");
            }

            // 超过左边
            if (marginLeftVal <= 0) {
                if (visibleWidth + marginLeftVal > countWidth)
                    $('.page-tabs-content').animate({
                        marginLeft: marginLeftVal + (-100) + 'px'
                    }, "fast");
            }

        }
    });
});