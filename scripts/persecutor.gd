extends Node2D


const MAX_FORCE: float = 500
const MAX_SPEED: float = 300
const MAX_DISTANCE: float = 200


var acceleration: Vector2 = Vector2(0,0)
var velocity: Vector2 = Vector2(0,0)


@onready var window = get_parent().get_window()


func apply_force(force: Vector2) -> void:
	acceleration = force
	
	
func seek(target: Vector2) -> void:
	var direction = target - global_position
	var distance = direction.length()
	if distance < 50:
		return
	
	
	var required_velocity = direction.normalized() * MAX_SPEED
	var m = remap(distance, 0, MAX_DISTANCE, 0, 1)
	var steering = (required_velocity - velocity) * m
	steering = steering.limit_length(MAX_FORCE)
	apply_force(steering)
	
	
func flee(target: Vector2) -> void:
	var direction = global_position - target
	var distance = direction.length()
	if distance > MAX_DISTANCE:
		return
	
	
	var required_velocity = direction.normalized() * MAX_SPEED
	var steering = required_velocity - velocity
	apply_force(steering)
	
	
func update(delta: float) -> void:
	velocity += acceleration * delta
	velocity = velocity.limit_length(MAX_DISTANCE)
	global_position  += velocity * delta
	acceleration *= 0
	rotation = velocity.angle() - PI / 2
	
func _process(delta: float) -> void:
	update(delta)
	if global_position.x > window.size.x:
		global_position.x = 0
	elif global_position.y > window.size.y:
		global_position.y = 0
	elif global_position.x < 0:
		global_position.x = window.size.x
	elif global_position.y < 0:
		global_position.y = window.size.y
		
