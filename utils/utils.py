def format_query(s,input,tail=''):
    if (input is None):
        return ''
    elif (isinstance(input,str)):
        return f"{s}'{input}'{tail}"
    else:
        return f"{s}{input}{tail}"