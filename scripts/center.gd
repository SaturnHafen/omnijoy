extends RigidBody


func _on_body_entered(body: Node):
	if body.is_in_group("Target"):
		print("Incredible!")
	else:
		print("rip")
		get_tree().get_root().get_node("Game").game_over()
