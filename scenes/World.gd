extends Node2D





func _ready():
	ManagerGame.connect("item_bought", self, 'on_item_bought')


func on_item_bought(item_id: String):
	var obj = load("res://actors/Object.tscn").instance()
	obj.texture = load("res://assets/furniture_wall_floor_cat/objs/%s.png" % item_id)
	obj.item_id = item_id
	$YSort.add_child(obj)
	
	obj.global_position = $ItemSpawn.global_position
