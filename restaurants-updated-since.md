# Restaurants - Updated Since

```
The following documentation is provisional, and has not yet been accepted in to service
Swagger documentation for this provisional patch can be found here: https://app.swaggerhub.com/apis/infinityworks/dcg-restaurant-service/1.4.1
```

The restaurant api supports the option of sending an `updatedSince` parameter, in the format of a ISO 8601 date format (example: `2018-04-07T15:44:42Z`) 

This interface can be used in instances where a client has stored a cache of all restaurants, and wishes to update it's local cache, but only wishes to update the delta. This document outlines some basic implementation steps you will need to undertake, to use this interface correctly.

The restaurant API returns two fields that are important to discovering the delta of changes: `updatedAt` and `deletedAt` both of these fields are in the ISO 8601 date format. By using the combination of these fields, a client can determine if a local record needs to be updated/added or removed.

## Example use case

If your client last hit the API on `2018-01-01T00:00:00Z` you send a request through to the restaurant API today with that date in the `updatedSince` parameter. The api response might then look something like this:

*(Note: This response has been shorterned for brevity in documentation, restaurants would contain all usual data)*

```
[
    {
        // This restaurant would not be returned, as it's updatedAt is before the updatedSince given 
        "id": "yvmrQO82wvWa37k4",
        "type": "restaurant",
        "name": "1 Brasserie @ Downstairs",
        "updatedAt": "2017-12-22T15:32:22Z",
        "deletedAt": null,
        ...
    },
    {
        "id": "PNj6VMBAjAYLJogk",
        "type": "restaurant",
        "name": "11 Brasserie @ No 11",
        "updatedAt": "2018-01-03T12:11:10Z",
        "deletedAt": null,
        ...
    },
    {
        "id": "y0O6bYdbml8w9oDA",
        "type": "restaurant",
        "name": "113 Restaurant & Bar @ the Law Society",
        "updatedAt": "2018-01-17T17:32:22Z",
        "deletedAt": "2018-01-18T00:00:00Z",
        ...
    },
    {
        // This restaurant would not be returned, as it's updatedAt is before the updatedSince given
        "id": "x3Qbzj8xO4M26De5",
        "type": "restaurant",
        "name": "143 the Canopy Restaurant",
        "updatedAt": "2017-12-22T17:00:07Z",
        "deletedAt": null,
        ...
    }
]
```

In the above example, you would need to perform the following actions on your cache, for each restaurant:

- yvmrQO82wvWa37k4 - Nothing - Wouldn't be returned
- PNj6VMBAjAYLJogk - Replace the restaurant in your local cache, the restaurant was updated on the 3rd of Jan
- y0O6bYdbml8w9oDA - Remove this restaurant from your local cache, it has it's `deletedAt` date set
- x3Qbzj8xO4M26De5 - Nothing - Wouldn't be returned

The basic rules of a cache update are as follows:

1. If the deletedAt date has been set, then remove the restaurant from your local cache
2. If the updatedAt date is after your last cache update, update your local cache of that restaurant
3. If you have no record of a restaurant in your cache, add it to your cache


