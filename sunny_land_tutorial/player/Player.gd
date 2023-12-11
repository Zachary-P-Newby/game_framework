extends CharacterBody2D

#var health = 10
#const SPEED =300.0
const SPEED = 20.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	
	if anim.current_animation != "Death":
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
	
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			anim.play("Jump")
	
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		
		if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction == 1:
			get_node("AnimatedSprite2D").flip_h = false

		if direction:
	#velocity.x = direction * SPEED
			velocity.x += direction * SPEED
			if velocity.x > 200.0:
				velocity.x = 200.0
			elif velocity.x < -200.0:
				velocity.x = -200.0
		
			if velocity.y ==0:
				anim.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y ==0:
				anim.play("Idle")
		if velocity.y >0:
			anim.play("Fall")
	
	#kill player
		if Game.PlayerHP <= 0:
			anim.play("Death")
			await anim.animation_finished
			self.queue_free()
			Game.PlayerHP = 10
			Utils.saveGame()
			get_tree().change_scene_to_file("res://main.tscn")
		else:
			move_and_slide()
