extends Node2D

class_name Character

@export var firstItem: global.DraggableType = global.DraggableType.NONE

@export var normal_voice: Resource = load("res://Assets/Audio/deep_voice_Robbing.wav")
@export var mask_voice: Resource = load("res://Assets/Audio/deep_voice_Robbing.wav")
@export var pain_voice: Resource = load("res://Assets/Audio/deep_voice_Robbing.wav")

func _on_button_pressed():
	if firstItem == global.DraggableType.NONE:
		%audioPlayer.stream = normal_voice	
	elif firstItem == global.DraggableType.MOUSE_MASK:
		%audioPlayer.stream = mask_voice
	%audioPlayer.play()
	
func _on_button_action_2_pressed():
	%audioPlayer.stream = pain_voice
	%audioPlayer.play()
