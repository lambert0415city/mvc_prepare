<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
  <meta charset="utf-8"/>
  <title>在线通讯录--苏中画</title>
  <link href="statics/css/base.css" rel="stylesheet"/>
  <link href="statics/layui/css/layui.css" rel="stylesheet"/>
  <link href="statics/css/index.css" rel="stylesheet"/>

  <script src="statics/js/jquery-3.3.1.min.js"></script>
  <script src="statics/layui/layui.all.js"></script>
  <script src="statics/js/myutil.js"></script>
</head>

<body>
<div class="container">

  <div class="pw">
    <h1>在线通讯录-K9041苏中画--管理员登录</h1>

    <h2 style="margin-right: 10px">Myecplise 起不了 或者没有样式，有问题请用idea直接open file就可以了</h2>
    <h3 style="margin-right: 10px">所有功能细节均已完整实现，真打不开请看代码哟</h3>

    <%--顶部查询--%>
    <div class="searchMain">
      <span>查找联系人：（模糊查询）</span>
      <input type="text" class="layui-form-label" placeholder="请输入要搜索的名字" id="inputSearch">

      <input type="button" class="layui-btn layui-btn-primary layui-btn-sm" value="查询" id="btnQuery">
    </div>

    <div class="operator">
      <button type="button" class="layui-btn layui-btn-normal" id="newBook">
        <i class="layui-icon">&#xe608;</i> 添加
      </button>
      共<span id="totalCount"></span>条数据
    </div>

    <div class="tableList">
      <table border='1' cellspacing="0" class="layui-table" lay-even="" lay-skin="row">

        <thead>
        <tr>
          <th>序号</th>
          <th>编号ID</th>
          <th>姓名</th>
          <th>手机</th>
          <th>QQ</th>
          <th>Email</th>
          <th>地址</th>
          <th>操作</th>
        </tr>
        </thead>

        <tbody id="tableBody">

        </tbody>
      </table>

      <div class="pages">
        第<span id="curPage"></span>/<span id="pageCount"></span>页
        <a href="javascript:firstPage();" class="layui-btn layui-btn-normal layui-btn-radius">首页</a>
        <a href="javascript:prevPage();" class="layui-btn layui-btn-normal layui-btn-radius">上一页</a>
        <a href="javascript:nextPage();" class="layui-btn layui-btn-normal layui-btn-radius">下一页</a>
        <a href="javascript:lastPage();" class="layui-btn layui-btn-normal layui-btn-radius">末页</a>
        <span class="jump">到第</span>
        <input type="text" class="layui-form-label" id="pageGoNum"><span class="jump">页</span>
        <input type="button" class="layui-btn layui-bg-green layui-btn-danger layui-btn-sm " id="btnGo" value="GO">
      </div>

    </div>
  </div>


</div>
</body>
</html>


