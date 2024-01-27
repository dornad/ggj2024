extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create an Image object
	var img = Image.new()
	
	# Create an Image of desired size (e.g., 64x64 pixels)
	img.create(64, 64, false, Image.FORMAT_RGBA8)
	
	# Lock the image for drawing

	
	# Draw a simple rectangle shape
	for x in range(64):
		for y in range(64):
			img.set_pixel(x, y, Color(1, 0, 0, 1))  # Red color
	
	# Unlock the image after drawing
	img.unlock()
	
	# Create an ImageTexture
	var img_texture = ImageTexture.new()
	
	# Load the Image into the ImageTexture
	img_texture.create_from_image(img)
	
	# Assign the ImageTexture to the Sprite
	self.texture = img_texture
