from bottle import route, run, template, response, hook
import random

count = 0

@route('/')
def index(name='World'):
    global count
    count = count + 1
    print count
    return str(count)

@hook('after_request')
def enable_cors():
    response.headers['Access-Control-Allow-Origin'] = '*'

run(host='localhost', port=8080)
