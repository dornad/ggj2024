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
		alert("GREAT JOB!")
	else:
		alert("THAT IS NOT IT... try again")

func alert(text: String, title: String = ""):
	var dialog = AcceptDialog.new()
	dialog.dialog_text = text
	dialog.title = title
	#dialog.connect('modal_closed', dialog, 'queue_free')
	
	add_child(dialog)
	
	dialog.popup_centered()
	
	
	
