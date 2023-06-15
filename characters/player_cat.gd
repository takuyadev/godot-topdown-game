extends CharacterBody2D

@export var move_speed: float = 100
@onready var _animation_player = $AnimationPlayer

var direction = "down"

func _process(_delta):
	if Input.is_action_pressed("right"):
		_animation_player.play("walk_right")
		direction = "right"
	elif Input.is_action_pressed("left"):
		_animation_player.play("walk_left")
		direction = "left"
	elif Input.is_action_pressed("down"):
		_animation_player.play("walk_down")
		direction = "down"
	elif Input.is_action_pressed("up"):
		_animation_player.play("walk_up")
		direction = "up"
	else: _animation_player.play("idle_" + direction)	
		
func _physics_process(delta):
	
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	# Update velocity
	velocity = input_direction * move_speed
	
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()
