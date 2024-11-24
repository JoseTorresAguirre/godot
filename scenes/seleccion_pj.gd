extends Node2D

@onready var audio_player = $AudioStreamPlayer2D  # Nodo AudioStreamPlayer en el nodo padre
@onready var http_request = $HTTPRequestNode
# Referencias a los 4 sprites donde se mostrarán las imágenes
@onready var sprite1 = $personaje1/Pj1 
@onready var sprite2 = $personaje2/Pj2
@onready var sprite3 = $personaje3/Pj3
@onready var sprite4 = $personaje4/Pj4

@onready var buttons = get_children()  # Obtén todos los botones hijos

@export var personaje_imagen_1 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732065692/pj1_hcmw7w.png"
@export var personaje_imagen_2 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732065692/pj2_y8sxet.png"
@export var personaje_imagen_3 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732065692/pj3_rgz6rq.png" 
@export var personaje_imagen_4 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732065692/pj4_bp6kpd.png"

var image_urls = []  # Aquí se guardarán las URLs de las imágenes
var current_request_index = 0  # Índice de la solicitud actual

func _ready():
	# Elimina cualquier textura previamente asignada al sprite (vacío)
	sprite1.texture = null
	sprite2.texture = null
	sprite3.texture = null
	sprite4.texture = null
	
	# Añadir las URLs a la lista
	image_urls = [
		personaje_imagen_1,  # URL 1
		personaje_imagen_2,  # URL 2
		personaje_imagen_3,  # URL 3
		personaje_imagen_4   # URL 4
	]
	
	# Crea el nodo HTTPRequest y conéctalo a la señal de 'request_completed'
	var http_request = HTTPRequest.new()
	add_child(http_request)
	# Conectar la señal de la solicitud completada
	http_request.request_completed.connect(self._on_http_request_node_request_completed)
	
	# Realiza la solicitud HTTP para la primera imagen
	_make_http_request()

	# Conectar el evento de presionar el botón
	for button in buttons:
		if button is Button:
			button.connect("mouse_entered", _on_button_hovered)
			
			# Conecta la señal "pressed" de cada botón a la función _on_button_pressed
			if button.name == "seleccion_1":
				button.connect("pressed", _on_seleccion_1_pressed)
			elif button.name == "seleccion_2":
				button.connect("pressed", _on_seleccion_2_pressed)
			elif button.name == "seleccion_3":
				button.connect("pressed", _on_seleccion_3_pressed)
			elif button.name == "seleccion_4":
				button.connect("pressed", _on_seleccion_4_pressed)

# Función para hacer una solicitud HTTP a la siguiente imagen
func _make_http_request():
	if current_request_index < image_urls.size():
		var url = image_urls[current_request_index]
		var error = http_request.request(url)
		if error != OK:
			push_error("An error occurred in the HTTP request.")
		else:
			current_request_index += 1
	else:
		push_error("No more images to load.")

# Maneja la respuesta de HTTPRequest
func _on_http_request_node_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
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
	
	# Asignar la textura al sprite correspondiente
	if sprite1.texture == null:
		sprite1.texture = texture
	elif sprite2.texture == null:
		sprite2.texture = texture
	elif sprite3.texture == null:
		sprite3.texture = texture
	elif sprite4.texture == null:
		sprite4.texture = texture

	# Realizar la siguiente solicitud HTTP
	_make_http_request()

func _on_button_hovered():
	if audio_player:
		audio_player.play()  # Reproduce el sonido

func _on_seleccion_1_pressed() -> void:
	SelectedCharacter.selected_image_path = personaje_imagen_1
	get_tree().change_scene_to_file("res://scenes/vista_1.tscn")
	

func _on_seleccion_2_pressed() -> void:
	SelectedCharacter.selected_image_path = personaje_imagen_2
	get_tree().change_scene_to_file("res://scenes/vista_1.tscn")
	

func _on_seleccion_3_pressed() -> void:
	SelectedCharacter.selected_image_path = personaje_imagen_3
	get_tree().change_scene_to_file("res://scenes/vista_1.tscn")
	

func _on_seleccion_4_pressed() -> void:
	SelectedCharacter.selected_image_path = personaje_imagen_4
	get_tree().change_scene_to_file("res://scenes/vista_1.tscn")
	
