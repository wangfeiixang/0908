<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="format-detection" content="email=no"/>
    <title>甜橙--我的信息</title>
    <link href="${basePath}/css/common.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}/css/my-info.css" rel="stylesheet" type="text/css"/>
    <link href="${basePath}/head-portrait/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body onload="openMsg()">

<!--  <a id="logox">
         <img id="bgl" src="../../../head-portrait/images/logo_n.png">

     </a>-->

<article class="htmleaf-container">
    <div id="clipArea"></div>
    <div class="foot-use">
        <div class="uploader1 blue">
            <input type="button" name="file" class="button" value="打开">
            <input id="file" type="file" onchange="javascript:setImagePreview();" accept="image/*" multiple  />
        </div>
        <button id="clipBtn">截取</button>
    </div>
    <div id="view"></div>
</article>
<!--<article class="btn-1">
    <button>确认提交</button>
</article>-->


<ul class="help-list">
    <li >
        <a  class="list-o"  id="logox">
            <p class="list-oh">头像</p>
            <c:choose>
                <c:when test="${ empty voUser.userlogourl }">
                    <img src="${basePath}/images/Avatar.png"  class="header"/>
                </c:when>
                <c:otherwise>
                    <img src="${voUser.userlogourl}"  class="header"/>
                </c:otherwise>
            </c:choose>
        </a>
    </li>
    <li>
        <a href="javascript:;" onclick="editNick()">
            <p>昵称</p><span class="font-sah" id="nick">${voUser.nickname}</span><span class="kele"></span>
        </a>
    </li>
    <li>
        <a >
            <p>ID</p><span class="font-sah2">${voUser.userid}</span>
        </a>
    </li>

</ul>
<div style="position: relative">
    <ul class="help-list sele-abso">
        <li>
            <a href="#">
                <p>性别</p><span class="kele"></span>

            </a>
        </li>
        <li>
            <a href="javascript:void(0);" class="bor-b-no">
                <p>地区</p>
            </a>
        </li>
        <li>
            <a href="javascript:void(0);" class="bor-b-no" >

            </a>
        </li>
        <li>
            <a href="javascript:void(0);" class="bor-b-no">
                <p>生日</p><!--<span class="font-sah2">金牛</span>-->
            </a>
        </li>
        <li>
            <a href="javascript:void(0);" class="bor-b-no">

            </a>
        </li>
        <li>
            <a href="#">
                <p>星座</p><span class="font-sah2" id="xzSpan">魔羯座</span>
            </a>
        </li>
    </ul>
    <select class="sele-one" id="sexSel"  onchange="submitSex()">

        <option value="1" selected="selected">男</option>
        <option value="0">女</option>
    </select>

    <div class="info">

        <select id="provinces" name="s_province" class="sele-two" onchange="submitArea()"></select>  
        <select id="citys" name="s_city" class="sele-three" onchange="submitArea()"></select>  
        <!--<select id="s_county" name="s_county"></select>-->

        <div id="show"></div>
    </div>

    <div id="birthday_container">
        <select class="sele-four" name="year" id="year" onchange="submitBirth()">

        </select>
        <select class="sele-five" name="month" id="month"   onchange="submitMonth()">

        </select>
        <select class="sele-six" name="day" id="day"   onchange="submitBirth()">
        </select>
    </div>

    <form id="userForm" method="post" action="${basePath}/user/editUser.do" accept-charset="UTF-8">
        <input type="hidden" name="area" id="areaInput"/>
        <input type="hidden" name="nick" id="nickInput"/>
        <input type="hidden" name="userid" id="uidInput" value="${voUser.userid}"/>
        <input type="hidden" name="sex" id="sexInput"/>
        <input type="hidden" name="birth" id="birthInput"/>
        <input id="md5" name="md5" type="hidden"  />
    </form>

</div>
<div class="toast">当前无网络链接</div>

<div class="eject" style="display: none;">
    <h2 id="ejectTxt">提示成功与失败！</h2>
    <a href="" class="buttonEject">取消</a>
</div>
<div class="bg"></div>

