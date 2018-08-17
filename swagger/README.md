# DCG Swagger Docs

Complete API documentation is authoritatively managed with [Swagger Hub](https://app.swaggerhub.com/apis/the-dcg/)

## Updating

When a new version is published on Swagger Hub it can be updated here by running

```make update```

in this directory.

This will sync the latest published version of the API specs and update the following files:
```
membership-service-version.txt
membership-service.yaml
restaurant-service-version.txt
restaurant-service.yaml
```
