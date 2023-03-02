extends Sprite



func _ready():
	ManagerGame.connect("studying_activated", self, 'on_studying_activated')


func on_studying_activated(b):
	if b:
		texture = load("res://assets/furniture_wall_floor_cat/objs/Black cat sitting.png")
	else:
		texture = load("res://assets/furniture_wall_floor_cat/objs/Black cat standing.png")
