extends RigidBody


func _on_body_entered(body: Node):
	if body.is_in_group("Target"):
		print("Incredible!")
		body.get_node("AudioStreamPlayer3D").stop()
		get_tree().get_root().get_node("Game").game_won()
		
		$omnidroidHappy.play()
		return
	
	if not get_parent().rolling:
		print("rip")
		get_tree().get_root().get_node("Game").game_over()
