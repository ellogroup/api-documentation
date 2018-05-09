# Restaurants - Updated Since

The restaurant API supports the option of sending an `updatedSince` parameter, in the format of an ISO 8601 date format
(example: `2018-04-07T15:44:42Z`).

This interface can be used in instances where a client has stored a cache of all restaurants, and wishes to update its
local cache, but only wishes to update the delta. This document outlines some basic implementation steps you will need
to undertake, to use this interface correctly.

The restaurant API returns two fields that are important to discovering the delta of changes: `updatedAt` and
`deletedAt` both of these fields are in the RFC3339 date format (ISO 8601 compatible). By using the combination of these
fields, a client can determine if a local record needs to be updated/added or removed.

The restaurant API also returns a custom response header `X-Cache-Updated` in RFC3339 format, which specifies when the
API's cache was last rebuilt. When requesting a delta of changes, the client should always set the `updatedSince`
parameter to the value received from this header in the previous request to the same endpoint.

## Example use case

A client has previously hit the restaurant list endpoint on `2018-01-01T12:00:00Z` and received an `X-Cache-Updated`
header containing `2018-01-01T06:00:00Z`.
The next request should set the `updatedSince` parameter to `2018-01-01T06:00:00Z` (cache rebuild time).
The code block below shows examples of restaurants that would and would not be returned in the response.

*(Note: This response has been shortened for brevity in documentation, restaurants would contain all usual data)*

```
[
    {
        // This restaurant would not be returned, as its updatedAt is before the updatedSince given
        "id": "yvmrQO82wvWa37k4",
        "type": "restaurant",
        "name": "1 Brasserie @ Downstairs",
        "updatedAt": "2017-12-22T15:32:22Z",
        "deletedAt": null,
        ...
    },
    {
        // This restaurant would be returned as it has been updated since the updatedSince
        "id": "PNj6VMBAjAYLJogk",
        "type": "restaurant",
        "name": "11 Brasserie @ No 11",
        "updatedAt": "2018-01-03T12:11:10Z",
        "deletedAt": null,
        ...
    },
    {
        // This restaurant would be returned as it has been deleted since the updatedSince
        "id": "y0O6bYdbml8w9oDA",
        "type": "restaurant",
        "name": "113 Restaurant & Bar @ the Law Society",
        "updatedAt": "2018-01-17T17:32:22Z",
        "deletedAt": "2018-01-18T00:00:00Z",
        ...
    },
    {
        // This restaurant would not be returned, as its deletedAt is before the updatedSince given
        "id": "x3Qbzj8xO4M26De5",
        "type": "restaurant",
        "name": "143 the Canopy Restaurant",
        "updatedAt": "2017-12-21T17:00:07Z",
        "deletedAt": "2017-12-22T17:00:07Z",
        ...
    }
]
```

In the above example, you would need to perform the following actions on your cache, for each restaurant:

- yvmrQO82wvWa37k4 - Nothing - Would not be returned
- PNj6VMBAjAYLJogk - Add or update the restaurant in your local cache, the restaurant was updated on the 3rd of Jan
- y0O6bYdbml8w9oDA - Remove this restaurant from your local cache, it has its `deletedAt` date set
- x3Qbzj8xO4M26De5 - Nothing - Would not be returned

The basic rules of a cache update are as follows:

1. If the deletedAt date has been set, then remove the restaurant from your local cache
2. If the updatedAt date is after your last cache update, update your local cache of that restaurant
3. If you have no record of a restaurant in your cache, add it to your cache

## Notes

Deleted restaurants will only be returned if the `updatedSince` parameter has been specified.

There will be always be multiple instances of the restaurant API running and each will construct its cache
independently. As a result of this, it's possible that the same restaurant update or deletion will be returned in
successive requests. The client implementation should be designed to gracefully handle the deletion of a restaurant that
has already been deleted from the client cache.
