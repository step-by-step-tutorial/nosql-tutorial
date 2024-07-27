# pip install elasticsearch
from elasticsearch import Elasticsearch

username = "elastic"
password = "password"

client = Elasticsearch(
    "http://localhost:9200",
    basic_auth=(username, password)
)

print(client.info())
