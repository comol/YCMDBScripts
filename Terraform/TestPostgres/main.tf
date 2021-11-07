terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = "AgAAAAAp3cWzAATuwch1zxwFfUY4hEM9aaNIA4k"
  cloud_id  = "b1gujjq9gvi2jq02dhi7"
  folder_id = "b1gotgt9sbfdsvu4scir"
  zone      = "ru-central1-c"
}

resource "yandex_mdb_postgresql_cluster" "mypg" {
  name        = "mypg"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.mynet.id


  config {
    version = "12-1c"
	
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = "10"
    }
	
	  postgresql_config = {
      max_connections                   = 395
	  max_locks_per_transaction = 250
	  join_collapse_limit = 200
	  from_collapse_limit = 100
    }
  }
  
  database {
    name  = "db1"
    owner = "user1"
	lc_collate="ru_RU.UTF-8"
	lc_type="ru_RU.UTF-8"
  }

  user {
    name     = "user1"
    password = "user1user1"
    permission {
      database_name = "db1"
    }
  }

  host {
    zone      = "ru-central1-c"
    subnet_id = yandex_vpc_subnet.mysubnet.id
  }
}

resource "yandex_vpc_network" "mynet" {
  name = "mynet"
}

resource "yandex_vpc_subnet" "mysubnet" {
  name           = "mysubnet"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.mynet.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
