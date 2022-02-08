extends Node2D


export var spike_height = 40
export var min_holes = 3
export var max_holes = 7

var spike_scene = preload("res://scenes/Spike.tscn")


func spike_start_pos(facing_right: bool):
	# determine the wall the spikes should be placed on
	if facing_right:
		return $RSpikeStartPos

	return $LSpikeStartPos


func make_spike_positions(facing_right: bool):
	var viewport_height = get_viewport_rect().size.y
	var max_spike_count = floor(viewport_height / spike_height)
	var spike_positions = []

	# build the array of possible spike y coords
	for i in max_spike_count:
		spike_positions.append(
			i * spike_height + spike_start_pos(facing_right).position.y
		)

	# generate the number of removed coords
	var removed_count = randi() % (max_holes + 1)
	while removed_count < min_holes:
		removed_count = randi() % (max_holes + 1)

	# remove coords
	for _i in removed_count:
		spike_positions.remove(randi() % spike_positions.size())
	
	return spike_positions


func _ready():
	randomize()


func _on_Bird_game_over():
	get_tree().reload_current_scene()


func _on_Bird_wall_bumped(facing_right: bool):
	# delete previous spikes
	for spike in $Spikes.get_children():
		spike.queue_free()

	# place spikes
	for spike_y in make_spike_positions(facing_right):
		var spike = spike_scene.instance()
		spike.position.x = spike_start_pos(facing_right).position.x
		spike.position.y = spike_y
		
		if facing_right:
			spike.rotation = PI
		
		$Spikes.add_child(spike)
