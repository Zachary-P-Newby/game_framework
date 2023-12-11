extends CharacterBody2D

var cherries = 0
const SPEED = 20
const JUMP_VELOCITY = -300.0
var frozen = false

@onready var animation = get_node("AnimatedSprite2D")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if not frozen:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			animation.play("Jump")
			velocity.y += JUMP_VELOCITY
		var direction = Input.get_axis("ui_left","ui_right")
	
		if direction == -1:
			animation.flip_h = true
		elif direction == 1:
			animation.flip_h = false
		
		if direction:
			velocity.x += direction * SPEED
		
			if velocity.x > 250.0:
				velocity.x = 250.0
			elif velocity.x < -250.0:
				velocity.x = -250.0
			
			if velocity.y ==0:
				animation.play("Run")
			
			if velocity.y >0:
				#velocity.y += (SPEED/2)
				animation.play("Fall")
		
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				animation.play("Idle")
		
		if velocity.y > 0:
			animation.play("Fall")
		
		move_and_slide()

func freeze():
	frozen = true
	animation.play("Hurt")
	await get_tree().create_timer(1.5).timeout
	frozen = false
