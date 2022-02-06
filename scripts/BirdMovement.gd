extends KinematicBody2D

export var horizontal_speed = 3
export var jump_speed = 1
export var gravity = 10

var time_since_jump = 0
var jumping = false
var velocity

func _ready():
	velocity = Vector2(horizontal_speed, -jump_speed)

func _physics_process(delta):
	# prevent infinite jumping
	if Input.action_press("ui_up") and not jumping:
		velocity.y = -jump_speed
		time_since_jump = 0
	if Input.action_release("ui_up"):
		jumping = false
	
	velocity.y += gravity * delta

	move_and_collide(velocity)
