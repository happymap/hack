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
	text-align: center;
    cursor: hand;
	width: 100px;
	height: 100px;
	float: left;
	border: 1px #000 dashed;
	margin: 20px;
	vertical-align: middle;
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
	margin:200px 0 200px 0; 
	width: 100px;
	height: 20px;
	font-size: 20px;
	font-weight: bold;
	background: blue;
	color: white;
	float: left;
	text-align: center;
}

#sqls3{
	float: left;
	width: 100%;
}


#thisok, #thatok{
	font-size: 30px;
	font-weight: bolder;
}



</style>
<script type="text/javascript">

$(function() {
     // Handler for .ready() called.

     var fields = [];
     var tables = [];
     var selected_tables = [];

     $('#sqls1 #sql4').click(function(){
     	$("#that").css('display', 'block');
        $("html, body").animate({ scrollTop: $('#that').position().top}, 200);
     });

     $('#that #tile').click(function(){  
         var table = $.trim($(this).text()); 	
         $(this).css('background-color', '#fff000');
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
         $(this).css('background-color', '#fff000');
         fields.push(field);
         console.log(field);
     });

     $('#thisok').click(function(){
     	$("html, body").animate({ scrollTop: $('#sqls3').position().top}, 200);
     	if(fields && fields.length !== 0){
     		var this_str = "";
     		var i;
     		for(i=0; i<fields.length;i++){
     			this_str += fields[i];
     			if(i !== fields.length -1){
     				this_str += ',';
     			}
     		}
     		$('#sqls1 #sql2').html(this_str);
     		$('#sqls2 #sql2').html(this_str);
     		$('#sqls3 #sql2').html(this_str);
     	}
     });


     $('#submit').click(function(){
     	var query = "select ";
     	var i;
     	for(i = 0; i<fields.length; i++){
     		query += ' '+fields[i];
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
</div>

<div id="section3">
	<div id="sqls3"> 
		<span id="sql1">SELECT</span>
		<span id="sql2">THIS</span>
		<span id="sql3">FROM</span>
		<span id="sql4">THAT</span>  
	</div>
</div>



	<div id="submit">submit</div>




</body>
</html>