extends Node2D

enum DIRS {
	L2R = 0,
	R2L = 1,
}

var target_color : Color
var direction

var SPEED
func reset():
	var vp = get_viewport().size
	direction = randi() % 2
	if direction == DIRS.L2R:
		position.x = 0
	else:
		position.x = vp.x
	position.y = randf_range(0, vp.y * 3 / 4)
	SPEED = Vector2(vp.x / 5, randf_range(0, vp.y / 5))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_color = Util.TYPE_COLOR[randi() % 3]
	reset()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CPUParticles2D.color = $CPUParticles2D.color.lerp(target_color, delta)
	if direction == DIRS.L2R:
		position += delta * SPEED
		if(position.x > get_viewport().size.x):
			reset()
	else:
		position -= delta * SPEED
		if(position.x <= 0):
			reset()
	pass


func _on_timer_timeout() -> void:
	target_color = Util.TYPE_COLOR[randi() % 3]
	$Timer.start(randf_range(1, 2))
	pass # Replace with function body.
