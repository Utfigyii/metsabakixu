extends Spatial

var enemyNode = preload("res://assets/scenes/enemy.tscn")


func _ready():
	var enemy = enemyNode.instance()
	get_parent().add_child(enemy)
	enemy.set_translation(translation)
	
func _on_Timer_timeout():
	var enemy = enemyNode.instance()
	enemy.set_translation(translation)
	get_parent().add_child(enemy)
	$Timer.start()
