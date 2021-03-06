# Clean up dynamically created resources π§Ή

Through repeated manual testing, both by the rAPId team and the client, we have found that it would be helpful to have a dataset `delete` endpoint. Additionally, this would be useful and convenient for the eventual departmental users.

Since we do not have the time to do this, it was decided to create a checklist for deleting a dataset.

## Resources to delete β

AWS console access is needed in order to delete these resources, the user needs to have enough permissions to do so.

Until the ```delete``` endpoint is created for cleanup, we recommend following these steps even if there are other ways to delete certain data (for example using the ```delete``` endpoint for the raw files).

### Schema π 
#### Steps πΆβ
- Access the AWS console and log in
- Go to S3
- Go to the bucket `{prefix}-data-ingest-raw-data`
- Go to `/data/{domain}/schemas/{sensitivity}`
- Select the file `{domain}-{dataset}.json`
- Click on delete
- Follow the instructions provided by the console

#### Consequence if not deleted πΏ
- Nobody would be able to upload a new schema with the same domain and dataset while it is in place
- If the crawler/tables has been deleted the users will be able to upload the data but not to query it

### Data π
#### Steps πΆβ
- Access the AWS console and log in
- Go to S3
- Go to the bucket `{prefix}-data-ingest-raw-data`
- Go to `/data/{domain}/`
- Select the `dataset` folder
- Click on delete
- Follow the instructions provided by the console

#### Consequence if not deleted πΏ
- All the data will be retained and the user would be able to query if the crawlers are retained
- If a new schema is uploaded with the same domain/dataset, then the crawler will add the old files to the new table

### Raw data π§Ύ
#### Steps πΆβ
- Access the AWS console and log in
- Go to S3
- Go to the bucket `{prefix}-data-ingest-raw-data`
- Go to `/raw_data/{domain}/`
- Select the `dataset` folder
- Click on delete
- Follow the instructions provided by the console

#### Consequence if not deleted πΏ
- The data will be maintained but never used, we recommend enabling some sort of retention policy to delete the raw files after some time to avoid this issue

### Crawler π·οΈ
#### Steps πΆβ
- Access the AWS console and log in
- Go to AWS Glue
- Go to crawlers
- Select the crawler `{prefix}_crawler/{domain}/{dataset}`
- Click on Action
- Click on Delete crawler
- Follow the instructions provided by the console

#### Consequence if not deleted πΏ
- It will be maintained and can be run but will throw errors if the files are deleted
- Nobody would be able to upload a new schema with the same domain and dataset while it is in place
- If someone makes a request to the `list` dataset endpoint, this dataset will be on the list

### Glue catalog table π
#### Steps πΆβ
- Access the AWS console and log in
- Go to AWS Glue
- Go to Tables
- Select the table `{domain}_{dataset}`
- Click on Action
- Click on Delete table
- Follow the instructions provided by the console

#### Consequence if not deleted πΏ
- The data will be accessible by Athena and the `query` endpoint

### User group π€Ό
#### Steps πΆβ
- Access the AWS console and log in
- Go to Cognito
- Go to the user pool `{prefix}_user_pool`
- Go to Groups
- Select the group for your dataset `WRITE/{domain}/{dataset}`
- Click on delete
- Follow the instructions provided by the console

#### Consequence if not deleted πΏ
- The dataset will appear in the `upload` page dropdown for the users that are part of this group
- If a new schema with the same domain and dataset is uploaded, the users in this group would be granted access automatically

## Notes π
- `{prefix}` is a value assigned in terraform as part of the IaC, in our case is `rapid` and it is maintained across resources
