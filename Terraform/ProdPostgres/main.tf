terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = "<TOKEN>"
  cloud_id  = "<CloudID>"
  folder_id = "<Folderid>"
  zone      = "ru-central1-c"
}

resource "yandex_mdb_postgresql_cluster" "pg_1c" {
  name        = "pg_1c"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.pgnet.id


  config {
    version = "12-1c"

    resources {
      resource_preset_id = "s2.medium"
      disk_type_id       = "local-ssd"
      disk_size          = "100"
    }
	
	postgresql_config = {
      max_connections                   = 395
	  max_locks_per_transaction = 250
	  join_collapse_limit = 200
	  from_collapse_limit = 100
	  synchronous_commit = "SYNCHRONOUS_COMMIT_OFF"
    }
  }

  database {
    name       = "db1"
    owner      = "pguser"
    lc_collate = "ru_RU.UTF-8"
    lc_type    = "ru_RU.UTF-8"
  }

  user {
    name     = "pguser"
    password = "pgpassword"
    permission {
      database_name = "db1"
    }
  }

  host {
    zone      = "ru-central1-c"
    subnet_id = yandex_vpc_subnet.pgsubnet-c.id
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.pgsubnet-b.id
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.pgsubnet-a.id
  }
}

resource "yandex_vpc_network" "pgnet" {
  name = "pgnet"
}

resource "yandex_vpc_subnet" "pgsubnet-c" {
  name           = "pgsubnet-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.pgnet.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

resource "yandex_vpc_subnet" "pgsubnet-b" {
  name           = "pgsubnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.pgnet.id
  v4_cidr_blocks = ["10.6.0.0/24"]
}

resource "yandex_vpc_subnet" "pgsubnet-a" {
  name           = "pgsubnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.pgnet.id
  v4_cidr_blocks = ["10.7.0.0/24"]
}
