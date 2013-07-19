<html>
<head>
	<title>Query Wizard</title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>
</head>
<style type="text/css">

body{
	font-family: "Trebuchet MS", Helvetica, sans-serif;
}

#section1, #section2, #section3{
	min-height: 1000px;
}


#sqls1, #sqls2, #sqls3{
	float: left;
	color: #FF6633;
	width: 100%;
	font-size: 60px;
	font-weight: bolder;
	margin-top: 100px;
}

#sqls1 #sql4{
	text-decoration: underline;
	color: #00BFFF;
}

#sqls2 #sql2{
	text-decoration: underline;
	color: #00BFFF;
}

#sqls2 #sql2:hover, #sqls1 #sql4:hover
{
	cursor: hand;
}


#this{
	float: left;
	width: 100%;
	padding: 10px;
}


#tile, #thisok, #thatok{
    cursor: hand;
	width: 100px;
	height: 100px;
	float: left;
	border: 1px #000 dashed;
	margin: 20px;
	vertical-align: middle;
	text-align: center;
	line-height: 100px;
}

#tile:hover{
	background: #f8f8f8;
}


#sqls2{
	float: left;
	width: 100%;
}

#that{
	float: left;
	width: 100%;
	padding: 10px;
}


#submit{
	cursor: hand;
	margin:200px 0 200px 0; 
	width: 100%;
	height: 20px;
	font-size: 60px;
	font-weight: bold;
	color: #7381ff;
	float: left;
	text-align: center;
}

#sqls3{
	float: left;
	width: 100%;
}


#thisok, #thatok{
	border-radius: 20px;
	font-size: 20px;
	font-weight: bolder;
}

#operation {
	text-align: center;
    cursor: hand;
	width: 100px;
	height: 100px;
	float: left;
	border: 1px #000 dashed;
	margin: 30px;
	vertical-align: middle;
}


</style>
<script type="text/javascript">

