import cx_Oracle

dsn = cx_Oracle.makedsn("your_host", 1521, service_name="your_service")
conn = cx_Oracle.connect(user="your_user", password="your_pass", dsn=dsn)

cursor = conn.cursor()
cursor.execute("SELECT * FROM dual")
for row in cursor:
    print(row)
cursor.close()
conn.close()