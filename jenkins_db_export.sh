#/bin/bash -xe

db_user=root
db_password=root
db_host=lamp-db

now=$( date '+%Y-%m-%d_%H-%M-%S' )
target_name="mysql_backup_${now}"
temp_root_path="/dump/$( date '+%Y-%m-%d_%H-%M-%S%3N' )"
temp_path="${temp_root_path}/${temp_name}"
mkdir -p ${temp_path}

echo "Starting DB dump! $(date '+%Y-%m-%d %H:%M:%S')"

# change environment.
export MYSQL_PWD=${db_password};

# get all databases name.
databases=$( mysql -u${db_user} -h ${db_host} -e 'SHOW DATABASES;' --silent )

for database in ${databases}
do
  if [ "$database" == "information_schema" -o "$database" == "performance_schema" -o "$database" == "mysql" -o "$database" == "sys" ]; then
    echo "Skip $database."
  else
    echo "Dumping $database......"
    filename="${temp_path}${database}.sql"

    mysqldump -u${db_user} -h ${db_host} --single-transaction --routines --events --hex-blob ${database} > ${filename}
    echo ${filename}
  fi
done

backup_file="${temp_root_path}/${target_name}.sql"

echo "Done! $( date '+%Y-%m-%d %H:%M:%S' )"
