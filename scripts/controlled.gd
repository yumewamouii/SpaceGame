extends Node2D


var speed: float = 0
var max_speed: float = 500


@onready var sprite: Sprite2D = get_node("ShipArea/ShipSprite/ShieldSprite")
@onready var flame_sprite: Sprite2D = get_node("ShipArea/ShipSprite/FlameSprite")
@export var object_type: String = 'ship'


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		rotation -= 0.1
	if Input.is_action_pressed("ui_right"):
		rotation += 0.1
	if Input.is_action_pressed("ui_up"):
		speed += 5
		if speed > max_speed:
			speed = max_speed
	if Input.is_action_pressed("ui_down"):
		speed -= 5
		if speed < 0:
			speed = 0
	
	
	if speed == 0:
		flame_sprite.visible = false
	else:
		flame_sprite.visible = true
	
	
	if speed <= 150:
		flame_sprite.scale = Vector2(1, 1)
	elif speed <= 350:
		flame_sprite.scale = Vector2(1.25, 1.25)
	elif speed <= max_speed:
		flame_sprite.scale = Vector2(1.5, 1.5)
	
	
	var x = 0.1 * cos(rotation+PI/2)
	var y = 0.1 * sin(rotation + PI/2)
	position += speed * delta * Vector2(x,y).normalized()
	
	
func damage():
	sprite.visible = false
