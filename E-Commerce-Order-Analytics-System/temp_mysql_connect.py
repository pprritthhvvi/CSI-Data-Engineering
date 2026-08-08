import mysql.connector

conn = None
try:
    conn = mysql.connector.connect(host='localhost', port=33060, user='root', password='123456', autocommit=True)
    print('CONNECTED')
    print(conn.get_server_info())
except Exception as e:
    print(type(e).__name__, e)
finally:
    if conn is not None:
        conn.close()
