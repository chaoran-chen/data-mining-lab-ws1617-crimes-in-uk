#### Download the raw data
    wget https://data.police.uk/data/archive/latest.zip

#### Install Python Packages
    # setuptools
    wget https://bootstrap.pypa.io/ez_setup.py -O - | python3 - --user
    # PyMySQL
    # Download package: https://pypi.python.org/pypi/PyMySQL
    python3 setup.py install --user
    # py-postgresql
    # Download package: http://python.projects.pgfoundry.org/
    python3 setup.py install --user

#### Execute
    insert.py -h <host> -p <port> -u <user> -w <password> -d <database> -m <mysql|postgresql> -s <streets|outcomes|stop_and_search> -r <rootdir>
