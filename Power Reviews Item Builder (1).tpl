___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Power Reviews Item Builder",
  "description": "We populate the items in the order in the format for Power Reviews using the GA4 items object",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "description",
    "displayName": "This variable returns an array of objects with the following variables: \u003c/br\u003e\n\u003cul\u003e\n\u003cli\u003epage_id (item_id)\u003c/i\u003e\n\u003cli\u003eproduct (item_name)\u003c/i\u003e\n\u003cli\u003eunit_price (price)\u003c/i\u003e\n\u003cli\u003equantity (quantity)\u003c/i\u003e\n\u003c/ul\u003e\n\u003cbr/\u003e\nThe variables are mapped from the GA4 items object."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');
const math = require('Math');
const getType = require('getType');


const mapProductData = i => {
  const itemObj = {
    page_id: i.item_id,
    product: i.item_name,
    unit_price: i.price,
    quantity: i.quantity ? math.round(i.quantity) : i.quantity
  };
  return itemObj;
};

const eec = copyFromDataLayer('ecommerce', 1) || {};
  if (getType(eec.items) === 'array') {
    return eec.items.map(i => {
      const product = mapProductData(i);
      return product;
    });
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 9-8-2024 16:42:55


