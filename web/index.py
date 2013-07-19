from bottle import route, run, template, get, request, hook, response

import pymongo

#mongodb connection
connection_string = 'mongodb://localhost'

@route('/hello/<name>')
def index(name='World'):
    return template("test", name=name)

@get('/login')
def login():

    #check cookie
    if request.get_cookie("cheetah"):
    	print 'logged in'
    else:
    	print 'need log in'
	#login
	username = request.query.get('username')
	password = request.query.get('password')

#show the query page
@route('/wizard')
def wizar():
	tables = ['table1', 'table2'];
	columns = {
		'table1': ['column11', 'column12', 'column13', 'column14', 'column15', 'column16'],
		'table2': ['column21', 'column22', 'column23', 'column24', 'column25', 'column26']
	};

	return template("query", tables=tables, columns=columns);



@get('/query')
def query():

	#get query needed 
    username = request.query.get('username')
    marketId = request.query.get('marketId')
    queryStr = request.query.get('queryStr')

    print username + str(marketId) + queryStr
    
    #db insert example
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.cheetah
    users = db.users
    users.insert({'name':username})

@hook('after_request')
def enable_cors():
    response.headers['Access-Control-Allow-Origin'] = '*'

run(host='localhost', port=8081)
