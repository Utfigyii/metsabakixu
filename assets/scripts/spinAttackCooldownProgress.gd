extends TextureProgress
signal canSpin()

func _process(delta):
	value = $Timer.time_left

func _on_Timer_timeout():
	emit_signal("canSpin")
