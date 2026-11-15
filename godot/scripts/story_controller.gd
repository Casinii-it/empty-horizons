extends Node

func change_thoughts(string, duration:float = 0, size=100):
	if duration <= 0:
		var format_string = "[font_size=%s] %s"
		get_node("../Node2D/Camera2D/Node2D/Thoughts").text = format_string % [size, string]
	else:
		var time_per_char = duration/len(string)
		var new_string = "[font_size=%s] " % size
		for i in string:
			await get_tree().create_timer(time_per_char).timeout
			new_string += str(i)
			get_node("../Node2D/Camera2D/Node2D/Thoughts").text = new_string

func clear_thoughts():
	get_node("../Node2D/Camera2D/Node2D/Thoughts").text = ""


func _ready() -> void:
	clear_thoughts()
	get_node("../RigidBody2D").cutscene = true
	
	await get_tree().create_timer(1).timeout
	get_node("../RigidBody2D").cutscene = false
	
	change_thoughts("....", 4)
	await get_tree().create_timer(6).timeout
	
	change_thoughts("Where...  am I?", 1)
	await get_tree().create_timer(3).timeout
	
	change_thoughts("I need to get back...", 1)
	await get_tree().create_timer(4).timeout
	
	clear_thoughts()
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
