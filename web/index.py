from bottle import route, run, template, get, request, hook, response, static_file

import pymongo, subprocess

count = 0
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
def wizard():

    #check cookie
    if request.get_cookie('cheetah') == None:
        #command = 'ls'
        command = 'java -jar /Users/yying/hack/queryauthentication/target/query-operations-1.0-SNAPSHOT.jar'
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
        output = process.communicate()
        retcode = process.poll()
        if retcode:
            raise subprocess.CalledProcessError(retcode, command, output=output[0])
        token = output[0].split("access token:", 1)[1]
        response.set_cookie('cheetah', token)

    else:
        print 'token gotten'

	tables = ['data', 'impressions', 'clicks', 'actions'];
	columns = {
		'data': ['advertiser_id', 'category', 'category_id', 'category_name', 'cid', 'contract_id'],
		'impressions': ['impression', 'cost', 'advertiser_id', 'impression_date', 'impression_hour', 'package_id', 'impression_id'],
        'clicks': ['data_cost', 'market_pay_data_cost', 'turn_pay_data_cost'],
        'actions': ['action', 'cta', 'order_number', 'vta']
	};

	return template("query", tables=tables, columns=columns);

@get('/query')
def query():

	#get query needed 
    username = request.query.get('username')
    marketId = request.query.get('marketId')
    queryStr = request.query.get('queryStr')

    print username + str(marketId) + queryStr

    #run query task
    # command = 'java -jar "/Users/yying/hack/queryquery/target/query-query-1.0-SNAPSHOT.jar" "dcexqp3he9a6avdhgbeuwmyw" "select * from sth"'
    # process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
    # output = process.communicate()
    # retcode = process.poll()
    # if retcode:
    #     raise subprocess.CalledProcessError(retcode, command, output=output[0])
    # queryId = output[0]
    # print "queryId: " + queryId

    p = subprocess.Popen(['java', '-jar', '/Users/yying/hack/queryquery/target/query-query-1.0-SNAPSHOT.jar', request.get_cookie('cheetah'), queryStr], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    queryId, err = p.communicate()
    print queryId
    
    #db insert example
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.cheetah
    users = db.users
    users.insert({'name':username, 'queryId': queryId, 'queryStr': queryStr, 'result': '', 'finish': False})

@route('/progress')
def progress():
	return template('index')

@get('/fetch')
def fetch():
    global count
    count = count + 1
    return str(count)

@route('/result')
def result():
    return template('visualize')

@route('/data')
def data():
    return static_file('data4.tsv', root='./')

@hook('after_request')
def enable_cors():
    response.headers['Access-Control-Allow-Origin'] = '*'

run(host='localhost', port=8081)
