#!/bin/bash -xe

input_dump_file=${dump_file}
db_user=root
db_password=root
db_hostname=lamp-db

echo "Importing DB... $( date '+%Y-%m-%d %H:%M:%S' )"

# set temp path
temp_path="/dump/$( date '+%Y-%m-%d_%H-%M-%S' )"

# create tempdir
mkdir -p ${temp_path}

#set dump filename
dump_file_name=`basename ${input_dump_file}`
# set tempfile fullpath
temp_file_fullpath="${temp_path}/${dump_file_name}"
# copy input_dump_file
cp -r ${input_dump_file} ${temp_file_fullpath}
# change permission
chmod 755 ${temp_path}/${dump_file_name}
# get dump file name
dump_dir_name=${dump_file_name%%.*}
# get dump file
dump_file="${temp_path}/${dump_file_name}"

echo "Check exists database."
export MYSQL_PWD=${db_password};

# Create DB, if not exists
db_name=`basename ${dump_file%%.*}`
echo "Create DB [ ${db_name} ], if not exists"
mysql -u${db_user} -h ${db_hostname} -e "begin; CREATE DATABASE IF NOT EXISTS ${db_name}; commit;"

echo "Start Import database."
# Import DB
sql_dump_file_fullpath="${dump_file%.*}"
mysql -u${db_user} -h ${db_hostname} ${db_name} < ${dump_file}

rm -r ${temp_path}

echo "Done! $( date '+%Y-%m-%d %H:%M:%S' )"