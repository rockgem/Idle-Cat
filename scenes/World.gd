extends Node2D





func _ready():
	ManagerGame.connect("item_bought", self, 'on_item_bought')
	ManagerGame.connect("item_storage_clicked", self, 'on_item_bought')
	
	load_furnitures()


# essentially just spawns the object to world either from shop or storage
func on_item_bought(item_id: String):
	var obj = load("res://actors/Object.tscn").instance()
	obj.texture = load("res://assets/furniture_wall_floor_cat/objs/%s.png" % item_id)
	obj.item_id = item_id
	$YSort.add_child(obj)
	
	obj.global_position = $ItemSpawn.global_position


func load_furnitures():
	for obj in ManagerGame.player_data['world_objs']:
		var o = load("res://actors/Object.tscn").instance()
		o.texture = load("res://assets/furniture_wall_floor_cat/objs/%s.png" % obj['item_id'])
		o.item_id = obj['item_id']
		o.obj_data = obj
		o.is_from_load = true
		$YSort.add_child(o)
		
		o.flip_h = obj['rotated']
		o.global_position = Vector2(obj['global_position_x'], obj['global_position_y'])
