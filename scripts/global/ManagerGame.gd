extends Node


signal item_bought(item_id)
signal item_clicked(own)
signal item_storage_clicked(item_id)



const SAVE_PATH = 'user://player_data.json'

# this is where all items in the game is stored
# will be used in shop buying to search thru the items' data
var all_items: Dictionary = {}

var world_obj_base = {
	'item_id': '',
	'global_position_x': 0.0,
	'global_position_y': 0.0,
	'rotated': false
}


var player_data: Dictionary = {
	'money': 100,
	'inv_items': {},
	'world_objs': []
}


# is used when placing an object in world
var is_placing: bool = false


func _ready():
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


func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		save_game()
