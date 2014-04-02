from bottle import route, run, template,get

@route('/')
def index():
    return template('index')
from bottle import static_file
@get('/<filename:re:.*\.js>')
def javascripts(filename):
    return static_file(filename, root='static/js')

@get('/<filename:re:.*\.css>')
def stylesheets(filename):
    return static_file(filename, root='static/css')

@get('/<filename:re:.*\.(jpg|png|gif|ico|json)>')
def images(filename):
    return static_file(filename, root='static/img')




run(host='0.0.0.0', port=8888,server='cherrypy')