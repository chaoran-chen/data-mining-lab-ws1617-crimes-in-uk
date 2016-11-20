#!/usr/bin/python3
import csv
import getopt
import os
import sys
import importlib.util


class InsertBuffer:
    buffer = ['INSERT INTO crimes_uk_poi (category, poi,longitude,latitude, address, description) VALUES']
    counter = 0

    def __init__(self, database):
        self.database = database

    def flush(self):
        self.database.insert(''.join(self.buffer)[:-1])
        self.counter = 0
        self.buffer = ['INSERT INTO crimes_uk_poi (category, poi,longitude,latitude, address, description) VALUES']

    def insert(self, category, poi, longitude, latitude, address, description):
        if latitude == "":
            latitude = 'null'
        if longitude == "":
            longitude = 'null'
        self.buffer.append("('{}', '{}', '{}', '{}', '{}', '{}'),".format(
            category.replace("'", "''"), 
            poi.replace("'", "''"), 
            longitude, 
            latitude, 
            address.replace("'", "''"), 
            description.replace("'", "''")))
        if self.counter < 9999:
            self.counter += 1
        else:
            self.flush()


def dump_poi(root_dir: str, database):
    home_dir = root_dir
    insert_buffer = InsertBuffer(database)

    for dirName in os.listdir(home_dir):  # e.g. ATM
        print('dirName: '+dirName)
        for filename in os.listdir(home_dir + dirName + "/"):  # Allied_Irish_Bank_ATM_PGPSW.csv
            print('filename: '+filename)
            with open(home_dir + dirName + "/" + filename, encoding="ISO-8859-1") as csvfile:
                readCSV = csv.reader(csvfile)
                next(readCSV)  # skip first csv row with col names
                for row in readCSV:
                    insert_buffer.insert(dirName.replace('_',' '), filename[:-4].replace('_',' '), row[0], row[1], row[2].replace('"', ' '), row[3].replace('"', ' '))

    insert_buffer.flush()


def main(argv):
    def print_help():
        print('insert.py -h <host> -p <port> -u <user> -w <password> -d <database> -m <mysql|postgresql> -r <rootdir>')

    host = ''
    port = 0
    user = ''
    password = ''
    database_name = ''
    mode = ''
    root_dir = ''
    try:
        opts, args = getopt.getopt(argv, 'h:p:u:w:d:m:r:',
                                   ['host=', 'port=', 'user=', 'password=', 'database=', 'mode=', 'rootdir='])
    except getopt.GetoptError:
        print_help()
        sys.exit(2)
    for opt, arg in opts:
        if opt in ('-h', '--host'):
            host = arg
        elif opt in ('-p', '--port'):
            port = int(arg)
        elif opt in ('-u', '--user'):
            user = arg
        elif opt in ('-w', '--password'):
            password = arg
        elif opt in ('-d', '--database'):
            database_name = arg
        elif opt in ('-m', '--mode'):
            mode = arg
        elif opt in ('-r', '--rootdir'):
            root_dir = arg
        else:
            print_help()
            sys.exit(2)
    database = None
    if mode == 'mysql':
        spec = importlib.util.spec_from_file_location('mysql_database', '../raw-crimes-data-loader/mysql_database.py')
        mysql_database = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mysql_database)
        database = mysql_database.MySQLDatabase(host, port, user, password, database_name)
    elif mode == 'postgresql':
        spec = importlib.util.spec_from_file_location('postgresql_database', '../raw-crimes-data-loader/postgresql_database.py')
        postgresql_database = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(postgresql_database)
        database = postgresql_database.PostgresqlDatabase(host, port, user, password, database_name)
    else:
        print_help()
        sys.exit(2)
    dump_poi(root_dir, database)


if __name__ == '__main__':
    main(sys.argv[1:])
