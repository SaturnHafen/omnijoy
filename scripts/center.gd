extends RigidBody


func _on_body_entered(body):
	print("rip")
	print(get_tree().get_root().get_node("Game"))
	get_tree().get_root().get_node("Game").game_over()
