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
# the base dictionary for objects to be remebered when loading savefile
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
	'money': 50,
	'inv_items': {}, # anything that is in storage
	'world_objs': [] # array of world_obj_base dictionaries, anything that is already placed
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
	
	var price = all_items.get(item_id)['price']
	ManagerGame.player_data['money'] -= price
	
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
