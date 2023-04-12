extends Control

onready var label = $MarginContainer/VBoxContainer/HBoxContainer/ScoreLabel

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	label.text = str("Score: ") + str(score)

# Function for when the event tree is entered
func _enter_tree() -> void:
	
	Events.connect("score_changed", self, "_on_score_changed")

# Function when event tree is exited
func _exit_tree() -> void:
	
	Events.disconnect("score_changed", self, "_on_score_changed")

# Function to change the score value
func _on_score_changed(value):
	
	score += value
	label.text = str("Score: ") + str(score)
