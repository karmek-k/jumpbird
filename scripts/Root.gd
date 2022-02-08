extends Node2D


export var spike_height = 40
export var min_holes = 2
export var max_holes = 5

var spike_scene = preload("res://scenes/Spike.tscn")


func _ready():
	randomize()


func _on_Bird_game_over():
	get_tree().reload_current_scene()


func _on_Bird_wall_bumped(facing_right: bool):
	var viewport_height = get_viewport_rect().size.y
	var max_spike_count = floor(viewport_height / spike_height)
	var spike_positions = []

	# delete previous spikes
	for spike in $Spikes.get_children():
		spike.queue_free()

	# determine the wall the spikes should be placed on
	var spike_start_pos
	if facing_right:
		spike_start_pos = $RSpikeStartPos
	else:
		spike_start_pos = $LSpikeStartPos

	# build the array of possible spike y coords
	for i in max_spike_count:
		spike_positions.append(i * spike_height + spike_start_pos.position.y)

	# generate the number of removed coords
	var removed_count = randi() % (max_holes + 1)
	while removed_count < min_holes:
		removed_count = randi() % (max_holes + 1)

	# remove coords
	for _i in removed_count:
		spike_positions.remove(randi() % spike_positions.size())

	# place spikes
	for spike_y in spike_positions:
		var spike = spike_scene.instance()
		spike.position.x = spike_start_pos.position.x
		spike.position.y = spike_y
		
		if facing_right:
			spike.rotation = PI
		
		$Spikes.add_child(spike)
