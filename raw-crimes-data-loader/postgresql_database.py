import postgresql


class PostgresqlDatabase:
    def __init__(self, host, port, user, password, database):
        self.conn = postgresql.open('pq://{}:{}@{}:{}/{}'.format(user, password, host, port, database))

    def insert(self, query):
        try:
            self.conn.execute(query)
        except Exception as e:
            print(query)
            print(e)
            raise
