extends RigidBody2D

const ACCELERATION = 10000
const ROTATIONAL_SPEED = 140

@export var cutscene = true

func vector_to_radians(vector):
	return Vector2.DOWN.angle_to(vector)
	
func radians_to_vector(radians):
	return Vector2(cos(radians), sin(radians))

func get_gravity_force(delta):
	const G: float = 1/(6.674*10**11)
	var gravity_vec = Vector2.ZERO
	for planet in get_node("/root/Node/Planets").get_children():
		var distance_squared = planet.position.distance_to(position)
		gravity_vec += (planet.position - position).normalized() * (G*planet.mass/distance_squared)
	return gravity_vec * delta * 4000
	
	
func _ready() -> void:
	get_node("AnimatedSprite2D").play("default")
	cutscene = true
	await get_tree().create_timer(5).timeout  #35
	cutscene = false


func _process(delta: float) -> void:
	var gravity_vec = get_gravity_force(delta)
	apply_force(gravity_vec)
	var camera_scale = min(max((gravity_vec.length()-20)/100, .4), 1.2)
	get_node("../Node2D/Camera2D").zoom = lerp(get_node("../Node2D/Camera2D").zoom, Vector2(camera_scale, camera_scale), 0.05)
	var camera_node = get_node("../Node2D")
	camera_node.rotation = vector_to_radians(gravity_vec.normalized())
	camera_node.position = lerp(camera_node.position, position, 0.05)

	if cutscene:
		pass #return
	apply_torque_impulse(Input.get_axis("a", "d") * ROTATIONAL_SPEED)
	
	var forward_thrust = Input.get_action_strength("w") * ACCELERATION * delta
	apply_force(radians_to_vector(rotation - PI/2) * forward_thrust)
	if forward_thrust:
		get_node("Rocket").stream_paused = false
		get_node("AnimatedSprite2D").visible = true
		get_node("Sprite2D").visible = false
	else:
		get_node("Rocket").stream_paused = true
		get_node("AnimatedSprite2D").visible = false
		get_node("Sprite2D").visible = true
	
	if Input.get_axis("a", "d"):
		get_node("RCS").stream_paused = false
	else:
		get_node("RCS").stream_paused = true
