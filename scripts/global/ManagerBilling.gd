extends Node

var payment

func _ready():
	if Engine.has_singleton('GodotGooglePlayBilling'):
		payment = Engine.get_singleton('GodotGooglePlayBilling')
		
		payment.connect('billing_resume', self, 'on_billing_resume')
		payment.connect('connected', self, 'on_connected')
		payment.connect('purchase_updated', self, 'on_purchase_updated')
		payment.connect('purchase_error', self, 'on_purchase_error')
		payment.connect('purchase_consumed', self,'on_purchase_consumed')
		payment.connect('purchase_consumption_error', self, 'on_purchase_consumption_error')
		payment.connect("sku_details_query_completed", self, "on_sku_details_query_completed") # SKUs (Dictionary[])
		payment.connect("sku_details_query_error", self, "on_sku_details_query_error") # Response ID (int), Debug message (string), Queried SKUs (string[])
		
		payment.startConnection()
	else:
		print("Android IAP support is not enabled. Make sure you have enabled 'Custom Build' and the GodotGooglePlayBilling plugin in your Android export settings! IAP will not work.")


func on_connected():
	payment.querySkuDetails(["my_iap_item"], "inapp")


func on_sku_details_query_completed(sku_details):
	for available_sku in sku_details:
		print(available_sku)


func process_purchase(purchase):
	payment.consumePurchase(purchase.purchase_token)


func on_purchase_updated(purchases):
	var query = payment.queryPurchases("inapp") # Or "subs" for subscriptions
	if query.status == OK:
		for purchase in query.purchases:
			if purchase.sku == "my_consumable_iap_item" and purchase.purchase_state == 1:
				# enable_premium(purchase.sku) # add coins, save token on server, etc.
				payment.consumePurchase(purchase.purchase_token)
				# Or wait for the _on_purchase_consumed callback before giving the user what they bought


func purchase_error(response_id, error_message):
	print("purchase_error id:", response_id, " message: ", error_message)


func on_purchase_consumed(purchase_token):
	handle_purchase_token(purchase_token, true)


func on_purchase_consumption_error(response_id, error_message, purchase_token):
	print("_on_purchase_consumption_error id:", response_id,
			" message: ", error_message)
	handle_purchase_token(purchase_token, false)


func handle_purchase_token(purchase_token, purchase_successful):
	pass
	# check/award logic, remove purchase from tracking list
