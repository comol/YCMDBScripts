# ClickHouse create test cloud
curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

# visit link to get your ID https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb
yc config profile create test
yc init

yc vpc subnet list – копируем id зоны, которая соответствует подсети. Понадобится для следующего шага
yc clickhouse cluster create --name testclickhouse --environment=production --network-name default --clickhouse-resource-preset s2.micro --host type=clickhouse,zone-id=ru-central1-a,subnet-name=default-ru-central1-a,assign-public-ip --clickhouse-disk-size 10 --clickhouse-disk-type network-ssd --user name=user1,password=user1password --database name=db1
yc clickhouse –cluster-name testclickhouse database list 
