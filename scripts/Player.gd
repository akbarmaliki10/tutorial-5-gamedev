extends CharacterBody2D

@export var speed: int = 200
@export var GRAVITY: int = 1200
@export var jump_speed: int = -300

const UP = Vector2(0,-1)

const idle_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_idle.png"
const crouch_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_duck.png"
const walk_right_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_walk1.png"
const dash_right_texture: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_slide.png"
const jump: String = "res://assets/kenney_platformercharacters/PNG/Zombie/Poses/zombie_jump.png"

var jump_count: int = 0
const max_jump = 2

var can_dash: bool = false
@onready var animated = $AnimatedSprite2D

func _ready():
	animated.play("idle")
	pass

func get_input():
	velocity.x = 0
	
	if is_on_floor():
		jump_count = 0
	
	if jump_count == 1 and Input.is_action_just_pressed("up"):
		velocity.y = jump_speed
		animated.play("jump")
		jump_count = 0
	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y = jump_speed
		animated.play("jump")
		jump_count += 1
	if Input.is_action_just_released("up"):
		animated.play("idle")
	
	if Input.is_action_pressed('right'):
		animated.flip_h = false
		animated.play("walk")
		velocity.x += speed
	if Input.is_action_just_released("right"):
		animated.play("idle")

	if Input.is_action_pressed('left'):
		animated.flip_h = true
		animated.play("walk")
		velocity.x -= speed
	if Input.is_action_just_released("left"):
		animated.play("idle")
	
	# Dash
	if Input.is_action_pressed('dash') and velocity.x > 0:
		animated.flip_h = false
		animated.play("run")
		velocity.x += 400
	if Input.is_action_pressed('dash') and velocity.x < 0:
		animated.flip_h = true
		animated.play("run")
		velocity.x -= 400
	if Input.is_action_just_released("dash"):
		animated.play("idle")
	
	# Crouch
	if Input.is_action_pressed('down'):
		velocity.y = 500
		animated.play("hurt")
	if Input.is_action_just_released("down"):
		animated.play("idle")

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	set_velocity(velocity)
	set_up_direction(UP)
	move_and_slide()
	velocity = velocity


