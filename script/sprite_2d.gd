extends Sprite2D

@onready var http_request = HTTPRequest.new()

func _ready():
	# Conectar la señal de solicitud HTTP completada
	http_request.request_completed.connect(self._on_http_request_request_completed)
	add_child(http_request)  # Añadir el HTTPRequest como hijo para manejar la señal
	# Realizar la solicitud HTTP para la URL seleccionada
	_request_image(SelectedCharacter.selected_image_path)
	
# Función para realizar la solicitud HTTP
func _request_image(url: String) -> void:
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		return

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded. Try a different image.")
		return

	# Cargar la imagen desde el cuerpo de la respuesta
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")
		return

	# Crear una textura a partir de la imagen cargada
	var texture = ImageTexture.create_from_image(image)

	# Asignar la textura al sprite
	self.texture = texture