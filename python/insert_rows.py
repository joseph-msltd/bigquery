# [START bigquery_table_insert_rows]
from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set table_id to the ID of table to append to.
table_id = '<project_id>.wedagrowstobq.test_123'
                                                                                                                        
rows_to_insert = [
    {"full_name": "Phred Phlyntstone", "age": 32, "Subject":"Maths"},
    {"full_name": "Wylma Phlyntstone", "age": 29, "Subject":"Maths"},
    {"full_name": "HariHaran", "age": 25, "Subject":"Maths"}, 
    {"full_name": "Zarina", "age": 24, "Subject":"Maths"}, 
    {"full_name": "Anand", "age": 24, "Subject":"Maths"}, 
    {"full_name": "Mathew", "age": 29, "Subject":"Maths"},
    {"full_name": "anna", "age": 42, "Subject":"Geometry"}
]

errors = client.insert_rows_json(table_id, rows_to_insert)  # Make an API request.
if errors == []:
    print("New rows have been added.")
else:
    print("Encountered errors while inserting rows: {}".format(errors))

 
