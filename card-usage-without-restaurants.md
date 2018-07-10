# Submitting & retrieving card usage without a restaurant

A recent change allows you to submit a memberships card usage event without submitting the ID of the restaurant that the customer was visiting at the time.

This change removes some entities from the card usage response, and from the list & get interfaces for previous card usages.

Here is an example request & response for creating a card usage:

Request:
```
POST /membership/Pj3mpRrl3Ev0Bb7D/cardUsage HTTP/1.1
Host: membership.api.url.here.com
X-Consumer-Token: ey....lE
Cache-Control: no-cache

{
  "platform": "web",
  "restaurantId": null
}
```

Response:
```
{
    "id": "RD027xVaNBr34ylA",
    "membershipId": "Pj3mpRrl3Ev0Bb7D",
    "restaurantId": null,
    "platform": "web",
    "usageTime": "2018-07-10T10:51:50+00:00",
    "membership": {
        "id": "Pj3mpRrl3Ev0Bb7D",
        "status": "Active",
        "started": "2018-07-08T09:19:32+00:00",
        "expires": "2019-07-09T09:19:32+00:00",
        "product": {
            "id": "n70zqPXBaxA9RdJ4",
            "name": "Annual Membership"
        },
        "trialPeriod": {
            "unit": 0,
            "period": "month"
        },
        "terms": null,
        "type": "B2C",
        "number": "33000000",
        "cardNumber": "33000000",
        "cardholderName": "Mr Test33 User33"
    }
}
```

Notice that from the above response, several normal fields are missing:

`brand` - This field (containing the brand of the restaurant that the user is visiting) cannot be returned when no restaurant is provided
`offer` - This field (containing the offer that the user has used at that restaurant) cannot be returned when no restaurant is provided

These fields are also missing from the list interface:

Request:
```
GET /membership/Pj3mpRrl3Ev0Bb7D/cardUsage HTTP/1.1
Host: membership.api.url.here.com
X-Consumer-Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjRmMWcyM2ExMmFhIn0.eyJpc3MiOiJodHRwOlwvXC9leGFtcGxlLmNvbSIsImF1ZCI6Imh0dHA6XC9cL2V4YW1wbGUub3JnIiwianRpIjoiNGYxZzIzYTEyYWEiLCJpYXQiOjE1MzEyMTk5MDIsIm5iZiI6MTUzMTIxOTk2MiwiZXhwIjoxNTMxMjIzNTAyLCJ1aWQiOjF9.BY-bwKrjbZm2CD_kBMrzl_rqq4meJCItT9NKckyxFd8n5f4pY0pxujNSqs6yG0WCmL6liAhrtg-WIHaISGyhLrvAP9RpRpNuOVu60BgMQGrpv-D3_IG1SxT_bgmacuvQmE7lq35_L3PVWQEeIgsPO2LXZ-G0UBqt523ADzN-0qFw5gy6ykRBV3cDJbnVflf17poe6czCaPzG2ylZ5ZuSevPr2wGMgazDWXwLGxT0jKJBTe56fdLkpwz3x1Gtr8jMQN7lqtiAYRu8JGPmf6kQ_JEDthaUYRmTuCtR-UXwGKldjpaet1yhGms_KYqsoeTYySwAo0lYbY0O_Y_yKvKOYSGdDI6194KwV4yMzoxWSOOXjOhY5d9jXBsXgepXzf0nlev2z3VjcZl6dizxFcv8w8iqwQV40SLcA5Qqk3Vqs_E74EPoE-FcG125wjwT1fhg2wIqPuqagaQyofbJEQ7KzemdXhEpZRQBMLO4RuXYT2-SIl0-KVgDPRp5CzttyM_A6Wfzo2f_Dlo4IrWxOTh-2mtOl0Zmh0FJbBN50pD7EhWflD6xdxwuyF_3OzkxZHiwf7soMBJmnX4jqZQvu77wSthD_P13PolSszCPTDQD71feHoNVPWMGadcHiz_Hg6oZedZ4dhLH_bHNVmZffA8tofHaO2XsZUi9eE-mrtPMWlE
Cache-Control: no-cache

```

Response:
```
[
    {
        "id": "RD027xVaNBr34ylA",
        "membershipId": "Pj3mpRrl3Ev0Bb7D",
        "restaurantId": null,
        "platform": "web",
        "usageTime": "2018-07-10T10:51:50+00:00"
    }
]
```

And from the individual GET interface


Request:

```
GET /membership/Pj3mpRrl3Ev0Bb7D/cardUsage/RD027xVaNBr34ylA HTTP/1.1
Host: membership.api.url.here.com
X-Consumer-Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjRmMWcyM2ExMmFhIn0.eyJpc3MiOiJodHRwOlwvXC9leGFtcGxlLmNvbSIsImF1ZCI6Imh0dHA6XC9cL2V4YW1wbGUub3JnIiwianRpIjoiNGYxZzIzYTEyYWEiLCJpYXQiOjE1MzEyMTk5MDIsIm5iZiI6MTUzMTIxOTk2MiwiZXhwIjoxNTMxMjIzNTAyLCJ1aWQiOjF9.BY-bwKrjbZm2CD_kBMrzl_rqq4meJCItT9NKckyxFd8n5f4pY0pxujNSqs6yG0WCmL6liAhrtg-WIHaISGyhLrvAP9RpRpNuOVu60BgMQGrpv-D3_IG1SxT_bgmacuvQmE7lq35_L3PVWQEeIgsPO2LXZ-G0UBqt523ADzN-0qFw5gy6ykRBV3cDJbnVflf17poe6czCaPzG2ylZ5ZuSevPr2wGMgazDWXwLGxT0jKJBTe56fdLkpwz3x1Gtr8jMQN7lqtiAYRu8JGPmf6kQ_JEDthaUYRmTuCtR-UXwGKldjpaet1yhGms_KYqsoeTYySwAo0lYbY0O_Y_yKvKOYSGdDI6194KwV4yMzoxWSOOXjOhY5d9jXBsXgepXzf0nlev2z3VjcZl6dizxFcv8w8iqwQV40SLcA5Qqk3Vqs_E74EPoE-FcG125wjwT1fhg2wIqPuqagaQyofbJEQ7KzemdXhEpZRQBMLO4RuXYT2-SIl0-KVgDPRp5CzttyM_A6Wfzo2f_Dlo4IrWxOTh-2mtOl0Zmh0FJbBN50pD7EhWflD6xdxwuyF_3OzkxZHiwf7soMBJmnX4jqZQvu77wSthD_P13PolSszCPTDQD71feHoNVPWMGadcHiz_Hg6oZedZ4dhLH_bHNVmZffA8tofHaO2XsZUi9eE-mrtPMWlE
Cache-Control: no-cache

```


Response:
```
{
    "id": "RD027xVaNBr34ylA",
    "membershipId": "Pj3mpRrl3Ev0Bb7D",
    "restaurantId": null,
    "platform": "web",
    "usageTime": "2018-07-10T10:51:50+00:00",
    "membership": {
        "id": "Pj3mpRrl3Ev0Bb7D",
        "status": "Active",
        "started": "2018-07-08T09:19:32+00:00",
        "expires": "2019-07-09T09:19:32+00:00",
        "product": {
            "id": "n70zqPXBaxA9RdJ4",
            "name": "Annual Membership"
        },
        "trialPeriod": {
            "unit": 0,
            "period": "month"
        },
        "terms": null,
        "type": "B2C",
        "number": "33000000",
        "cardNumber": "33000000",
        "cardholderName": "Mr Test33 User33"
    }
}
```
