import pymysql
pymysql.install_as_MySQLdb()


class MySQLDatabase:
    def __init__(self, host, port, user, password, database):
        self.connection = pymysql.connect(host, user, password, database, port)
        self.cursor = self.connection.cursor()

    def insert(self, query):
        try:
            self.cursor.execute(query)
            self.connection.commit()
        except pymysql.Error as e:
            print(query)
            print(e)
            self.connection.rollback()

    def query(self, query):
        cursor = self.connection.cursor( pymysql.cursors. DictCursor)
        cursor.execute(query)
        return cursor.fetchall()

    def __del__(self):
        self.connection.close()
