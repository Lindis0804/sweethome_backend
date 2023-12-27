from flask import jsonify

def format_query(s,input,tail=''):
    if (input is None):
        return ''
    elif (isinstance(input,str)):
        return f"{s}'{input}'{tail}"
    else:
        return f"{s}{input}{tail}"
    
def getErrorResponse(err):
    res = jsonify({
        "success":False,
        "messages":[err]
    })
    res.status_code = 500
    return res