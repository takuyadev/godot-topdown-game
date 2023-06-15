extends CharacterBody2D

enum COW_STATE { IDLE, WALK }

@export var move_speed: float = 20
@export var idle_time: float = 4
@export var walk_time: float = 4

@onready var _animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var move_direction: Vector2 = Vector2.ZERO
var current_state: COW_STATE = COW_STATE.IDLE

func _ready():
	pick_new_state()

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)
	
	if (move_direction.x < 0):
		sprite.flip_h = true
		
	elif(move_direction.x > 0):
		sprite.flip_h = false
	
func _physics_process(delta):
	velocity = move_direction * move_speed 
	if (current_state == COW_STATE.WALK):
		move_and_slide()
		
	
func pick_new_state():
	if(current_state == COW_STATE.IDLE):
		select_new_direction()
		current_state = COW_STATE.WALK
		_animation_player.play("walk")
		timer.start(walk_time)
	elif(current_state == COW_STATE.WALK):
		current_state = COW_STATE.IDLE
		_animation_player.play("idle")
		timer.start(idle_time)
		


func _on_timer_timeout():
	pick_new_state()
