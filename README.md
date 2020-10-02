# Announcement microservice application
The application consists of:
* 1 AWS Api Gateway
* 2 Lambdas
* 1 DynamoDB table

# Prerequisites
* AWS account
* aws-cli installed on your host and configured

# How to deploy
1. Clone the repo
```
git clone https://github.com/vadymbat/aws-serverless-announcement-microservice.git \
    && cd aws-serverless-announcement-microservice
```

2. Configure access to AWS
```
export AWS_DEFAULT_REGION='eu-central-1'
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export AWS_SESSION_TOKEN=''
```

3. Deploy the application
```
bash deploy.sh
```

4. Clean the resourses
```
bash cleanup.sh
```


# How to test
* After deploy script is finished in the output find the Api ulr:
```
The API is available at https://213m57v17g.execute-api.eu-central-1.amazonaws.com/dev/announcement
```

* Create an announcement using the url you got:
```
curl --request POST \
  --url https://213m57v17g.execute-api.eu-central-1.amazonaws.com/dev/announcement \
  --header 'content-type: application/json' \
  --data '{
        "title" : "Test Title",
        "date" : "2011-11-04 2211",
        "description": "Test description"
}'
```

* List all the announcements:

```
curl --request GET \
  --url https://213m57v17g.execute-api.eu-central-1.amazonaws.com/dev/announcement \
  --header 'content-type: application/json'
```