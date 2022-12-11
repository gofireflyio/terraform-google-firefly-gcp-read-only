import os
from pymongo import MongoClient
from pymongo.database import Database
from pymongo.collection import Collection


collection_name = "generalsettings"
document_name = "firefly_gcp_terraform_module_latest"


def write_relase(mongo_uri: str, release_tag: str):
        try:
            mongo_client: MongoClient = MongoClient(mongo_uri)
            mongo_db: Database = mongo_client.get_database("infralight")
            collection: Collection = mongo_db.get_collection(collection_name)
        except Exception as ex:
            print("Could not connect to MongoDB")
            raise ex
        try:
            collection.update_one({'name': document_name},  {"$set": {'tag': release_tag}}, upsert=True)
            cursor = collection.find()
            for record in cursor:
                print(record)
        except Exception as ex:
            raise ex
        finally:
            mongo_client.close()


def main():
    release_tag = os.getenv("TAG")
    print(release_tag)
    if release_tag:
        try:
            prod_mongo_uri = os.getenv("PROD_MONGO_URI")
            write_relase(prod_mongo_uri, release_tag)
        except Exception as ex:
            print("Could not updates releases to MongoDB")
            raise ex
        try:
            stag_mongo_uri = os.getenv("STAG_MONGO_URI")
            write_relase(stag_mongo_uri, release_tag)
        except Exception as ex:
            print("Could not updates releases to MongoDB")
            raise ex
    else:
        print("release tag is empty")


if __name__ == '__main__':
    main()
