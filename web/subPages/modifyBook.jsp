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
    <title>修改图书</title>
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
        修改图书信息
    </h1>
    <div class="container">
        <table border = "0" class ="">
            <tbody>
            <tr>
                <td>图书编号：</td>
                <td><input type="text" id = "bookCode" ></td>
                <td>图书名称：</td>
                <td><input type="text" id = "bookName"></td>
            </tr>
            <tr>
                <td>图书类型：</td>
                <td>
                    <select name="" id="typeName">
                        <option value="0">请选择</option>
                    </select>

                   </td>
                <td>作者：</td>
                <td><input type="text" id = "bookAuthor"></td>
            </tr>
            <tr>
                <td>出版社：</td>
                <td><input type="text" id = "publishPress"></td>
                <td>是否借阅：</td>
                <td>
                    <select name="" id="borrowed">
                        <option value="0">未借阅</option>
                        <option value="1">已借阅</option>
                    </select>
                </td>
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
                <td colspan="4">

                    <input type="button" value ="修改" id = "btnModify">
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
    $(function(){

        $.ajax({
            url:'../getTypeList',
            type:'get',
            dataType:'json',
            success:function(data){

                if(data!=null){
                    $("#typeName").html("<option value = 0>请选择</option>");
                    $(data).each(function(index,item){
                        $("#typeName").append("<option value = "+item.id+">"+item.typeName+"</option>")
                    })
                }

                var bid = getUrlParam("bid");
                $.ajax({
                    url:'../getBook',
                    type:'get',
                    data:{id:bid},
                    dataType:'json',
                    success:function(data){
                        $("#bookCode").val(data.bookCode);
                        $("#bookName").val(data.bookName);
                        $("#typeName").find("option[value = '"+data.bookType+"']").attr("selected",true);
                        $("#bookAuthor").val(data.bookAuthor);
                        $("#publishPress").val(data.publishPress);
                        if(data.borrowed==0){
                            $("#borrowed>option").attr("selected",false).eq(0).attr("selected",true);
                        }else{
                            $("#borrowed>option").attr("selected",false).eq(1).attr("selected",true);
                        }
                        $("#createBy").val(data.createBy);
                        $("#creationTime").val(getLocalTime(data.creationTime));
                    }
                })
            }
        });



        $("#btnBack").on("click",function(){
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            parent.layer.close(index);
        });

        $("#btnModify").on("click",function(){
            var book = {};
            book.bookId = getUrlParam("bid");
            book.bookCode=$("#bookCode").val().trim();
            book.bookName=$("#bookName").val().trim();

            /*选择列表id*/
            book.bookType=$("#typeName").val().trim();
            book.bookAuthor=$("#bookAuthor").val().trim();
            book.publishPress=$("#publishPress").val().trim();
            book.borrowed=$("#borrowed").val().trim();
            $.ajax({
                url:"../modifyBook",
                type:'post',
                data:book,
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
        })
    })
</script>