<script>
  $(function(){

    /*第一次查询调取ajax方法*/
    getPage(null);

  })

  /*顶部查询*/
  $("#btnQuery").on("click", function () {
    if($("#inputSearch").val().trim()==""
    ){
      layer.msg("查询条件不能为空哟");
    }
    firstPage();
  })

  function getPage(param){
    if(param==null){
      param={};
      param.curPage=1;
    }

    /*对应PageParameter，Mapper的参数名*/
    param.searchName = $("#inputSearch").val().trim();


    $.ajax({
      url:"getUsers",
      type:"get",
      data:param,
      dataType:"json",
      success:function(result){

        console.log(result);

        $("#tableBody").html("");
        $(result.contactPage).each(function (index,item) {
          $("#tableBody").append("<tr><td>"+(index+1)+"</td>" +
                  "<td>"+item.id+"</td>" +
                  "<td><button onclick='javascript:change("+item.id+")' class='layui-btn layui-btn-xs layui-bg-red' bid="+item.id+">"+item.cname+"</button></td>" +
                  "<td>"+item.mobile+"</td>" +
                  "<td>"+item.qq+"</td>" +
                  "<td>"+item.email+"</td>" +
                  "<td>"+item.address+"</td>" +
                  "<td><button onclick='javascript:change("+item.id+")' class='layui-btn layui-btn-xs layui-bg-cyan' bid="+item.id+">修改</button>" +
                  "<button onclick='javascript:del("+item.id+")' class='layui-btn layui-btn-xs layui-bg-cyan' bid="+item.id+">删除</button>" +
                  "</td></tr>")
        })
        $("#curPage").text(result.curPage);
        $("#pageCount").text(result.pageCount);
        $("#totalCount").text(result.totalCount);


        if(result.contactPage.length == 0){
          $("#tableBody").html("");
          $("#tableBody").append("<tr><td colspan='0'><span style='color: #FF00FF;font-weight: bold'>没有搜索到与《"+$("#inputSearch").val().trim()+"》相关的任何信息</span></td></tr>");
        }

      }
    })
  }

  $("#newBook").on("click",function(){
    //用layer弹窗
    // window.location.href = "createBook.jsp";
    layer.open({
      type: 2,
      title: '新增联系人',
      shadeClose: true,
      shade: false,
      skin:"layui-layer-molv",
      area: ['800px', '400px'],
      anim:4,
      content: 'subPages/EasyAdd.jsp'
    });
  })

  /*根据id查看*/
  function look(id){
    console.log(id);
    layer.open({
      type:2,
      title:"产看详情",
      shadeClose:true,
      skin:"layui-layer-molv",
      anim:3,
      area:["800px","400px"],
      content:"subPages/detailBook.jsp?bid="+id
    });
  }

  //修改（与增加共享）
  function change(id){
    //用layer弹窗
    // window.location.href = "modifyBook.jsp?bid="+bid;
    layer.open({
      type: 2,
      title: '修改联系人',
      shadeClose: true,
      skin:"layui-layer-molv",
      anim:5,
      area: ['800px', '400px'],
      content: "subPages/easyChange.jsp?bid="+id
    });
  }

  //删除
  function del(id){
    console.log(id);
    if(confirm("确定删除")){
      $.ajax({
        url:"deleteUser",
        type:'post',
        data:{id:id},
        dataType:'json',
        success:function(data){
          console.log(data);
          if(data==true){
            layer.msg('删除成功');
            var p1 = {};
            p1.curPage = parseInt($("#curPage").text().trim());
            getPage(p1);
          }
          else{
            layer.msg('删除成功');
          }
        }
      })
    }

    /*        layer.confirm('确定删除吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                $.ajax({
                    url:"deleteBook",
                    type:'post',
                    data:{bid:bid},
                    dataType:'json',
                    success:function(data){
                        console.log(data);
                        if(data==true){
                            layer.msg('删除成功');

                            var p1 = {};
                            p1.curPage = parseInt($("#curPage").text().trim());
                            getPage(p1);
                        }
                        else{
                            layer.msg('删除失败');
                        }
                    }
                })
            }, function(){
                layer.msg('您放弃了删除');
            });*/
  }

  //查询首页
  function firstPage() {
    var p = {};
    p.curPage = 1;
    getPage(p);
  }

  //查询上一页
  function prevPage() {
    var curPage = parseInt($("#curPage").text().trim());
    var p = {};
    p.curPage = (curPage - 1 > 0 ? curPage - 1 : 1);
    getPage(p);
  }

  //查询下一页
  function nextPage() {
    var curPage = parseInt($("#curPage").text().trim());
    var pageCount = parseInt($("#pageCount").text().trim());
    var p = {};
    p.curPage = (curPage + 1 <= pageCount ? curPage + 1 : pageCount);
    getPage(p);
  }

  //查询末页
  function lastPage() {
    var curPage = parseInt($("#pageCount").text().trim());
    var p = {};
    p.curPage = curPage;
    getPage(p);
  }

</script>