<script src="${basePath}/js/zepto.min.js"></script>
<script src="${basePath}/jsonjs/WebviewLink.json.js"></script>
<script src="${basePath}/jsonjs/base64.js"></script>
<script src="${basePath}/jsonjs/updateUserAuthorizationInformation.json.js"></script>
<script>
    function toastPop(){
        $(".toast").show()
        setTimeout(function(){
            $(".toast").hide();
        },1000)
    };
    //初始化省市
    var linkDatas = {provinces: [{"code": "0","name": "请选择"},{"code":"110000","name":"北京市"},{"code":"120000","name":"天津市"},{"code":"310000","name":"上海市"},{"code":"500000","name":"重庆市"},{"code":"640000","name":"宁夏回族自治区"},{"code":"340000","name":"安徽省"},{"code":"150000","name":"内蒙古自治区"},{"code":"220000","name":"吉林省"},{"code":"430000","name":"湖南省"},{"code":"540000","name":"西藏自治区"},{"code":"460000","name":"海南省"},{"code":"650000","name":"新疆维吾尔自治区"},{"code":"450000","name":"广西壮族自治区"},{"code":"510000","name":"四川省"},{"code":"520000","name":"贵州省"},{"code":"710000","name":"台湾省"},{"code":"230000","name":"黑龙江省"},{"code":"130000","name":"河北省"},{"code":"820000","name":"澳门特别行政区"},{"code":"210000","name":"辽宁省"},{"code":"370000","name":"山东省"},{"code":"330000","name":"浙江省"},{"code":"810000","name":"香港特别行政区"},{"code":"140000","name":"山西省"},{"code":"610000","name":"陕西省"},{"code":"630000","name":"青海省"},{"code":"440000","name":"广东省"},{"code":"320000","name":"江苏省"},{"code":"530000","name":"云南省"},{"code":"360000","name":"江西省"},{"code":"420000","name":"湖北省"},{"code":"410000","name":"河南省"},{"code":"350000","name":"福建省"},{"code":"620000","name":"甘肃省"}],citys: {0: ["请选择"],640000:["银川市","石嘴山市","吴忠市","固原市","中卫市"],340000:["滁州市","铜陵市","宣城市","安庆市","淮北市","合肥市","池州市","阜阳市","亳州市","宿州市","六安市","蚌埠市","芜湖市","马鞍山市","淮南市","黄山市"],150000:["呼和浩特市","兴安盟","包头市","乌海市","锡林郭勒盟","赤峰市","通辽市","鄂尔多斯市","呼伦贝尔市","阿拉善盟","巴彦淖尔市","乌兰察布市"],220000:["长春市","吉林市","延边朝鲜族自治州","四平市","白城市","松原市","白山市","通化市","辽源市"],430000:["长沙市","张家界市","怀化市","永州市","益阳市","岳阳市","娄底市","常德市","衡阳市","邵阳市","湘西土家族苗族自治州","郴州市","株洲市","湘潭市"],540000:["拉萨市","日喀则地区","山南地区","昌都地区","林芝地区","阿里地区","那曲地区"],460000:["海口市","三沙市","三亚市","省直辖"],650000:["乌鲁木齐市","喀什地区","塔城地区","阿勒泰地区","和田地区","博尔塔拉蒙古自治州","克孜勒苏柯尔克孜自治州","伊犁哈萨克自治州","巴音郭楞蒙古自治州","自治区直辖","吐鲁番地区","阿克苏地区","哈密地区","昌吉回族自治州","克拉玛依市"],120000:["天津"],500000:["重庆市"],450000:["来宾市","贵港市","崇左市","玉林市","贺州市","钦州市","防城港市","河池市","南宁市","柳州市","桂林市","百色市","梧州市","北海市"],510000:["达州市","自贡市","雅安市","成都市","巴中市","内江市","阿坝藏族羌族自治州","乐山市","甘孜藏族自治州","绵阳市","遂宁市","凉山彝族自治州","资阳市","眉山市","南充市","广元市","德阳市","宜宾市","泸州市","广安市","攀枝花市"],520000:["黔东南苗族侗族自治州","铜仁市","黔南布依族苗族自治州","贵阳市","黔西南布依族苗族自治州","遵义市","六盘水市","毕节市","安顺市"],710000:["高雄市","台北市","嘉义市","新竹市","台南市","省直辖","台中市","基隆市"],230000:["大兴安岭地区","大庆市","绥化市","黑河市","伊春市","佳木斯市","七台河市","哈尔滨市","齐齐哈尔市","鸡西市","牡丹江市","鹤岗市","双鸭山市"],130000:["廊坊市","秦皇岛市","唐山市","沧州市","石家庄市","衡水市","张家口市","承德市","邯郸市","邢台市","保定市"],820000:["澳门半岛","澳门离岛","无堂区划分区域"],210000:["葫芦岛市","锦州市","朝阳市","丹东市","沈阳市","阜新市","铁岭市","营口市","盘锦市","鞍山市","辽阳市","大连市","本溪市","抚顺市"],370000:["东营市","滨州市","烟台市","菏泽市","临沂市","潍坊市","德州市","济宁市","聊城市","泰安市","莱芜市","青岛市","济南市","日照市","淄博市","威海市","枣庄市"],330000:["湖州市","嘉兴市","丽水市","金华市","台州市","绍兴市","杭州市","衢州市","温州市","舟山市","宁波市"],810000:["新界","香港岛","九龙"],140000:["朔州市","吕梁市","晋城市","长治市","大同市","阳泉市","太原市","忻州市","运城市","临汾市","晋中市"],610000:["商洛市","咸阳市","宝鸡市","铜川市","西安市","安康市","榆林市","汉中市","延安市","渭南市"],630000:["果洛藏族自治州","玉树藏族自治州","黄南藏族自治州","海南藏族自治州","海东地区","西宁市","海北藏族自治州","海西蒙古族藏族自治州"],440000:["汕头市","肇庆市","东莞市","珠海市","潮州市","清远市","江门市","揭阳市","佛山市","阳江市","河源市","茂名市","广州市","汕尾市","云浮市","湛江市","中山市","梅州市","深圳市","韶关市","惠州市"],320000:["无锡市","扬州市","徐州市","常州市","苏州市","宿迁市","南通市","连云港市","淮安市","镇江市","南京市","盐城市","泰州市"],530000:["迪庆藏族自治州","昭通市","西双版纳傣族自治州","怒江傈僳族自治州","丽江市","大理白族自治州","玉溪市","德宏傣族景颇族自治州","文山壮族苗族自治州","保山市","曲靖市","红河哈尼族彝族自治州","普洱市","昆明市","临沧市","楚雄彝族自治州"],110000:["北京市"],310000:["上海市"],360000:["景德镇市","九江市","萍乡市","上饶市","新余市","鹰潭市","吉安市","赣州市","抚州市","宜春市","南昌市"],420000:["襄阳市","鄂州市","荆州市","黄冈市","省直辖","恩施土家族苗族自治州","咸宁市","宜昌市","随州市","黄石市","十堰市","孝感市","荆门市","武汉市"],410000:["洛阳市","开封市","驻马店市","安阳市","周口市","信阳市","平顶山市","省直辖","商丘市","新乡市","南阳市","鹤壁市","濮阳市","郑州市","三门峡市","漯河市","许昌市","焦作市"],350000:["龙岩市","南平市","漳州市","泉州市","三明市","莆田市","厦门市","福州市","宁德市"],620000:["陇南市","武威市","临夏回族自治州","张掖市","白银市","天水市","甘南藏族自治州","兰州市","金昌市","嘉峪关市","庆阳市","平凉市","定西市","酒泉市"]}};
    var provinces = document.getElementById('provinces');
    var citys = document.getElementById('citys');
    provincesCitysLink(provinces, citys);

    function openMsg(){
        var authorInfo='${authorInfo}';
        //成功提示
        var msg='${msg}';
        if(msg!=''){
            $(".toast").html(msg);
            toastPop();
            updateUserAuthorizationInformation('H5CallAPP_ModifyUserAuthorInfo',authorInfo,'EDITUSERINFOPAGE_EDIT');
        }

    }


    function addOptions(target, options) {
        var optionEle = null,
                target = target,
                option = options,
                optionLen = options.length;
        for (var i = 0; i < optionLen; i++) {
            optionEle = document.createElement('option');
            optionEle.value = option[i].value;
            optionEle.text = option[i].text;
            target.options.add(optionEle);
        }
    }
    
    //省市联动
    function provincesCitysLink(pro, c) {
        var LD = linkDatas,
                provinces = LD.provinces,
                city = LD.citys,
                initCity = city[0],
                proBox = [];
        /*添加省份*/
        for (var i = 0; i < provinces.length; i++) {
            proBox.push({
                "text": provinces[i].name,
                "value": provinces[i].code
            })
        }
        addOptions(pro, proBox);
        /*初始化城市*/
        addOptions(c, [{
            "text": initCity,
            "value": initCity
        }]);
        /*添加联动事件*/
        pro.onchange = function () {
            console.log(this);
            var ct = city[this.value],
                    ctLen = ct.length,
                    ctBox = [];
            c.innerHTML = "";
            /*添加城市*/
            for (var j = 0; j < ctLen; j++) {
                ctBox.push({
                    "text": ct[j],
                    "value": ct[j]
                });
            }
            addOptions(c, ctBox);
            submitArea();
        }
    }
    //选择城市和省份
    function selectProCity( pro,c, pi,ci) {
        pro.value=pi;
        var LD = linkDatas,
                city = LD.citys;

        var ct = city[pi],
                ctLen = ct.length,
                ctBox = [];
        c.innerHTML = "";
        /*添加城市*/
        for (var j = 0; j < ctLen; j++) {
            ctBox.push({
                "text": ct[j],
                "value": ct[j]
            });
        }
        addOptions(c, ctBox);

        c.value=ci;

    }
    //提交地区
    function submitArea(){
        var city= $('#citys').val();
        $('#areaInput').val(city);
        //alert("aa");
        ajaxForm();
    }
    //提交头像
    function submitIcon(){
        var userid= $('#uidInput').val();
        var md5=$("#md5").val();
        var authorInfo='${authorInfo}';
        $.ajax({
            type: 'post',
            url: getContextPath() + 'user/updateIconAjax.do',
            data: {
                uid: userid,
                md5:md5
            },
            cache: false,
            dataType: 'json',
            timeout: 30000,
            success: function (data) {
                //成功
                if(data.result == "OK"){
                    updateUserAuthorizationInformation('H5CallAPP_ModifyUserAuthorInfo',authorInfo,'EDITUSERINFOPAGE_EDIT');
                    $(".toast").html("修改成功");
                    toastPop();
                }

            },
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            error: function () {
                //$(".toast").html("网络连接失败");
                //toastPop();
                ejectPop("网络连接失败");
            }
        });
    }

    //提交性别
    function submitSex(){
        var sex= $('#sexSel').val();
        $('#sexInput').val(sex);
        ajaxForm();
    }
    //提交生日
    function submitMonth(){
        initDay();

        var year= $('#year').val();
        var month= $('#month').val();
        //var day= $('#day').val();
        $('#day').val('1');
        var day=  '1';
        if(year!=''&&month!=''&&day!=''){
            var birth=year+"-"+month+"-"+day;
            //alert(birth);
            $('#birthInput').val(birth);
            //联动修改星座
            changeXingZuo(birth);
            ajaxForm();
        }


    }

    function submitBirth(){
        initDay();

        var year= $('#year').val();
        var month= $('#month').val();
        //var day= $('#day').val();

        var day=  $("#day option:selected").val();
        if(year!=''&&month!=''&&day!=''){
            var birth=year+"-"+month+"-"+day;
            //alert(birth);
            $('#birthInput').val(birth);
            //联动修改星座
            changeXingZuo(birth);
            ajaxForm();
        }


    }
    //修改星座
    function changeXingZuo(brithday){
        var brithArray=brithday.split("-");
        var year=brithArray[0];
        var month=brithArray[1];
        var day=brithArray[2];
        // alert(year+"-"+month+"-"+day);
        $("#year").val(year);
        $("#month").val(parseInt(month));
        $("#day").val(parseInt(day));


        var astro=getAstro(month,day);
        $("#xzSpan").html(astro);
    }


    function getContextPath() {
        var contextPath = document.location.pathname;
        var index = contextPath.lastIndexOf("/");
        contextPath = contextPath.substr(0, index + 1);
        contextPath=contextPath.replace("user/","");
        delete index;
        return contextPath;
    }
    //无刷新提交用户修改内容
    function ajaxForm(){
        var city= $('#citys').val();
        var userid= $('#uidInput').val();
        var sex= $('#sexInput').val();
        var birth= $('#birthInput').val();
        var md5=$("#md5").val();
        $.ajax({
            type: 'post',
            url: getContextPath() + 'user/updateUserInfo.do',
            data: {
                userid: userid,
                area:city,
                sex:sex,
                birth:birth
            },
            cache: false,
            dataType: 'json',
            timeout: 30000,
            success: function (data) {

                //成功
                if(data.result == "OK"){
                    $(".toast").html("修改成功");
                    toastPop();
                }

            },
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            error: function () {
                //$(".toast").html("网络连接失败");
                //toastPop();
                ejectPop("网络连接失败");
            }
        });
    }

    //无刷新提交头像
    function ajaxIcon( base64Date){

        $.ajax({
            type: 'post',
            url: getContextPath() + 'user/uploadIcon.do',
            data: {
                base64Date: base64Date
            },
            cache: false,
            dataType: 'json',
            timeout: 30000,
            success: function (data) {
                //成功
                if(data.result == "OK"){
                    var md5=data.md5;
                    $("#md5").val(md5);
                    submitIcon();
                   // $(".toast").html("成功");
                   // toastPop();
                }

            },
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            error: function () {
               // $(".toast").html("网络连接失败");
               // toastPop();
                ejectPop("网络连接失败");
            }
        });
    }

    //弹出消息
    function ejectPop(msg){
        if(msg!='') {
            $("#ejectTxt").html(msg);

            $(".eject,#bg").css({display: 'block'});

        }

    }
    $(".eject .button").tap(function(){
        $(".eject,#bg").css({display:'none'});
    });

