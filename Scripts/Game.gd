extends Node2D

func _on_button_pressed():
	var world = find_parent("World")
	var characters = world.find_children("Character*", "Character")
	var isSuccess = false
	for character in characters:
		var currentGuess = character.is_guessing_guilty
		var isGuilty = character.is_guilty
		if currentGuess == true && currentGuess == isGuilty:
			isSuccess = true
	
	if isSuccess:
		OS.alert("GREAT JOB!")
	else:
		OS.alert("THAT IS NOT IT... try again")
