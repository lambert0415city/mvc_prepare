<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>修改</title>
    <link href="../statics/css/base.css" rel="stylesheet"/>
    <link href="../statics/layui/css/layui.css" rel="stylesheet"/>
    <link href="../statics/css/detailBook.css" rel="stylesheet"/>
    <script src="../statics/js/jquery-3.3.1.min.js"></script>
    <script src="../statics/layui/layui.all.js"></script>
    <script src="../statics/js/myutil.js"></script>
</head>
<body>
<div class="pw">
    <h1>
        修改联系人信息(已加入正则判断)
    </h1>
    <div class="container">
        <table border = "0" class ="">
            <tbody>
                <tr>
                    <td>姓名：</td>
                    <td><input type="text" id = "cname" ></td>
                    <td>手机：</td>
                    <td><input type="text" id = "mobile"></td>
                </tr>
                <tr>
                    <td>qq号码：</td>
                    <td><input type="text" id = "qq" ></td>
                    <td>Email 邮件：</td>
                    <td><input type="text" id = "email"></td>
                </tr>
                <tr>
                    <td>联系人地址：</td>
                    <td><input type="text" id = "address" ></td>
                </tr>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="4">
                    <input type="button" value ="修改" id = "btnCreate">
                    <input type="button" value ="返回" id = "btnBack">
                </td>
            </tr>
            </tfoot>
        </table>

    </div>
</div>

</body>
</html>
<script>

    function isPhoneNo(phone) {
        var pattern = /^1\d{10}$/;
        return pattern.test(phone);
    }

    function isQQ(qq) {
        var pattern = /^[0-9]*$/;
        return pattern.test(qq);
    }

    function isEmail(mail) {
        var pattern = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
        return pattern.test(mail);
    }


    $(function(){

        var bid = getUrlParam("bid");

        $.ajax({
            url:'../getUserId',
            type:'get',
            data:{id:bid},
            dataType:'json',
            success:function(data){
                console.log(data);
                console.log(data.cname);
                console.log(data.mobile);
                console.log(data.qq);
                $("#cname").val(data.cname);
                $("#mobile").val(data.mobile);
                $("#qq").val(data.qq);
                $("#email").val(data.email);
                $("#address").val(data.address);
            }
        })

        /*$("#creationTime").val(getLocalTimes(new Date().getTime()));*/


        $("#btnBack").on("click",function(){
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            parent.layer.close(index);
        });

        $("#btnCreate").on("click",function(){
            if($("#cname").val().trim()=="" ||
                $("#mobile").val().trim()=="" ||
                $("#qq").val().trim()=="" ||
                $("#email").val().trim()=="" ||
                $("#address").val().trim()==""
            ){
                layer.msg("姓名/电话/qq/email/address---不能为空！");
            }
            else if (isPhoneNo($.trim($("#mobile").val())) == false) {
                layer.msg("手机号码不正确(1开头，的11位数字)");
            }
            else if (isQQ($.trim($("#qq").val())) == false) {
                layer.msg("qq号码不正确，应该为纯数字");
            }
            else if (isEmail($.trim($("#email").val())) == false) {
                layer.msg("邮箱格式不正确");
            }
            else{
                var param = {};
                param.id = bid;
                param.cname=$("#cname").val().trim();
                param.mobile=$("#mobile").val().trim();
                param.qq=$("#qq").val().trim();
                param.email=$("#email").val().trim();
                param.address=$("#address").val().trim();

                $.ajax({
                    url:"../changeUser",
                    type:'post',
                    data:param,
                    dataType:'json',
                    success:function(data){
                        console.log(data);
                        if(data==true){
                            layer.msg('修改成功');
                            setTimeout(function(){
                                window.parent.location.reload();//刷新父页面
                                var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                                parent.layer.close(index);
                            },500);
                        }
                        else{
                            layer.msg('修改失败');
                        }
                    }
                })
            }

        })
    })
</script>