$(function() {
     // Handler for .ready() called.

     var fields = [];
     var tables = [];
     var selected_tables = [];
     var sum_operations = [];

     $('#sqls1 #sql4').click(function(){
     	$("#that").css('display', 'block');
        $("html, body").animate({ scrollTop: $('#that').position().top}, 200);
     });

     $('#that #tile').click(function(){  
         var table = $.trim($(this).text()); 	
         $(this).css('background-color', '#FF6633');
         tables.push(table);
         console.log(tables);
         selected_tables.push(table);
     });

     $('#thatok').click(function(){
     	$("html, body").animate({ scrollTop: $('#sqls2').position().top}, 200);
     	if(tables && tables.length !== 0){
     		var this_str = "";
     		var i;
     		for(i=0; i<tables.length;i++){
     			this_str += tables[i];
     			if(i !== tables.length -1){
     				this_str += ',';
     			}
     		}
     		$('#sqls1 #sql4').html(this_str);
     		$('#sqls2 #sql4').html(this_str);
     		$('#sqls3 #sql4').html(this_str);
     	}
     });

     $('#sqls2 #sql2').click(function(){
     	$("html, body").animate({ scrollTop: $('#this').position().top}, 200);
     	var i;
     	for (i=0;i<selected_tables.length;i++){
     		$('#this #tile.'+selected_tables[i]).css('display', 'block');
     	}
     	$('#thisok').css('display', 'block');
     });

     $('#this #tile').click(function(){  
         var field = $.trim($(this).text()); 	
         $(this).css('background-color', '#FF6633');
         $("#operation").css('background-color', '#fff');
         $(this).find('#operation').css('display', 'block');
         fields.push(field);
         console.log(field);
         $('.sum').css('display', 'block');
         $('.count').css('display', 'block');
         $('.average').css('display', 'block');
     });

     $('#thisok').click(function(){
     	$("html, body").animate({ scrollTop: $('#sqls3').position().top}, 200);
     	if(fields && fields.length !== 0){
     		var i;
     		var my_str = '';
     		for(i=0;i<fields.length;i++){
     		    var myfield = fields[i];
     		    var k;
     		    for(k=0; k<sum_operations.length;k++){

     			    if(sum_operations[k] === myfield){
     				    myfield = 'sum(' + fields[i] + ')';
     				    break;
     			    }
     		    }
     		    my_str += ' '+myfield;
     		    if(i !== fields.length -1){
     			    my_str += ','
     		    }
     	    }
     		console.log(1, sum_operations);
     		$('#sqls1 #sql2').html(my_str);
     		$('#sqls2 #sql2').html(my_str);
     		$('#sqls3 #sql2').html(my_str);
     	}
     });

     $(".sum").click(function(){
     	    var field = fields[fields.length-1];
     		sum_operations.push(field);
     		$(this).css('background-color', '#fff222');
     		console.log('sum('+field+')');
     });


     $('#submit').click(function(){
     	var query = "select ";
     	var i;
     	for(i = 0; i<fields.length; i++){
     		var myfield = fields[i];
     		var k;
     		for(k=0; k<sum_operations.length;k++){

     			if(sum_operations[k] === myfield){
     				myfield = 'sum(' + fields[i] + ')';
     				break;
     			}
     		}
     		query += ' '+myfield;
     		if(i !== fields.length -1){
     			query += ','
     		}
     	}
     	query += ' from ';
     	var j;
     	for(j = 0; j<tables.length; j++){
     		query += ' '+tables[j];
     		if(j !== tables.length -1){
     			query += ','
     		}
     	}


     	regEx = '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$';
     	var startdate = $('input#startdate').val();
     	var enddate = $('input#enddate').val();



     	if(!startdate || !enddate){
     		alert('please enter startdate or enddate');
     		return;
     	} else if(!startdate.match(regEx) || !enddate.match(regEx)){
     		alert('dates format not correct');
     		return;
     	}

     	query += ' dates ['+startdate+','+enddate+']';

     	var marketId = 1;
     	var username = "yying";
     	//call submit url

     	//get response and redirect to another page
     	//call backend
     	$.ajax({
     		type: "GET",
     		url: 'http://localhost:8081/query',
     		data:{queryStr: query, marketId: marketId, username: username},
     		success: function(data){window.location.href='http://localhost:8081/progress'},
     		error: function(data){console.log('error');}
     	});

     });

 });

</script>
<body>

<div id="section1">
	<!-- step one  -->
	<div id="sqls1"> 
		<span id="sql1">SELECT</span>
		<span id="sql2">THIS</span>
		<span id="sql3">FROM</span>
		<span id="sql4">THAT</span>  
	</div>

	<div id="that" style="display:none;">
% for table in tables:
		<div id="tile">
			{{table}}
		</div>
% end
		<div id="thatok">next step</div>
	</div>
</div>


<div id="section2">
	<div id="sqls2"> 
		<span id="sql1">SELECT</span>
		<span id="sql2">THIS</span>
		<span id="sql3">FROM</span>
		<span id="sql4">THAT</span>  
	</div>

	<div id="this">
% for table in tables:
% for column in columns[table]:
		<div id="tile" class="{{table}}"   style="display:none">
			{{column}}
		</div>
% end
% end
		<div id="thisok"  style="display:none">next step</div>
	</div>

	<div id="operation" class="sum" style="display:none">
		sum
	</div>
	<div id="operation" class="count" style="display:none">
		count
	</div>
	<div id="operation" class="average" style="display:none">
		average
	</div>

</div>

<div id="section3">
	<div id="sqls3"> 
		<span id="sql1">SELECT</span>
		<span id="sql2">THIS</span>
		<span id="sql3">FROM</span>
		<span id="sql4">THAT</span> 
		<span id="sql5">DATES</span>
		[
		<span id="sql6"><input type="text" name="start_date" size=12 value="start date" maxlength=10 style="font-size:60px; border:#FF6633;" id="startdate"/></span>
		,
		<span id="sql7"><input type="text" name="end_date" size=12 value="end date"  maxlength=10 style="font-size:60px; border:#FF6633;" id="enddate"/></span>
		]
	</div>
	<div id="submit">submit</div>
</div>







</body>
</html>