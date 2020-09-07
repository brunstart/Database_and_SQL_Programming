import pymysql

host = 'localhost'
id = 'root'
pw = 'tmdals123'
db_name = 'mydb'

conn = pymysql.connect(host=host, user=id, password=pw, db=db_name, charset='utf8')
print('DB connected')
#
# try:
#     curs = conn.cursor()
#
#     print("*** 학생 성적 검색하기 ***")
#     student_id = input("학번 : ")
#     sql = "select * from score where st_id = " + student_id
#     curs.execute(sql)
#     rows = curs.fetchall()
#
#     for r in rows:
#         print("학번 : " + str(r[0]))
#         print("이름 : " + str(r[1]))
#         print("국어 : " + str(r[2]))
#         print("영어 : " + str(r[3]))
#         print("수학 : " + str(r[4]))
#
#     print("\n")
#     print("*** 학생 성적 추가하기 ***")
#
#     s_id = input("학번 : ")
#     s_name = input("이름 : ")
#     kor = input("국어 : ")
#     eng = input("영어 : ")
#     math = input("수학 : ")
#
#     sql = "insert into score values(" + s_id + ", '" + s_name + "', " + kor + ", " + eng + ", " + math + ", null, null)"
#     curs.execute(sql)
#
# except:
#     print('Error')
# finally:
#     print('Test ended')
#

try:
    curs = conn.cursor()

    while (True):
        print("<<< Select Menu>>>")
        print("1 : 전체 목록 출력")
        print("2 : 성적 검색")
        print("3 : 성적 추가")
        print("4 : 성적 수정")
        print("5 : 성적 삭제")
        print("9 : 프로그램 종료")
        choice = int(input("입력 : "))

        if choice == 1:
            print("전체 목록 출력을 선택하셨습니다")
            curs.execute("select * from score")
            rows = curs.fetchall()
            print("<<전체 목록 출력>>")
            for r in rows:
                print(r)

        if choice == 2:
            print("성적 검색을 선택하셨습니다")
            student_id = input("학번 입력 : ")
            sql = "select * from score where st_id = " + student_id
            curs.execute(sql)
            rows = curs.fetchall()

            for r in rows:
                print("학번 : " + str(r[0]))
                print("이름 : " + str(r[1]))
                print("국어 : " + str(r[2]))
                print("영어 : " + str(r[3]))
                print("수학 : " + str(r[4]))

        if choice == 3:
            print("성적 추가를 선택하셨습니다")

            s_id = input("학번 : ")
            s_name = input("이름 : ")
            kor = input("국어 : ")
            eng = input("영어 : ")
            math = input("수학 : ")

            sql = "insert into score values(" + s_id + ", '" + s_name + "', " + kor + ", " + eng + ", " + math + ", null, null)"
            curs.execute(sql)
            conn.commit()
            print('성적 추가 완료')

        if choice == 4:
            print("성적 수정을 선택하셨습니다")

            student_id = input("성적을 수정할 학생의 학번 입력 : ")

            s_id = input("학번 : ")
            s_name = input("이름 : ")
            kor = input("국어 : ")
            eng = input("영어 : ")
            math = input("수학 : ")

            sql = "update score set st_id="+s_id+", st_name='"+s_name+"', kor="+kor+", eng="+eng+", math="+math+" where st_id="+student_id
            curs.execute(sql)
            conn.commit()

            print('성적 수정 완료')

        if choice == 5:
            print("성적 삭제를 선택하셨습니다")

            student_id = input("성적을 삭제할 학생의 학번 입력 : ")
            sql = "delete from score where st_id="+student_id
            curs.execute(sql)
            conn.commit()

            print('성적 삭제 완료')


        if choice == 9:
            print("프로그램 종료를 선택하셨습니다")
            break;

        if choice not in [1,2,3,4,5,9]:
            print("잘못된 메뉴를 선택하셨습니다")

        input("계속하기 (Enter 키 누름) >>")

except:
    print("ERROR: 실행 오류가 발생했습니다.")
finally:
    curs.close()
    print("프로그램 실행이 완료됐습니다")
