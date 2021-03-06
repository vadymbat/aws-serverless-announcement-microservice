# Announcement microservice application CICD in AWS
The CICD pipeline for the applicaiton consists of the stages:
- GitHub Webhook
- Build
- Deploy
- Run tests

![CICD architecture](../img/announcement_app_cicd.svg)

# How to deploy the CICD solution
1. Fork the repo https://github.com/vadymbat/aws-serverless-announcement-microservice.git
2. Clone your forked repo
```
git clone https://github.com/vadymbat/aws-serverless-announcement-microservice.git \
    && cd aws-serverless-announcement-microservice
```

3. Configure access to AWS
```
export AWS_DEFAULT_REGION='eu-central-1'
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export AWS_SESSION_TOKEN=''
```

4. Clean the Application resources (if deployed)
```
bash -e cleanup.sh
```

5. Set up GitHub personal token with read access to the repo and export it to the CLI
```
export GITHUB_PERSONAL_TOKEN=''
```

6. Deploy the CICD stack
```
bash -e cicd/cicd_setup.sh
```

# How to remove the resources
1. Configure access to AWS
```
export AWS_DEFAULT_REGION='eu-central-1'
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export AWS_SESSION_TOKEN=''
```

2. Remove the application resources
```
bash -e cleanup.sh
```

3. Remove CICD infrastructure
```
bash -e cicd/cicd_cleanup.sh
```
