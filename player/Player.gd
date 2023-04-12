extends KinematicBody2D

export var move_speed := 100
export var gravity := 2000
export var jump_speed := 550

var velocity := Vector2.ZERO
var has_double_jumped = false

func _physics_process(delta: float) -> void:
	
	# Resets horizontal velocity
	velocity.x = 0
	
	if is_on_floor():
		
		has_double_jumped = false
	
	# Sets horizonal velocity
	if Input.is_action_pressed("move_right"):
		
		velocity.x += move_speed
	if Input.is_action_pressed("move_left"):
		
		velocity.x -= move_speed
	# Jump happens on the next frame
	if Input.is_action_just_pressed("jump"):
		
		if is_on_floor():
			
			# Negative y = up
			velocity.y = -jump_speed
		elif !has_double_jumped:
			
			velocity.y = -jump_speed
			has_double_jumped = true
	# Apply gravity
	# Player always has downward velocity
	velocity.y += gravity * delta
	
	# Actually moves the player
	velocity = move_and_slide(velocity, Vector2.UP)

func _process(delta: float) -> void:
	
	change_animation()

# Flips animation left or right
# Plays jump sound effect and
# plays the sprite
func change_animation():
		
	if velocity.x > 0:
		
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		
		$AnimatedSprite.flip_h = true
	
	if velocity.y < 0:
		
		$jumpSound.play()
		$AnimatedSprite.play("jump")
	else:
		
		if velocity.x != 0:
			
			$AnimatedSprite.play("walk")
		else:
			
			$AnimatedSprite.play("idle")

# Respawns the player if they fall
# into the void
func _on_Area2D_body_entered(body: Node) -> void:
	
	$deathSound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().reload_current_scene()

# Respawns the player if they run
# into an obstacle
func _on_Obstacles_body_entered(body: Node) -> void:
	
	$deathSound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().reload_current_scene()