</script>

<script>
</script>

<script src="${basePath}/head-portrait/js/jquery.min.js" type="text/javascript"></script>
<script>window.jQuery || document.write('<script src="${basePath}/head-portrait/js/jquery-2.1.1.min.js"><\/script>')</script>
<script src="${basePath}/head-portrait/js/iscroll-zoom.js"></script>
<script src="${basePath}/head-portrait/js/hammer.js"></script>
<script src="${basePath}/head-portrait/js/jquery.photoClip.js"></script>
<script>
    var obUrl = ''
    //document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
    $("#clipArea").photoClip({
        width: 199,
        height: 166,
        file: "#file",
        view: "#view",
        ok: "#clipBtn",
        loadStart: function() {
            console.log("照片读取中");
        },
        loadComplete: function() {
            console.log("照片读取完成");
        },
        clipFinish: function(dataURL) {
            console.log(dataURL);
            ajaxIcon(dataURL);
        }
    });
</script>
<script>
    $(function(){
        $("#logox").click(function(){
            $(".htmleaf-container").show();
        })
        $("#clipBtn").click(function(){
            $("#logox").empty();
            $('#logox').append('<p class="list-oh">头像</p><img src="' + imgsource + '" class=\'header\'">');
            $(".htmleaf-container").hide();
        })
    });
