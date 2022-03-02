extends KinematicBody

var path = []
var path_node = 0

var speed = 10
var health = 10

onready var nav = get_parent()
onready var player = $"../../Player"


func _physics_process(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
			attack()
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)
	if health < 1:
		queue_free()
	$AnimationPlayer.play("enemyWalk")
			
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout():
	move_to(player.global_transform.origin)


func _on_Area_area_entered(area):
	pass

func attack():
	pass

func takeDamage(damage):
	health = health - damage
