extends Node2D

@onready var sprite = $Sprite2D  # Referencia al Sprite2D
@onready var http_request = $HTTPRequest  # Referencia al HTTPRequest (si ya lo tienes como nodo hijo)

@export var imagen_url : String = ""  # URL de la imagen

func _ready():
	# Realizar la solicitud HTTP solo si la URL está configurada
	if imagen_url != "https://res.cloudinary.com/dj3xwsle9/image/upload/v1731085008/nurse_obvkei.png":
		http_request.request(imagen_url)  # Realiza la solicitud HTTP para obtener la imagen

# Manejar la respuesta HTTP
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:  # Verificar si la respuesta es exitosa
		var image = Image.new()  # Crear una nueva imagen
		var err = image.load_png_from_buffer(body)  # Cargar la imagen desde el buffer

		if err == OK:
			var texture = ImageTexture.new()  # Crear una textura nueva
			texture.create_from_image(image)  # Crear la textura a partir de la imagen descargada
			sprite.texture = texture  # Asignar la textura al sprite

			# Ajustar el tamaño y la escala si es necesario
			sprite.scale = Vector2(1, 1)  # Ajusta la escala aquí si es necesario
			print("Imagen asignada correctamente.")
		else:
			print("Error al cargar la imagen desde el buffer.")
	else:
		print("Error al descargar la imagen. Código de respuesta:", response_code)
