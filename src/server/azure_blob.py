import os
#from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient
from azure.storage.blob import BlobServiceClient




class Azure_blob():
    connect_str = os.getenv('SHKOLA_AZ_BLOB_CONN_STR')
    container_name = "questions"
    blob_service_client = None
    base_blob_service = None
    questions_path = "questions"
    lists_path = "lists"

    local_root_path = "~/shkola"

    def __init__(self, local_root_path=None):
        if not self.connect_str:
            print("Please define SHKOLA_AZ_BLOB_CONN_STR")
            exit(1)


        self.blob_service_client = BlobServiceClient.from_connection_string(self.connect_str)
        self.container_client = self.blob_service_client.get_container_client(self.container_name)

        if local_root_path:
            self.local_root_path = local_root_path
            
        self.local_questions_path = local_root_path + "/" + self.questions_path
        self.local_lists_path = local_root_path + "/" + self.lists_path
        

    def list_files(self, path):
        if not path:
            return self.container_client.list_blobs("") 
        else:            
            return self.container_client.list_blobs(name_starts_with=path) 


    def delete_all_files(self, path):
        list_files = self.list_files(path)
        self.container_client.delete_blobs(*list_files)

        

    def upload_file(self, local_file_name):
        upload_file_name = local_file_name[21:]
        
        # Create a blob client using the local file name as the name for the blob
        blob_client = self.blob_service_client.get_blob_client(container=self.container_name, blob=upload_file_name)

        print("Uploading to Azure Storage as blob: " + local_file_name + " -> " + self.container_name + ":" + upload_file_name)
        
        # Upload the created file
        with open(local_file_name, "rb") as data:
            blob_client.upload_blob(data)

            
    def upload_path(self, local_path):
        for (dirpath, dirnames, filenames) in os.walk(local_path):
            #print(dirpath, filenames)
            for f in filenames:
                if filenames[len(dirpath)-1] != '~':
                    if dirpath[len(dirpath)-1] != '/':
                        local_file_name = dirpath + '/' + f
                    else:
                        local_file_name = dirpath + f
                    self.upload_file(local_file_name)

                    
    def download_file(self, file_name):
        
        # Create a blob client using the local file name as the name for the blob
        blob_client = self.blob_service_client.get_blob_client(container=self.container_name, blob=file_name)

        return blob_client.download_blob().readall().decode('utf-8')

            

if __name__ == '__main__':

    azure_blob = Azure_blob("/home/bozidar/shkola")


    #Upload all new files

    upload_all = False

    if upload_all:    
        azure_blob.delete_all_files("")
        azure_blob.upload_path("/home/bozidar/shkola/questions/")
        azure_blob.upload_path("/home/bozidar/shkola/lists/")


    list_files = azure_blob.list_files("")
    for f in list_files:
        print(f['name'])



