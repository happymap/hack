from bottle import route, run, template, get, request

import pymongo

#mongodb connection
connection_string = 'mongodb://localhost'

@route('/hello/<name>')
def index(name='World'):
    return template("test", name=name)

@get('/query/<str:int>')
def query(str):
    name = request.query.get('name')
    print name
    
    #db insert example
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.cheetah
    users = db.users
    users.insert({'name':name})
    





run(host='localhost', port=8081)
