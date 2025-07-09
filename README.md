# Google Tag Manager Power Reviews product object builder

This GTM tag template populates the products array based on the GA4 items raay or a custom product array.
This array is required as part of the Power Reviews Checkout Beacon functionality. This is one of two methods to send data to Power Reviews (alternative is API) and is the only way to populate the Conversion Analytics reports in the reporting suite.
More details on the Checkout Beacon can be found [here](https://help.powerreviews.com/hc/en-us/articles/7533484327707-Adding-the-Checkout-Beacon).

## How it works

Include the following script in a Custom HTML tag. Replace the *{{powerreviews_items_array}}* part of the code with the GTM variable name created with this custom template.
Don't forget to update the other variables in the custom HTML tag as well.

```javascript
<script type="text/javascript" src="//static.powerreviews.com/t/v1/tracker.js">
</script>

<script type="text/javascript">
   (function(){try{

   var tracker = POWERREVIEWS.tracker.createTracker({
	merchantGroupId: 'MERCHANT_GROUP_ID'});

	var orderFeed = {
		merchantGroupId: 'MERCHANT_GROUP_ID',
   		merchantId: 'MERCHANT_ID',
		locale: 'LOCALE',
		merchantUserId: 'INTERNAL_CUSTOMER_ID',
		marketingOptIn: true,
		userEmail: 'CUSTOMER_EMAIL ADDRESS',
		userFirstName: 'CUSTOMER FIRST_NAME',
		userLastName: 'CUSTOMER LAST_NAME',
		orderId: 'ORDER_ID',
		orderItems: {{powerreviews_items_array}}
	}
	tracker.trackCheckout(orderFeed);

}catch(e){window.console && window.console.log(e)}}());
</script>
```
## Variable Mapping

We have two versions of variable mapping available:
* GA4 Standard Item Configuration
* Custom Item Configuration

### GA4 Standard Item Configuration

This is based on the standard GA4 items object and variable cannot be changed

The variables are mapped:
* page_id --> item_id
* product_name -->> item_name
* quantity -->> quantity
* unit_price -->> price
* page_id_variant -->> item_variant

### Custom Item Configuration

This is a custom format. You can define the array which contains the product objects and define each of the product variables individually.