</script>
<script type="text/javascript">
    $(function(){
        jQuery.divselect = function(divselectid,inputselectid) {
            var inputselect = $(inputselectid);
            $(divselectid+" small").click(function(){
                $("#divselect ul").toggle();
                $(".mask").show();
            });
            $(divselectid+" ul li a").click(function(){
                var txt = $(this).text();
                $(divselectid+" small").html(txt);
                var value = $(this).attr("selectid");
                inputselect.val(value);
                $(divselectid+" ul").hide();
                $(".mask").hide();
                $("#divselect small").css("color","#333")
            });
        };
        $.divselect("#divselect","#inputselect");
    });
</script>
<script type="text/javascript">
    $(function(){
        jQuery.divselectx = function(divselectxid,inputselectxid) {
            var inputselectx = $(inputselectxid);
            $(divselectxid+" small").click(function(){
                $("#divselectx ul").toggle();
                $(".mask").show();
            });
            $(divselectxid+" ul li a").click(function(){
                var txt = $(this).text();
                $(divselectxid+" small").html(txt);
                var value = $(this).attr("selectidx");
                inputselectx.val(value);
                $(divselectxid+" ul").hide();
                $(".mask").hide();
                $("#divselectx small").css("color","#333")
            });
        };
        $.divselectx("#divselectx","#inputselectx");
    });
