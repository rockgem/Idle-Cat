extends Sprite


# this is used to prevent clicking other objs while moving this object
var is_selected: bool = false
var item_id

var is_from_load: bool = false

var obj_data = {}


func _ready():
	offset.x -= float(int(get_rect().size.x) / 2)
	offset.y -= float(int(get_rect().size.y) - 24) + 8
	activate_placement(false)
	
	if is_from_load == false:
		obj_data = ManagerGame.world_obj_base.duplicate()
		obj_data['item_id'] = item_id
		ManagerGame.player_data['world_objs'].append(obj_data)


func _unhandled_input(event):
	if event is InputEventScreenTouch and !event.pressed and ManagerGame.is_placing == false and is_selected == false:
		if get_rect().has_point(to_local(event.position)):
			activate_placement(true)
			ManagerGame.emit_signal("item_clicked", self)
	
	if event is InputEventScreenTouch and !event.pressed and ManagerGame.is_placing and is_selected:
		var l_pos = ManagerGame.floor_tiles_ref.world_to_map(event.position)
		var g_pos = ManagerGame.floor_tiles_ref.map_to_world(l_pos)
		
		var has_tile = false
		if ManagerGame.floor_tiles_ref.get_cellv(l_pos) != -1:
			has_tile = true
		
		if has_tile == false:
			return
		
		$"/root/Sfx".get_node('Pop1').play()
		
#		global_position = Vector2(stepify(event.position.x, 16), stepify(event.position.y, 8))
		global_position = g_pos


func activate_placement(b: bool):
	ManagerGame.is_placing = b
	is_selected = b
	
	if b:
		modulate = Color(1,1,1,0.5)
	else:
		modulate = Color(1,1,1,1)
	
