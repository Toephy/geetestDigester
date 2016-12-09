<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <script src="http://code.jquery.com/jquery-1.12.3.min.js"></script>
    <script src="http://static.geetest.com/static/tools/gt.js"></script>

    <script>
        $(document).ready(function () {
            $.ajax({

                url: "/digester/geetest?t=" + (new Date()).getTime(), // 加随机数防止缓存
//                url: "gt.json",
                type: "get",
                dataType: "json",
                success: function (data) {
                    // 使用initGeetest接口
                    // 参数1：配置参数
                    // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
                    initGeetest({
                        gt: data.gt,
                        challenge: data.challenge,
                        product: "embed",
                        offline: !data.success
                    }, handlerEmbed);
                }
            });

            var handlerEmbed = function (captchaObj) {
                // $("#embed-submit").click(function (e) {
                // var validate = captchaObj.getValidate();
                // if (!validate) {
                //// $("#notice")[0].className = "show";
                //// setTimeout(function () {
                //// $("#notice")[0].className = "hide";
                //// }, 2000);
                // e.preventDefault();
                // }
                // });
                // 将验证码加到id为captcha的元素里
                captchaObj.appendTo("#embed-captcha");
                captchaObj.onReady(function () {
                    $("#wait")[0].className = "hide";
                });
            };
        });
    </script>
</head>

<body>
<div>

</div>
<div class="exp-demo">
    <form class="exp-embed-form" action="/validata-pc" method="post">
        <div class="box">
            <div class="box-label">用户名</div>
            <input disabled placeholder="geetest" id="user" value="geetest">
        </div>
        <div class="box">
            <div class="box-label">密码</div>
            <input disabled placeholder="******" id="password" value="******">
        </div>
        <div class="box">
            <div class="box-label">滑动完成验证</div>
            <div class="box-embed-captcha" id="embed-captcha">
            </div>
            <p id="wait" class="show">正在加载验证码......</p>
            <!--<p id="notice" class="hide">请先拖动验证码到相应位置</p>-->
            <!--<input type="submit" id="embed-submit" value="提交" >-->
        </div>
    </form>
</div>
</body>

</html>
