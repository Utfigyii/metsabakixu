extends KinematicBody

var MAX_SPEED = 15
var ACCELERATION = 100
var speedMultiplier = 1
var motion = Vector3()
var canAttack = true
var baseDamage = 4

func _physics_process(delta):
	var axis = getDirection()
	if axis == Vector3.ZERO:
		applyFriction(ACCELERATION * delta)
	else:
		applyMovement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)
	if Input.is_action_just_pressed("attack") && canAttack:
		attack()
	if Input.is_action_just_pressed("1spell"):
		spinAttack()
	if Input.is_action_just_pressed("2spell"):
		speedBoost()
	translation.y = 1


func applyFriction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector3.ZERO
		
	
func applyMovement(acceleration):
	motion += acceleration
	if motion.length() > MAX_SPEED * speedMultiplier:
		motion = motion.normalized() * MAX_SPEED * speedMultiplier
	

func getDirection():
	var inputDirection = Vector3.ZERO
	if(Input.is_action_pressed("up")):
		inputDirection.z = -1
	if(Input.is_action_pressed("down")):
		inputDirection.z = 1
	if(Input.is_action_pressed("left")):
		inputDirection.x = -1
	if(Input.is_action_pressed("right")):
		inputDirection.x = 1
	return inputDirection.normalized()
	
func attack():
	$AnimationPlayer.play("knightAttack")
	
func spinAttack():
	if $HUD/spinAttackButton/spinAttackCooldownProgress/Timer.time_left < 0.1:
		canAttack = false
		$HUD/spinAttackButton/spinAttackCooldownProgress/Timer.start(15)
		$AnimationPlayer.play("knightSpinPower")


func _on_AnimationPlayer_animation_finished(anim_name):
	canAttack = true


func _on_spinAttackButton_button_down():
	print("clik")
	spinAttack()



func _on_speedBoostButton_button_down():
	speedBoost()
	
func speedBoost():
	if $HUD/speedBoostButton/TextureProgress/Timer.time_left < 0.1:
		speedMultiplier = 1.3
		$HUD/speedBoostButton/TextureProgress/speedBoostTime.start(3)
		$HUD/speedBoostButton/TextureProgress.fill_mode = 2
		$HUD/speedBoostButton/TextureProgress.max_value = 3
		$HUD/speedBoostButton/TextureProgress/Timer.start(3)

func _on_speedBoostTime_timeout():
	speedMultiplier = 1
	$HUD/speedBoostButton/TextureProgress/Timer.start(7)
	$HUD/speedBoostButton/TextureProgress.fill_mode = 3
	$HUD/speedBoostButton/TextureProgress.max_value = 7


func _on_playerAttack_area_entered(area):
	print(area)
	if "enemy" in area.get_parent().name:
		area.get_parent().takeDamage(baseDamage)


func _on_spinAttack_area_entered(area):
	print(area)
	if "enemy" in area.get_parent().name:
		area.get_parent().takeDamage(baseDamage)
		
func takeDamage(damage):
	print("damaged")
