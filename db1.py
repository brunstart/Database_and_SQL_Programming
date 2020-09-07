import pymysql

host = 'localhost'
id = 'root'
pw = 'tmdals123'
db_name = 'company'

conn = pymysql.connect(host=host, user=id, password=pw, db=db_name, charset='utf8')
print('connected')

curs = conn.cursor()
pn = input('프로젝트 이름 : ')
pid = input('프로젝트 번호 : ')
ploc = input('프로젝트 위치 : ')
dn = input('부서번호 : ')
price = input('가격 : ')
# print(dn)
# #sql = 'select fname, lname, salary from employee where dno=' + dn
sql = "insert into project values('" + pn +\
      "'," + pid + ", '" + ploc +"', " + dn + ", " + price + ")"
curs.execute(sql)
curs.execute('select * from project')
rows = curs.fetchall()

for r in rows:
    print(r)

curs.close()
print('closed')