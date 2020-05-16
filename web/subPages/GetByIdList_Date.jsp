<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/7 0007
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>图书详情</title>
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
        查看图书信息
    </h1>
    <div class="container">

        <div class="tableList">
            <table border='1' cellspacing="0" class="layui-table" lay-even="" lay-skin="row">

                <thead>
                <tr>
                    <th>序号</th>
                    <th>评论编号</th>
                    <th>评论内容</th>
                    <th>评论人</th>
                    <th>评论时间</th>
                </tr>
                </thead>

                <tbody id="tableBody">

                </tbody>

                <tfoot>
                    <input type="button" value ="返回" id="back"></td>
                </tfoot>
            </table>

        </div>
    </div>
</div>

</body>
</html>
<script>
    $(function(){

        var bid = getUrlParam("bid");


        $.ajax({
            url:"../getNewsComments",
            type:"get",
            data:{id:bid},
            dataType:"json",
            success:function(result){
                console.log(result);
                $("#tableBody").html("");
                $(result).each(function (index,item) {
                    $("#tableBody").append("<tr><td>"+(index+1)+"</td>" +
                        "<td>"+item.id+"</td>" +
                        "<td>"+item.content+"</td>" +
                        "<td>"+item.author+"</td>" +
                        "<td>"+(item.createDate == undefined?'2019-12-15':item.createDate)+"</td></tr>")
                })
            }
        })


        $("#back").on("click",function(){
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            parent.layer.close(index);
        })
    })
</script>
