#Google cloud provider

provider "google" {
  region      = var.region
  zone        = var.zone
  project     = var.project_id
}

# Bucket storage for vessel csv database backup

resource "google_storage_bucket" "ds_vesse_data" {
  name          = "vessel_data"
  force_destroy = true
  location      = "US"
}

resource "google_storage_bucket_object" "ds_vessel_info" {
  name   = "vessel_info"
  source = "/home/mbhekeni/Documents/aggrigateone_data/vessel_info"
  bucket = "vessel_data"
}

resource "google_storage_bucket_object" "ds_vessel_ports" {
  name   = "vessel_ports"
  source = "/home/mbhekeni/Documents/aggrigateone_data/vessel_ports"
  bucket = "vessel_data"
}

resource "google_storage_bucket_object" "ds_vessel_tracking_events" {
  name   = "vessel_tracking_events"
  source = "/home/mbhekeni/Documents/aggrigateone_data/vessel_tracking_events"
  bucket = "vessel_data"
}

# Bigquery dataset and tables

resource "google_bigquery_dataset" "data_science" {
  dataset_id  = "data_science"
}

resource "google_bigquery_table" "tbl_vessel_info" {
  dataset_id = "data_science"
  table_id = "vessel_info"
  schema = file("/home/mbhekeni/repositories/CLI/bigquery/schemas/vessel_info.json")
}

resource "google_bigquery_table" "tbl_vessel_ports" {
  dataset_id = "data_science"
  table_id = "vessel_ports"
  schema = file("/home/mbhekeni/repositories/CLI/bigquery/schemas/vessel_ports.json")
}

resource "google_bigquery_table" "tbl_vessel_tracking_events" {
  dataset_id = "data_science"
  table_id = "vessel_tracking_events"
  schema = file("/home/mbhekeni/repositories/CLI/bigquery/schemas/vessel_tracking_events.json")
}
