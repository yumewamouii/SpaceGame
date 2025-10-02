extends Node2D


var speed: float = 0
var max_speed: float = 500


@onready var sprite: Sprite2D = get_node("ShipArea/ShipSprite/ShieldSprite")
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
	
	
	var x = 0.1 * cos(rotation+PI/2)
	var y = 0.1 * sin(rotation + PI/2)
	position += speed * delta * Vector2(x,y).normalized()
	
	
# FIXME: Fix a bug where if an enemy hits an asteroid, the player's shield breaks. 
func damage():
	sprite.visible = false
