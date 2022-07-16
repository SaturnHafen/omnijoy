extends RigidBody


func _on_body_entered(body):
	print("rip")
	get_tree().change_scene("res://scenes/omnidroid.tscn")
