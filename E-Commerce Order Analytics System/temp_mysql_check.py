import mysql.connector
from mysql.connector import Error

candidates = [
    dict(host='localhost', port=33060, user='root', password='123456', autocommit=True),
    dict(host='localhost', port=33060, user='root', password='123456', autocommit=True, use_pure=True),
]

for kwargs in candidates:
    try:
        conn = mysql.connector.connect(**kwargs)
        print('connected', kwargs.get('use_pure'))
        print(conn.get_server_info())
        conn.close()
    except Exception as exc:
        print('failed', kwargs.get('use_pure'), repr(exc))
