<html>
<head>
	<title>Query Wizard</title>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" ></script>
</head>
<style type="text/css">

#sqls1, #sqls2, #sqls3{
	float: left;
	color: blue;
	width: 100%;
	font-size: 50px;
	font-weight: bolder;
}

#sqls1 #sql2:hover, #sqls2 #sql2:hover, #sqls3 #sql2:hover, #sqls1 #sql4:hover, #sqls2 #sql4:hover, #sqls3 #sql4:hover
{
	cursor: hand;
	color: red;
}


#this{
	float: left;
	width: 100%;
	padding: 10px;
}


#tile {
    cursor: hand;
	width: 100px;
	height: 100px;
	float: left;
	border: 1px #000 dashed;
	margin: 20px;
}

#tile:hover{
	background: #f8f8f8;
}


#sqls2{
	float: left;
	width: 100%;
}

#thisok{
	float: left;
	width: 100px;
	height: 20px;
}

#that{
	float: left;
	width: 100%;
	padding: 10px;
}

#thatok{
	float: left;
	width: 100px;
	height: 20px;
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
}

#sqls3{
	float: left;
	width: 100%;
}




</style>
<script type="text/javascript">

$(function() {
     // Handler for .ready() called.

     var fields = [];
     var tables = [];

     $('#sqls1 #sql4').click(function(){
        $("html, body").animate({ scrollTop: $('#that').position().top}, 200);
     });

     $('#that #tile').click(function(){  
         var table = $.trim($(this).text()); 	
         $(this).css('background-color', '#fff000');
         tables.push(table);
         console.log(tables);
         $('#this #tile.'+table).css('display', 'block');
     });

     $('#thatok').click(function(){
     	$("html, body").animate({ scrollTop: $('#sqls2').position().top}, 200);
     	if(tables && tables.length !== 0){
     		var this_str = "";
     		var i;
     		for(i=0; i<tables.length;i++){
     			this_str += tables[i] + ", ";
     		}
     		$('#sqls1 #sql4').html(this_str);
     		$('#sqls2 #sql4').html(this_str);
     		$('#sqls3 #sql4').html(this_str);
     	}
     });

     $('#sqls2 #sql4').click(function(){
     	$("html, body").animate({ scrollTop: $('#that').position().top}, 200);
     });

     $('#that #tile').click(function(){  
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
     			this_str += fields[i] + ", ";
     		}
     		$('#sqls1 #sql2').html(this_str);
     		$('#sqls2 #sql2').html(this_str);
     		$('#sqls3 #sql2').html(this_str);
     	}
     });


     $('#submit').click(function(){
     	var query = "select sth from swhere";
     	var marketId = 1;
     	var username = "yying";
     	//call submit url

     	//get response and redirect to another page
     	//call backend
     	$.ajax({
     		type: "GET",
     		url: 'http://localhost:8081/query',
     		data:{queryStr: query, marketId: marketId, username: username},
     		success: function(data){ console.log('success');},
     		error: function(data){console.log('error');}
     	});

     });

 });

</script>
<body>
	<!-- step one  -->
	<div id="sqls1"> 
		<span id="sql1">SELECT</span>
		<span id="sql2">THIS</span>
		<span id="sql3">FROM</span>
		<span id="sql4">THAT</span>  
	</div>

	<div id="that">
% for table in tables:
		<div id="tile">
			{{table}}
		</div>
% end
		<div id="thatok">next step</div>
	</div>

	<div id="sqls2"> 
		<span id="sql1">SELECT</span>
		<span id="sql2">THIS</span>
		<span id="sql3">FROM</span>
		<span id="sql4">THAT</span>  
	</div>

	<div id="this">
% for table in tables:
% for column in columns[table]:
		<div id="tile" class="{{table}}" style="display:none">
			{{column}}
		</div>
% end
% end
		<div id="thisok">next step</div>
	</div>


	<div id="sqls3"> 
		<span id="sql1">SELECT</span>
		<span id="sql2">THIS</span>
		<span id="sql3">FROM</span>
		<span id="sql4">THAT</span>  
	</div>




	<div id="submit">submit</div>




</body>
</html>