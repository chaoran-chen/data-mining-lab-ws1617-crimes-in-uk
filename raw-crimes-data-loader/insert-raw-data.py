#!/usr/bin/python3
import csv
import getopt
import os
import sys


class InsertBuffer:
    def __init__(self, insert_pre: str, database):
        self.insert_pre = insert_pre
        self.buffer = [insert_pre]
        self.counter = 0
        self.database = database

    def flush(self):
        self.database.insert(''.join(self.buffer)[:-1])
        self.counter = 0
        self.buffer = [self.insert_pre]

    def insert(self, value_str: str):
        self.buffer.append(value_str)
        if self.counter < 9999:
            self.counter += 1
        else:
            self.flush()


def parse_street_row(row, county: str):
    if row[10].__contains__(";"):
        # some csvs also contain a free row that I named suspect_identified
        last_outcome_category = row[10].split(";")[0]
        suspect_identified = row[10].split(";")[1]
    else:
        last_outcome_category = row[10]
        suspect_identified = ""
    latitude = row[4]
    longitude = row[5]
    if latitude == "":
        latitude = 'null'
    if longitude == "":
        longitude = 'null'
    return "('{}', '{}-01', '{}', '{}', {}, {}, '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}'),".format(
        row[0].replace("'", "''"),
        row[1],
        row[2].replace("'", "''"),
        row[3].replace("'", "''"),
        latitude,
        longitude,
        row[6].replace("'", "''"),
        row[7].replace("'", "''"),
        row[8].replace("'", "''"),
        row[9].replace("'", "''"),
        last_outcome_category.replace("'", "''"),
        suspect_identified.replace("'", "''"),
        row[11].replace("'", "''"),
        county.replace("'", "''"))


def parse_outcome_row(row, county: str):
    # some csvs also contain a free row that I named suspect_identified
    if row[9].__contains__(";"):
        outcome_type = row[9].split(";")[0]
        suspect_identified = row[9].split(";")[1]
    else:
        outcome_type = row[9]
        suspect_identified = ""
    latitude = row[4]
    longitude = row[5]
    if latitude == "":
        latitude = 'null'
    if longitude == "":
        longitude = 'null'
    return "('{}', '{}-01', '{}', '{}', '{}', {}, {}, '{}', '{}', '{}', '{}', '{}'),".format(
        row[0].replace("'", "''"),
        row[1],
        county.replace("'", "''"),
        row[2].replace("'", "''"),
        row[3].replace("'", "''"),
        latitude,
        longitude,
        row[6].replace("'", "''"),
        row[7].replace("'", "''"),
        row[8].replace("'", "''"),
        outcome_type.replace("'", "''"),
        suspect_identified.replace("'", "''"))


def parse_stop_and_search_row(row, county: str):
    latitude = row[4]
    longitude = row[5]
    if latitude == "":
        latitude = 'null'
    if longitude == "":
        longitude = 'null'
    return "('{}', '{}', '{}', '{}', {}, {}, '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}'),".format(
        row[0],
        row[1][:-6],
        row[2],
        row[3],
        latitude,
        longitude,
        row[6],
        row[7],
        row[8],
        row[9],
        row[10],
        row[11],
        row[12],
        row[13],
        row[14],
        county)


INSERT_PRES = {
    'streets': 'INSERT INTO crimes_uk_streets (crime_id, month, reported_by, falls_within,'
               'longitude, latitude, location, lsoa_code, lsoa_name, crime_type, last_outcome_category,'
               'suspect_identified, context, county) VALUES',
    'outcomes': 'INSERT INTO crimes_uk_outcomes (crime_id, month, county, reported_by, falls_within, longitude, latitude,'
                'location, lsoa_code, lsoa_name, outcome_type, suspect_identified) VALUES',
    'stop_and_search': 'INSERT INTO crimes_uk_stop_and_search (type, date, part_of_a_policing_operation, '
                       'policing_operation, latitude, longitude, gender, age_range, self_defined_ethnicity, '
                       'officer_defined_ethnicity, legislation, object_of_search, outcome, '
                       'outcome_linked_to_object_of_search, removal_of_more_than_just_outer_clothing, county) VALUES'
}

PARSE_FUNCTIONS = {
    'streets': parse_street_row,
    'outcomes': parse_outcome_row,
    'stop_and_search': parse_stop_and_search_row
}


FILENAMES = {
    'streets': 'street',
    'outcomes': 'outcomes',
    'stop_and_search': 'stop-and-search'
}


def insert(dataset_type, root_dir: str, database):
    insert_buffer = InsertBuffer(INSERT_PRES[dataset_type], database)
    for dirName in os.listdir(root_dir):
        print(dirName)
        for filename in os.listdir(root_dir + dirName + '/'):
            if filename.__contains__(FILENAMES[dataset_type]):
                print('    ' + filename)
                county = filename[8:filename.index(FILENAMES[dataset_type] + '.csv') - 1].replace('-', ' ')

                with open(root_dir + dirName + "/" + filename) as csv_file:
                    read_csv = csv.reader(csv_file, delimiter=',')
                    next(read_csv)  # skip first csv row with col names
                    for row in read_csv:
                        insert_buffer.insert(PARSE_FUNCTIONS[dataset_type](row, county))
    insert_buffer.flush()


def main(argv):
    def print_help():
        print('insert.py -h <host> -p <port> -u <user> -w <password> -d <database> -m <mysql|postgresql> -s <streets|outcomes|stop_and_search> -r <rootdir>')

    host = ''
    port = 0
    user = ''
    password = ''
    database_name = ''
    mode = ''
    dataset = ''
    root_dir = ''
    try:
        opts, args = getopt.getopt(argv, 'h:p:u:w:d:m:s:r:',
                                   ['host=', 'port=', 'user=', 'password=', 'database=', 'mode=', 'dataset=', 'rootdir='])
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
        elif opt in ('-s', '--dataset'):
            dataset = arg
        elif opt in ('-r', '--rootdir'):
            root_dir = arg
        else:
            print_help()
            sys.exit(2)
    database = None
    if mode == 'mysql':
        from mysql_database import MySQLDatabase
        database = MySQLDatabase(host, port, user, password, database_name)
    elif mode == 'postgresql':
        from postgresql_database import PostgresqlDatabase
        database = PostgresqlDatabase(host, port, user, password, database_name)
    else:
        print_help()
        sys.exit(2)
    insert(dataset, root_dir, database)


if __name__ == '__main__':
    main(sys.argv[1:])
