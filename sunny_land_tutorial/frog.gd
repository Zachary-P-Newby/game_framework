extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 50

func _physics_process(delta):
	#Frog gravity
	velocity.y += gravity * delta
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Jump")
			player = get_node("../../Player/Player")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
				velocity.x = direction.x * SPEED
			else:
				get_node("AnimatedSprite2D").flip_h = false
				velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
			velocity.x = 0
	move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	#kill frog
	if body.name == "Player":
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.PlayerHP -= 3
		death()

func death():
	Game.Gold += 5
	Utils.saveGame()
	#get_node("CollisionShape2D").disabled = true
	#get_node("PlayerDetection/CollisionShape2D").disabled = true
	#get_node("PlayerCollision/CollisionShape2D").disabled = true
	#get_node("PlayerDeath/CollisionShape2D").disabled = true
	get_node("AnimatedSprite2D").play("Death")
	self.velocity = Vector2(0,0)
	chase = false
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