</script>
<script type="text/javascript">
    $(function(){
        jQuery.divselecty = function(divselectyid,inputselectyid) {
            var inputselecty = $(inputselectyid);
            $(divselectyid+" small").click(function(){
                $("#divselecty ul").toggle();
                $(".mask").show();
            });
            $(divselectyid+" ul li a").click(function(){
                var txt = $(this).text();
                $(divselectyid+" small").html(txt);
                var value = $(this).attr("selectyid");
                inputselecty.val(value);
                $(divselectyid+" ul").hide();
                $(".mask").hide();
                $("#divselecty small").css("color","#333")
            });
        };
        $.divselecty("#divselecty","#inputselecty");
    });
</script>
<script type="text/javascript">
    $(function(){
        $(".mask").click(function(){
            $(".mask").hide();
            $(".all").hide();
        })
        $(".right input").blur(function () {
            if ($.trim($(this).val()) == '') {
                $(this).addClass("place").html();
            }
            else {
                $(this).removeClass("place");
            }
        })
    });
</script>
<script>
    $("#file0").change(function(){
        var objUrl = getObjectURL(this.files[0]) ;
        obUrl = objUrl;
        console.log("objUrl = "+objUrl) ;
        if (objUrl) {
            $("#img0").attr("src", objUrl).show();
        }
        else{
            $("#img0").hide();
        }
    }) ;
    function qd(){
        var objUrl = getObjectURL(this.files[0]) ;
        obUrl = objUrl;
        console.log("objUrl = "+objUrl) ;
        if (objUrl) {
            $("#img0").attr("src", objUrl).show();
        }
        else{
            $("#img0").hide();
        }
    }
    function getObjectURL(file) {
        var url = null ;
        if (window.createObjectURL!=undefined) { // basic
            url = window.createObjectURL(file) ;
        } else if (window.URL!=undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file) ;
        } else if (window.webkitURL!=undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
    }
