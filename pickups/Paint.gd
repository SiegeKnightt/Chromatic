extends Area2D

const score_value = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called when plauer enters the paint
func _on_Paint_body_entered(body: Node) -> void:
	
	$AnimatedSprite.play("pickup")
	$AudioStreamPlayer2D.play()
	
	Events.emit_signal("score_changed", score_value)

# Ends the audio queue
func _on_AudioStreamPlayer2D_finished() -> void:
	
	queue_free()
