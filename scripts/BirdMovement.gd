extends KinematicBody2D

export var horizontal_speed = 5
export var jump_speed = 7
export var gravity = 20
export var facing_right = true

var time_since_jump = 0
var jumping = false
var velocity

func handle_collision(collision: KinematicCollision2D):
	facing_right = collision.collider.get("left_wall")
	$Sprite.flip_h = not facing_right

func _ready():
	velocity = Vector2(horizontal_speed, -jump_speed)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -jump_speed
		time_since_jump = 0
	
	velocity.x = horizontal_speed if facing_right else -horizontal_speed
	velocity.y += gravity * delta

	var collision = move_and_collide(velocity)
	if collision:
		handle_collision(collision)
