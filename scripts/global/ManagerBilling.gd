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
		
		payment.startConnection()
	else:
		print("Android IAP support is not enabled. Make sure you have enabled 'Custom Build' and the GodotGooglePlayBilling plugin in your Android export settings! IAP will not work.")


func process_purchase(purchase):
	payment.consumePurchase(purchase.purchase_token)


func on_purchase_updated(purchase):
	process_purchase(purchase)


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
