extends Node


signal item_bought(item_id)
signal item_clicked(own)
signal item_storage_clicked(item_id)

signal studying_activated(boolean)


var floor_tiles_ref: TileMap


const SAVE_PATH = 'user://player_data.json'

# this is where all items in the game is stored
# will be used in shop buying to search thru the items' data
var all_items: Dictionary = {}


########################################################################
# the base dictionary for objects to be remembered when loading savefile
# stored in player_data['world_objs'] array
var world_obj_base = {
	'item_id': '',
	'global_position_x': 0.0,
	'global_position_y': 0.0,
	'rotated': false
}
########################################################################
########################################################################

var player_data: Dictionary = {
	'is_studying': false,
	'study_time_left': 0.0,
	'money': 100,
	'inv_items': {},
	'world_objs': [] # array of world_obj_base dictionaries
}


# is used when placing an object in world
var is_placing: bool = false

var payment


func _ready():
	if Engine.has_singleton('GodotGooglePlayBilling'):
		payment = Engine.get_singleton('GodotGooglePlayBilling')
		
		payment.connect('billing_resume', self, 'on_billing_resume')
		payment.connect('connected', self, 'on_connected')
		
		payment.startConnection()
	else:
		print("Android IAP support is not enabled. Make sure you have enabled 'Custom Build' and the GodotGooglePlayBilling plugin in your Android export settings! IAP will not work.")
	
	var f = File.new()
	f.open("res://resources/data/all_items.json", f.READ)
	all_items = parse_json(f.get_as_text())
	
	if f.file_exists(SAVE_PATH):
		load_game()
	
	f.close()


func load_game():
	var f = File.new()
	f.open(SAVE_PATH, f.READ)
	player_data = parse_json(f.get_as_text())
	f.close()


func save_game():
	var f = File.new()
	f.open(SAVE_PATH, f.WRITE)
	f.store_string(JSON.print(player_data))
	f.close()


func add_item_to_storage(item_id: String):
	var data = all_items.get(item_id)
	data['stack'] = 1

	if player_data['inv_items'].has(item_id):
		player_data['inv_items'].get(item_id)['stack'] += 1
	else:
		player_data['inv_items'][item_id] = data


func buy_item(item_id: String):
	if all_items.has(item_id) == false:
		return
	
	emit_signal("item_bought", item_id)


func secs_to_time(secs: float) -> String:
	var minute = str(int(secs / 60))
	var seconds = str(int(secs) % 60)
	
	if minute.length() <= 1:
		minute = minute.insert(0, '0')
	if seconds.length() <= 1:
		seconds = seconds.insert(0, '0')
	
	return minute + ':' + seconds


func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		save_game()
