extends CharacterBody2D

@export var speed: int = 400
@export var GRAVITY: int = 1200
@export var jump_speed: int = -600

const UP = Vector2(0,-1)

const idle_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_idle.png"
const crouch_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_duck.png"
const walk_right_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_walk1.png"
const dash_right_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_slide.png"
const jump: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_jump.png"

var jump_count: int = 0
const max_jump = 2

var can_dash: bool = false

func _ready():
	pass

func get_input():
	velocity.x = 0
	
	if is_on_floor():
		jump_count = 0
	
	if jump_count == 1 and Input.is_action_just_pressed("up"):
		velocity.y = jump_speed
		$Sprite2D.texture = load(jump)
		jump_count = 0
	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y = jump_speed
		$Sprite2D.texture = load(jump)
		jump_count += 1
	if Input.is_action_just_released("up"):
		$Sprite2D.texture = load(idle_texture)
	
	if Input.is_action_pressed('right'):
		$Sprite2D.texture = load(walk_right_texture)
		velocity.x += speed
	if Input.is_action_just_released("right"):
		$Sprite2D.texture = load(idle_texture)

	if Input.is_action_pressed('left'):
		velocity.x -= speed

	
	# Dash
	if Input.is_action_pressed('dash') and velocity.x > 0:
		$Sprite2D.texture = load(dash_right_texture)
		velocity.x += 400
	if Input.is_action_pressed('dash') and velocity.x < 0:
		velocity.x -= 400
	if Input.is_action_just_released("dash"):
		$Sprite2D.texture = load(idle_texture)
	
	# Crouch
	if Input.is_action_pressed('down'):
		velocity.y = 500
		$Sprite2D.texture = load(crouch_texture)
	if Input.is_action_just_released("down"):
		$Sprite2D.texture = load(idle_texture)

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	set_velocity(velocity)
	set_up_direction(UP)
	move_and_slide()
	velocity = velocity


