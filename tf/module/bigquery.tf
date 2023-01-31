resource "google_bigquery_dataset" "dest_dataset" {
  dataset_id = var.dest_dataset_name
  location   = "US"
}

//create json files in schema folder, tables are created as table_name=filename(without extn), schema=schema content inside the file
resource "google_bigquery_table" "dest_table" {
  for_each            = fileset("${path.module}/../schema", "*.json")
  dataset_id          = google_bigquery_dataset.dest_dataset.dataset_id
  //  each.value comes as trips.json, cut this string as trips to get table name from file name without extension
  table_id            = split(".", each.value)[0]
  deletion_protection = false
  //  concatenating the folder and file name to read the content for schema.
  schema              = file(format("%s/%s","${path.module}/../schema",each.value))
}

data "local_file" "query" {
  filename = "${path.module}/../../query.sql"
}

resource "google_bigquery_job" "job" {
  job_id     = "trips_finder"
  query {
    query = data.local_file.query.content
    destination_table {
      project_id = var.project_id
      dataset_id = google_bigquery_dataset.dest_dataset.dataset_id
      table_id   = var.dest_table
    }
    allow_large_results = true
    flatten_results = true
    script_options {
      key_result_statement = "LAST"
    }
  }
}