</script>
<script type="text/javascript">
    var subUrl = "";
    $(function (){
        $(".file-3").bind('change',function(){
            subUrl = $(this).val()
            $(".yulan").show();
            $(".file-3").val("");
        });

        $(".file-3").each(function(){
            if($(this).val()==""){
                $(this).parents(".uploader").find(".filename").val("营业执照");
            }
        });
        $(".btn-3").click(function(){
            $("#img-1").attr("src", obUrl);
            $(".yulan").hide();
            $(".file-3").parents(".uploader").find(".filename").val(subUrl);
        })
        $(".btn-2").click(function(){
            $(".yulan").hide();
        })

    });
</script>
<script type="text/javascript">
    function setImagePreview() {
        var preview, img_txt, localImag, file_head = document.getElementById("file_head"),
                picture = file_head.value;
        if (!picture.match(/.jpg|.gif|.png|.bmp/i)) return alert("您上传的图片格式不正确，请重新选择！"),
                !1;
        if (preview = document.getElementById("preview"), file_head.files && file_head.files[0]) preview.style.display = "block",
                preview.style.width = "63px",
                preview.style.height = "63px",
                preview.src = window.navigator.userAgent.indexOf("Chrome") >= 1 || window.navigator.userAgent.indexOf("Safari") >= 1 ? window.webkitURL.createObjectURL(file_head.files[0]) : window.URL.createObjectURL(file_head.files[0]);
        else {
            file_head.select(),
                    file_head.blur(),
                    img_txt = document.selection.createRange().text,
                    localImag = document.getElementById("localImag"),
                    localImag.style.width = "63px",
                    localImag.style.height = "63px";
            try {
                localImag.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)",
                        localImag.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = img_txt
            } catch(f) {
                return alert("您上传的图片格式不正确，请重新选择！"),
                        !1
            }
            preview.style.display = "none",
                    document.selection.empty()
        }
        return document.getElementById("DivUp").style.display = "block",
                !0
    }
