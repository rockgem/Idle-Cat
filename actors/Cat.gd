extends Sprite



func _ready():
	ManagerGame.connect("studying_activated", self, 'on_studying_activated')
	
	if ManagerGame.player_data['is_studying']:
		on_studying_activated(true)


func on_studying_activated(b):
	if b:
		texture = load("res://assets/furniture_wall_floor_cat/objs/Black cat sitting.png")
		$Book.show()
	else:
		texture = load("res://assets/furniture_wall_floor_cat/objs/Black cat standing.png")
		$Book.hide()
