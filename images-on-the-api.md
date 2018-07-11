# Images on the restaurant API

## Terms

`Legacy images` and `dcg-internal` - Images that are used on the existing tastecard/gourmet/hi-life websites. Of variable quality and size.
`New images` and images tagged with `food`, `interior` and `exterior` - Images that have been more recently procured, and are of professional quality and size

## Overview

In a standard restaurant object, you will receive two image bearing properties. `images[]` and `primaryImage{}`.

PrimaryImage is a hand selected image by the DCG restaurant team, that shows the restaurant at it's best. This primaryImage block will only ever contain images from the `legacy` set of images.

The `images[]` block could contain any of the following options:

* No images
* Only legacy images (all tagged with `dcg-internal`) 
* Only new images (either with no tags, or with one or more of the above specified tags)
* A mixture of old and new images (complies to the above rules re: tagging)

If your application chooses to show the new images rather than the legacy images, we suggest you take the 0th new image and treat it as the primary.

Below is a sample response from the API, that has been annotated to include this information:

```json
{
   "id":"d4KOo8QANm8zplnG",
   "type":"restaurant",
   "name":"11 Brasserie @ No 11",
   "cuisines":[
      {
         "id":"oA3rOX8VgBW40Vly",
         "name":"British"
      },
      {
         "id":"rjR798NPNGYnO62G",
         "name":"Carvery/Buffet"
      },
      {
         "id":"mPG7xYkZdwW2zv1o",
         "name":"Modern English"
      }
   ],
   "chain":{
      "id":"",
      "name":""
   },
   "brand":{
      "id":"GBpYNlrGeXLMPoz3",
      "name":"Tastecard"
   },
   // PrimaryImage block - This block can be ignored by you in your implementation.
   "primaryImage":{
      "href":"https://www.hi-life.co.uk/restaurant-images/20587/82101.jpg",
      "id":"bnw128okyQ38d9mx",
      "tags":[
         "dcg-internal"
      ]
   },
   "website":"https://www.11brunswickst.co.uk",
   "bookingTelephone":"01315 576910",
   "bookingEmail":"",
   "bookingUrl":"",
   "isBookingRequired":false,
   "address":{
      "country":"United Kingdom",
      "postcode":"EH7 5JB",
      "building":"11 Brunswick Street",
      "street":" ",
      "town":"Edinburgh",
      "county":""
   },
   "geo":{
      "lat":55.958753,
      "long":-3.1796416
   },
   "images":[
      // Each of the following 5 images an """"old"""" image, they are tagged as 
      // dcg-internal meaining that their quality can't be guaranteed.
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/82101.jpg",
         "id":"bnw128okyQ38d9mx",
         "tags":[
            "profile",
            "dcg-internal"
         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/82102.jpg",
         "id":"Kovm5MmGjAaWzgLA",
         "tags":[
            "dcg-internal"
         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/82103.jpg",
         "id":"kVzO1MXNwZPWDxXg",
         "tags":[
            "dcg-internal"
         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/82104.jpg",
         "id":"6OwPkW1z4AgYByN1",
         "tags":[
            "dcg-internal"
         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/82105.jpg",
         "id":"KJw5EMJxq4xWAZ1r",
         "tags":[
            "dcg-internal"
         ]
      },
      // The following 5 images are new images. This restaurant has both new and old images
      // that are not tagged as dcg-internal, then your app should ignore the primaryImage and dcg-internal images
      // and use these.  Currently, there is no other tags on these images (although those are expected to filter in over time)
      // (things like "exterior", and "food" and similar). Right now, you can take these images with tag arrays
      // that do not have the `dcg-internal` tag as your images to sue.

      // If a restaurant doesn't have any images without the "dcg-internal" tag, then you will have to use the 
      // dcg-internal images.  There's nothing wrong with them, and they have been checked and validated, and are live 
      // on the respective brand website (tastecard,hi-life,gourmet).  But they are likely to be small (600x600 or so), and are not guaranteed to be
      // professionally taken.
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/18606-000.jpg",
         "id":"57Op0Y7wBGY29kJ4",
         "tags":[

         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/18606-001.jpg",
         "id":"6vgEyY6zBkYJk79x",
         "tags":[

         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/18606-002.jpg",
         "id":"Z6DbkY9KJQ8jwKVR",
         "tags":[

         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/18606-003.jpg",
         "id":"2P6N3W39LRM45j0O",
         "tags":[

         ]
      },
      {
         "href":"https://www.hi-life.co.uk/restaurant-images/20587/18606-004.jpg",
         "id":"blZA4855BX8Pj2Lv",
         "tags":[

         ]
      }
   ],
   "description":"11 Brasserie @ No 11 put their focus on h.. long description here...",
   "offers":[
      {
         "id":"zEnaoYDp65YKevrA",
         "name":"2 for 1 meals",
         "maxDiners":6,
         "availability":{
            "monday":{
               "day":true,
               "evening":true
            },
            "tuesday":{
               "day":true,
               "evening":true
            },
            "wednesday":{
               "day":true,
               "evening":true
            },
            "thursday":{
               "day":true,
               "evening":true
            },
            "friday":{
               "day":true,
               "evening":false
            },
            "saturday":{
               "day":true,
               "evening":false
            },
            "sunday":{
               "day":true,
               "evening":true
            }
         }
      }
   ],
   "maxDiners":6,
   "updatedAt":"2018-07-06T14:39:10Z",
   "deletedAt":null
}```
