$username = "pguser"
$password = "pgpassword"
$dbname   = "db1"
$clustername = "1c_dbms"


# install yandex cli
iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1')

# visit link to get your ID https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb

# create yandex cli config
yc config profile create main

# init yandex cloud environment
yc init

# create postgres cluster
# for test
#yc postgres cluster create --name $clustername --environment=production --network-name default --resource-preset s2.micro --host zone-id=ru-central1-c,subnet-name=default-ru-central1-c --disk-size 10 --disk-type network-ssd --user name=$username,password=$password --database name=$dbname,owner=$username

# basic cluster for prod
# hover tune at least username and password
yc postgres cluster create --name $clustername --environment=production --postgresql-version 12-1c --network-name default --resource-preset s2.medium --host zone-id=ru-central1-c,subnet-name=default-ru-central1-c --host zone-id=ru-central1-a,subnet-name=default-ru-central1-a --host zone-id=ru-central1-b,subnet-name=default-ru-central1-b --disk-size 100 --disk-type local-ssd --user name=$username,password=$password --database name=$dbname,owner=$username,lc-collate=ru_RU.UTF-8,lc-ctype=ru_RU.UTF-8 --async

# cluster settings
# there are some issues with settings via command lint. set synchronious_commit to off and enable online_analize in UI
yc postgres cluster update-config --name $clustername --set join_collapse_limit=200,from_collapse_limit=100,max_locks_per_transaction=500

# list of hosts. just copy IP of master
yc managed-postgresql hosts list --cluster-name $clustername
