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
        <table border = "0" class ="">
            <tbody>
            <tr>
                <td>图书编号：</td>
                <td><input type="text" id = "bookCode" disabled></td>
                <td>图书名称：</td>
                <td><input type="text" id = "bookName"disabled></td>
            </tr>
            <tr>
                <td>图书类型：</td>
                <td><input type="text" id = "typeName"disabled></td>
                <td>作者：</td>
                <td><input type="text" id = "bookAuthor"disabled></td>
            </tr>
            <tr>
                <td>出版社：</td>
                <td><input type="text" id = "publishPress"disabled></td>
                <td>是否借阅：</td>
                <td><input type="text" id = "borrowed"disabled></td>
            </tr>
            <tr>
                <td>入库人：</td>
                <td><input type="text" id = "createBy"disabled></td>
                <td>入库时间：</td>
                <td><input type="text" id = "creationTime"disabled></td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="4"><input type="button" value ="返回"></td>
            </tr>
            </tfoot>
        </table>

    </div>
</div>

</body>
</html>
<script>
    $(function(){
        var bid = getUrlParam("bid");
        $.ajax({
            url:'../getBook',
            type:'get',
            data:{id:bid},
            dataType:'json',
            success:function(data){
                console.log(data);
                $("#bookCode").val(data.bookCode);
                $("#bookName").val(data.bookName);
                $("#typeName").val(data.typeName);
                $("#bookAuthor").val(data.bookAuthor);
                $("#publishPress").val(data.publishPress);
                $("#borrowed").val(data.borrowed==0?"未借阅":"已借阅");
                $("#createBy").val(data.createBy);
                $("#creationTime").val(getLocalTime(data.creationTime));
            }
        })
        $("table>tfoot>tr>td>input[type=button]").on("click",function(){
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            parent.layer.close(index);
        })
    })
</script>
