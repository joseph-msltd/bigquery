from google.cloud import bigquery
import pandas

bqclient = bigquery.Client()


# Download a table.
table = bigquery.TableReference.from_string(
    "bigquery-public-data.utility_us.country_code_iso"
)
rows = bqclient.list_rows(
    table,
    selected_fields=[
        bigquery.SchemaField("country_name", "STRING"),
        bigquery.SchemaField("fips_code", "STRING"),
    ],
    max_results=10
)


dataframe = rows.to_dataframe(
    # Optionally, explicitly request to use the BigQuery Storage API. As of
    # google-cloud-bigquery version 1.26.0 and above, the BigQuery Storage
    # API is used by default.
    create_bqstorage_client=True,
)
print(dataframe)

