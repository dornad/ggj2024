extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

# What kind of draggable this is.
@export var draggableType: global.DraggableType = global.DraggableType.MOUSE_MASK

func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed('click'):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		if Input.is_action_pressed('click'):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released('click'):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				handleDrop(body_ref)
				tween.tween_property(self, "position", body_ref.global_position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func handleDrop(body: StaticBody2D):
	# start by protecting our invariant regarding who has elements
	draggable_cleanup()
	
	# Either we're dropping in a character or the inventory
	var character = body.get_parent() as Character
	if character is Character:
		# add the element
		handleDrop_character(body, character)

func handleDrop_character(body: StaticBody2D, character: Character):
	if character.firstItem == global.DraggableType.NONE:
		character.firstItem = draggableType
	print(character, ", firstItem = ", global.DraggableType.keys()[character.firstItem])
	
func draggable_cleanup():
	print("CLEANUP START")
	var world = find_parent("World")
	var characters = world.find_children("Character*", "Character")
	for character in characters:
		if character.firstItem == draggableType:
			character.firstItem = global.DraggableType.NONE
		print(character, ", firstItem = ", global.DraggableType.keys()[character.firstItem])
	print("CLEANUP END")

func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)

func _on_area_2d_body_entered(body: StaticBody2D):
	if body.is_in_group('droppable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group('droppable'):
		is_inside_dropable = false
		body.modulate = Color(Color.REBECCA_PURPLE, 0.7)
