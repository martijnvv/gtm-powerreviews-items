# Google Tag Manager Power Reviews product object builder

This GTM tag template populates the products object based on the GA4 items object.
This is required as part of the Power Reviews Checkout Beacon functionality. This is one of two methods to send data to Power Reviews (alternative is API) and is the only way to populate the Conversion Analytics reports in the reporting suite.
More details on the Checkout Beacon can be found [here](https://help.powerreviews.com/hc/en-us/articles/7533484327707-Adding-the-Checkout-Beacon).

## How it works

Include the following script in a Custom HTML tag. Replace the *{{powerreviews_items_array}}* part of the code with the GTM variable name created with this custom template.

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
