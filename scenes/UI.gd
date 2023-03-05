extends Control

var ref = null

func _ready():
	ManagerGame.connect("item_clicked", self, 'on_item_clicked')
	ManagerGame.connect("item_storage_clicked", self, 'on_item_storage_clicked')
	
	if ManagerGame['player_data']['is_studying']:
		set_physics_process(true)
		$Layer1.hide()
	else:
		set_physics_process(false)
		$Layer1.show()


# this is only used to calculate time when studying at the moment
func _physics_process(delta):
	if ManagerGame.player_data['study_time_left'] <= 0:
		ManagerGame['player_data']['is_studying'] = false
		ManagerGame.player_data['study_time_left'] = 0.0
		
		var reward = ManagerGame.player_data['study_minute_chose']
		
		ManagerGame.player_data['money'] += reward
		ManagerGame.emit_signal("gold_changed")
		
		ManagerGame.emit_signal("studying_activated", false)
		$StudyingBox/Study.text = 'Study'
		
		set_physics_process(false)
		$Layer1.show()
		return
	
	ManagerGame.player_data['study_time_left'] -= delta
	
	$StudyingBox/Study.text = ManagerGame.secs_to_time(ManagerGame.player_data['study_time_left'])


func on_item_clicked(own):
	
	ref = own
	
	$Layer1.hide()
	$StudyingBox.hide()
	$PlacementControls.show()


func on_item_storage_clicked(item_id):
	$Layer1.show()
	$StudyingBox.show()
	$PlacementControls.hide()


func _on_Place_pressed():
	if ref:
		ref.activate_placement(false)
	else:
		return
	
	$Layer1.show()
	$StudyingBox.show()
	$PlacementControls.hide()
	
	ref.obj_data['global_position_x'] = ref.global_position.x
	ref.obj_data['global_position_y'] = ref.global_position.y
	ref.obj_data['rotated'] = ref.flip_h
	
	ref = null


func _on_Left_pressed():
	ref.flip_h = !ref.flip_h
	
	$"/root/Sfx".get_node('Pop1').play()


func _on_Buy_pressed():
	get_node('%Shop').show()


func _on_Storage_pressed():
	$StorageControl.show()


func _on_ToStorage_pressed():
	ManagerGame.player_data['world_objs'].erase(ref.obj_data)
	ManagerGame.add_item_to_storage(ref.item_id)
	$Layer1.show()
	$StudyingBox.show()
	$PlacementControls.hide()
	ref.activate_placement(false)
	ref.queue_free()
	
	ref = null


func _on_Study_pressed():
	var time
	
	if $StudyingBox/StudyTimeSelect.selected < 0:
		return
	
	# checks if the current savefile is studying 
	# immediately stops the timer when already studying
	if ManagerGame.player_data['is_studying']:
		set_physics_process(false)
		$StudyingBox/Study.text = 'Study'
		ManagerGame.player_data['is_studying'] = false
		ManagerGame.emit_signal("studying_activated", false)
		$Layer1.show()
		return
	
	if $StudyingBox/StudyTimeSelect.selected == 0:
		time = 5
	else:
		time = ($StudyingBox/StudyTimeSelect.selected + 1) * 5
	
	ManagerGame.player_data['is_studying'] = true
	ManagerGame.player_data['study_time_left'] = float(time * 60)
	# study_minute_chose will be used as a reward amount after studying
	# the amount of minutes will be the gain
	ManagerGame.player_data['study_minute_chose'] = int(time)
	
	
	ManagerGame.emit_signal("studying_activated", true)
	
	$Layer1.hide()
	set_physics_process(true)


func _on_StudyTimeSelect_item_selected(index):
	pass # Replace with function body.
