extends CharacterBody2D
#Reused code from the tutorial

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 100

func _physics_process(delta):
#Frog gravity
	velocity.y += gravity * delta
	if chase == true:
		get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../Player/Player")
		
		var direction = (player.position - self.position).normalized()
		print(direction.x)
		
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * SPEED
		else:
			get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	move_and_slide()



func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_hitbox_body_entered(body):
	if body.name == "Player":
		body.freeze()
		chase = false
		await get_tree().create_timer(0.5).timeout
