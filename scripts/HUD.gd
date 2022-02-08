extends Control


var counter = 0


func set_score(score: int):
	$Score.text = str(score)


func _ready():
	set_score(0)


func _process(delta):
	set_score(counter)


func _on_Bird_wall_bumped(_facing_right):
	counter += 1