</script>

<script>
//日期联动
    ;(function($){
        $.fn.birthday = function(options){
            var opts = $.extend({}, $.fn.birthday.defaults, options);//整合参数
            var $year = $(this).children("select[name="+ opts.year +"]");
            var $month = $(this).children("select[name="+ opts.month +"]");
            var $day = $(this).children("select[name="+ opts.day +"]");
            MonHead = [31,28,31,30,31,30,31,31,30,31,30,31];
            return this.each(function(){
                var y = new Date().getFullYear();
                var con = "";
                //添加年份
                for(i = y; i >= (y-80); i--){
                    con += "<option value='"+i+"'>"+i+"年"+"</option>";
                }
                $year.append(con);
                con = "";
                //添加月份
                for(i = 1;i <= 12; i++){
                    con += "<option value='"+i+"'>"+i+"月"+"</option>";
                }
                $month.append(con);
                con = "";
                //添加日期
                var n = MonHead[0];//默认显示第一月
                for(i = 1; i <= n; i++){
                    con += "<option value='"+i+"'>"+i+"日"+"</option>";
                }
                $day.append(con);
                $.fn.birthday.change($(this));

            });
        };
        $.fn.birthday.change = function(obj){
            obj.children("select[name="+ $.fn.birthday.defaults.year +"],select[name="+ $.fn.birthday.defaults.month +"]").change(function(){
                var $year = obj.children("select[name="+ $.fn.birthday.defaults.year +"]");
                var $month = obj.children("select[name="+ $.fn.birthday.defaults.month +"]");
                var $day = obj.children("select[name="+ $.fn.birthday.defaults.day +"]");
                $day.empty();
                var selectedYear = $year.find("option:selected").val();
                var selectedMonth = $month.find("option:selected").val();
                if(selectedMonth == 2 && $.fn.birthday.IsRunYear(selectedYear)){//如果是闰年
                    var c ="";
                    for(var i = 1; i <= 29; i++){
                        c += "<option value='"+i+"'>"+i+"日"+"</option>";
                    }
                    $day.append(c);
                }else {//如果不是闰年也没选2月份
                    var c = "";
                    for(var i = 1; i <= MonHead[selectedMonth-1]; i++){
                        c += "<option value='"+i+"'>"+i+"日"+"</option>";
                    }
                    $day.append(c);
                }
            });
        };
        $.fn.birthday.IsRunYear = function(selectedYear){
            return(0 == selectedYear % 4 && (selectedYear%100 != 0 || selectedYear % 400 == 0));
        };
        $.fn.birthday.defaults = {
            year:"year",
            month:"month",
            day:"day"
        };



    })(jQuery);

//初始化动态年月日
    $("#birthday_container").birthday();
//选择用户生日
function initDay(){
    MonHead = [31,28,31,30,31,30,31,31,30,31,30,31];
    var obj=$("#birthday_container");
    var $year = obj.children("select[name="+ $.fn.birthday.defaults.year +"]");
    var $month = obj.children("select[name="+ $.fn.birthday.defaults.month +"]");
    var $day = obj.children("select[name="+ $.fn.birthday.defaults.day +"]");
    var selectedDay = $day.find("option:selected").val();
    //alert("day:"+selectedDay);
    $day.empty();
    var selectedYear = $year.find("option:selected").val();
    var selectedMonth = $month.find("option:selected").val();
    if(selectedMonth == 2 && $.fn.birthday.IsRunYear(selectedYear)){//如果是闰年
        var c ="";
        for(var i = 1; i <= 29; i++){
            c += "<option value='"+i+"'>"+i+"日"+"</option>";
        }
        $day.append(c);
    }else {//如果不是闰年也没选2月份
        var c = "";
        for(var i = 1; i <= MonHead[selectedMonth-1]; i++){
            c += "<option value='"+i+"'>"+i+"日"+"</option>";
        }
        $day.append(c);
    }
    $day.val(selectedDay);
    //alert('1');

}


