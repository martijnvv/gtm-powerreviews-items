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
  "categories": ["PERSONALIZATION", "MARKETING"],
  "description": "We populate the items in the order in the format for Power Reviews",
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
  },
  {
    "type": "RADIO",
    "name": "configType",
    "displayName": "Type of configuration",
    "radioItems": [
      {
        "value": "ga4Standard",
        "displayValue": "GA4 Standard Item Configuration"
      },
      {
        "value": "custom",
        "displayValue": "Custom Item Configuration"
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "Standard Configuration",
    "displayName": "Standard Configuration",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "ga4Standard",
        "checkboxText": "Use the GA4 standard mapping as described above",
        "simpleValueType": true,
        "defaultValue": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "configType",
        "paramValue": "ga4Standard123",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "customConfig",
    "displayName": "Custom Configuration",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "arrayName",
        "displayName": "Object  to collect data from (this is a variable in GTM)",
        "simpleValueType": true,
        "help": "This is the ecommerce.items array in GA4 standard setup"
      },
      {
        "type": "TEXT",
        "name": "prod_id",
        "displayName": "product_id variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "name",
        "displayName": "Product name variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "price",
        "displayName": "Product price variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "quantity",
        "displayName": "Quantity variable to map",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "variant",
        "displayName": "Product variant name",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "configType",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromDataLayer = require('copyFromDataLayer');
const math = require('Math');
const getType = require('getType');
var log = require('logToConsole');

var configType = data.configType;


if (configType === 'ga4Standard') {
	const mapProductData = i => {
	  const itemObj = {
		page_id: i.item_id,
		product: i.item_name,
		unit_price: i.price,
		quantity: i.quantity ? math.round(i.quantity) : i.quantity,
        page_id_variant: i.item_variant
	  };
	  return itemObj;
	};

	const eec = copyFromDataLayer('ecommerce', 1) || {};
	  if (getType(eec.items) === 'array') {
		return eec.items.map(i => {
		  const product = mapProductData(i);
          log(product);
		  return product;
		});
	}
        
		return [];
} else if (configType === 'custom') {
  var br_prod_id = data.prod_id;
  var br_sku = data.sku;
  var br_item_name = data.item_name;
  var br_price = data.price;
  var br_quantity = data.quantity;
  var br_variant = data.variant;

  function mapProductData(i) {
    var itemObj = {
      prod_id: i.data.prod_id,
      sku: i.data.sku,
      name: i.data.name ? i.data.name.split('!').join('') : i.data.name,
      price: i.data.price,
      quantity: i.data.quantity ? math.round(i.data.quantity) : i.data.quantity,
      page_id_variant: i.data.variant
    };
    log(itemObj);
    return itemObj;
  }

  var eec = copyFromDataLayer(data.arrayName, 1) || {};
  log(eec);
  if (getType(eec.items) === 'array') {
    var outputCustom = [];
    for (var k = 0; k < eec.length; k++) {
      outputCustom.push(mapProductData(eec[k]));
    }
    return outputCustom;
  }
  return [];
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
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 9-8-2024 16:42:55


