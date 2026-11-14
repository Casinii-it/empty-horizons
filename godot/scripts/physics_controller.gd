extends Node

class Body:
	var name: String
	var is_static: bool
	var is_massive: bool
	var coords: Vector2i
	var velocity: Vector2
	var mass: float
	var radius: float
	var colour: Color

func new_body(name, is_static, is_massive, coords, velocity, mass, radius, colour):
	var body = Body.new()
	body.name = name
	body.is_static = is_static
	body.is_massive = is_massive
	body.coords = coords
	body.velocity = velocity
	body.mass = mass
	body.radius = radius
	body.colour = colour


func two_body_gravity(body1, body2):
	var distance_squared = body1.coords.distance_to(body2.coords)
	const G = 6.674*10**-11
	return [G*body2.mass/distance_squared, G*body1.mass/distance_squared]

func _ready() -> void:
	#var bodies = [
		#new_body("Sun", true, true, Vector2i.ZERO, Vector2.ZERO, .989*10**30, 695508000, Color.YELLOW),
		#new_body("Mercury", false, true, Vector2i(57909227000, 0), Vector2(0, 47361), 3.301*10**23, 2439700, Color.WEB_GRAY),
		#new_body("Venus", false, true, Vector2i(108209475000, 0), Vector2(0, 35020), 4.867*10**24, 6051800, Color.SANDY_BROWN),
		#[
			#new_body("Earth", false, true, Vector2i(149598262000, 0), Vector2(0, 29782), 5.972*10**24, 6371000, Color.WEB_GREEN),
			#new_body("Moon", false, true, Vector2i(149837262000, 0), Vector2(0, 30804), 7.348*10**22, 1737500, Color.GRAY),
		#],
		#new_body("Mars", false, true, Vector2i(227943824000, 0), Vector2(0, 24076), 7.416*10**23, 3389500, Color.DARK_RED)
	#]
	pass


func _process(delta: float) -> void:
	pass