function getAstro(v_month, v_day) {
    v_month = parseInt(v_month, 10)
    v_day = parseInt(v_day, 10);
    if ((v_month == 12 && v_day >= 22)
            || (v_month == 1 && v_day <= 19)) {
        return "魔羯座";
    }
    else if ((v_month == 1 && v_day >= 20)
            || (v_month == 2 && v_day <= 18)) {
        return "水瓶座";
    }
    else if ((v_month == 2 && v_day >= 19)
            || (v_month == 3 && v_day <= 20)) {
        return "双鱼座";
    }
    else if ((v_month == 3 && v_day >= 21)
            || (v_month == 4 && v_day <= 19)) {
        return "白羊座";
    }
    else if ((v_month == 4 && v_day >= 20)
            || (v_month == 5 && v_day <= 20)) {
        return "金牛座";
    }
    else if ((v_month == 5 && v_day >= 21)
            || (v_month == 6 && v_day <= 21)) {
        return "双子座";
    }
    else if ((v_month == 6 && v_day >= 22)
            || (v_month == 7 && v_day <= 22)) {
        return "巨蟹座";
    }
    else if ((v_month == 7 && v_day >= 23)
            || (v_month == 8 && v_day <= 22)) {
        return "狮子座";
    }
    else if ((v_month == 8 && v_day >= 23)
            || (v_month == 9 && v_day <= 22)) {
        return "处女座";
    }
    else if ((v_month == 9 && v_day >= 23)
            || (v_month == 10 && v_day <= 23)) {
        return "天秤座";
    }
    else if ((v_month == 10 && v_day >= 24)
            || (v_month == 11 && v_day <= 22)) {
        return "天蝎座";
    }
    else if ((v_month == 11 && v_day >= 23)
            || (v_month == 12 && v_day <= 21)) {
        return "射手座";
    }
    return "";
}
//根据用户的生日自动选择初始化下拉框
var brithday= '${voUser.birthday}';
if(brithday!=null&&brithday!=""){
    var brithArray=brithday.split("-");
    var year=brithArray[0];
    var month=brithArray[1];
    var day=brithArray[2];
    // alert(year+"-"+month+"-"+day);
    $("#year").val(year);
    $("#month").val(parseInt(month));
    $("#day").val(parseInt(day));
    initDay();

    var astro=getAstro(month,day);
    $("#xzSpan").html(astro);
}

//封装城市
var city='${areaVO.areaName}';
var provinceId='${areaVO.areaPid}';
var sexValue='${voUser.gender}';
//选择性别
$("#sexSel").val(sexValue);

if(provinceId!=""&&provinceId !=null) {
    if(provinceId!=100000){
    //alert(provinceId+city);
        selectProCity(provinces, citys, provinceId, city);
    }else{
        provinceId='${areaVO.areaId}';
        selectProCity(provinces, citys, provinceId, city);
    }
}


    //跳转编辑nick
    function editNick(){
       var uid= $("#uidInput").val();
       var authorInfo='${authorInfo}';
       var hrefValue= '${basePath}/user/editNick.do?uid='+uid+'&authorInfo='+authorInfo;
        //window.location.href=hrefValue;

        WebviewLink('H5CallAPP_CreateWebview',''+hrefValue+'','','修改昵称','STYLE_AA','OPENTYPE_L2R');

    }

function TCAPPCallH5(json){

    var action= json.action;
    if(action=='APPCallH5_RefreshAuthorInfo'){
        var authorInfo=  json.authorInfo;
        //alert(url);
        //window.location.href=url;

        $.ajax({
            type: 'post',
            url: getContextPath() + 'user/getUsernameAjax.do',
            data: {
                authorInfo:authorInfo
            },
            cache: false,
            dataType: 'json',
            timeout: 30000,
            success: function (data) {
                //成功
                if(data.result == "OK"){
                    $(".rotate-bg").hide();
                    var nick= data.nick;
                    $("#nick").html(nick);
                    $("#nickInput").val(nick);

                }else{
                    var msg=data.msg;
                    ejectPop(msg);
                    $(".rotate-bg").hide();
                    return;
                }

            },
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            error: function () {
                ejectPop("网络请求失败");
                $(".rotate-bg").hide();
            }
        });

    }

}


</script>



</body>
</html>