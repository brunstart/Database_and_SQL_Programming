import pymysql

host = 'localhost'
id = 'root'
pw = 'tmdals123'
db_name = 'company'

conn = pymysql.connect(host=host, user=id, password=pw, db=db_name, charset='utf8')
print('connected')

curs = conn.cursor()

# sql = "insert into project values('NewProj 1', 41, 'Seoul', 4, 100), ('NewProj 2', 42, 'Busan', 5, 100), ('NewProj 3', 43, 'ChunCheon', 1, 100)"
# curs.execute(sql)
data = (
    ('NewProj 4', 44, 'Seoul', 5, 100),
    ('NewProj 5', 45, 'Seoul', 4, 100),
    ('NewProj 6', 46, 'Busan', 1, 100),
)

sql = "insert into project values(%s, %s, %s, %s, %s)"
curs.executemany(sql, data)

conn.commit()

curs.execute('select * from project')
rows = curs.fetchall()
for i in rows:
    print(i)

curs.close()
print('closed')