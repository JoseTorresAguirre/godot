extends Sprite2D

# Referencia al nodo HTTPRequest
@onready var http_request = $HTTPRequest

# URL de la imagen que deseas cargar
var image_url: String = ""

func _ready() -> void:
	# Conectar la señal `request_completed` del nodo HTTPRequest
	http_request.request_completed.connect(self._on_http_request_request_completed)
	
	# Configura aquí la URL que quieres cargar (puedes cambiarla dinámicamente)
	image_url = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732106777/ficha_zorro_ize9ec.png"
	
	# Realiza la solicitud HTTP
	if image_url != "":
		_request_image(image_url)
	else:
		push_error("No image URL provided.")

# Función para realizar la solicitud HTTP
func _request_image(url: String) -> void:
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred while making the HTTP request: %s" % error)

# Función que maneja la respuesta del HTTPRequest
func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		push_error("Failed to download image. Result: %s, Response Code: %s" % [result, response_code])
		return

	# Cargar la imagen desde el cuerpo de la respuesta
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Failed to load the image from the downloaded data.")
		return

	# Crear una textura desde la imagen cargada
	var texture = ImageTexture.create_from_image(image)
	
	# Asignar la textura al sprite actual
	self.texture = texture


func _on_button_1_mouse_entered() -> void:
	pass # Replace with function body.
