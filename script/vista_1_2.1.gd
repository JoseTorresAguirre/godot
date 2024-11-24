extends Node2D

@onready var audio_player = $AudioStreamPlayer2D  # Nodo AudioStreamPlayer en el nodo padre
@onready var buttons = get_children()  # Obtén todos los botones hijos
@onready var start_button = $iniciar  # Referencia al botón "Iniciar"



func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lanzar.tscn")


func _ready():
	# Verifica el estado de las variables globales cuando la escena se inicia
	_update_button_state()
	
	for button in buttons:
		if button is Button:
			button.connect("mouse_entered", _on_button_hovered)
			
# Función para actualizar el estado del botón
func _update_button_state() -> void:
	# Verifica si cualquiera de las variables selected_ficha o selected_dado está vacía
	if SelectedCharacter.selected_ficha == "" or SelectedCharacter.selected_dado == "":
		start_button.disabled = true  # Desactiva el botón
		_set_button_red()  # Cambia el color de fondo a rojo
	else:
		start_button.disabled = false  # Activa el botón
		_restore_button_style()  # Restaura el estilo original

# Cambiar el fondo del botón a rojo cuando está deshabilitado
func _set_button_red() -> void:
	var stylebox = start_button.get_theme_stylebox("disabled")  # Obtener el StyleBox normal del botón
	var font_color = Color(0, 0, 1)  # Color azul
	
	if stylebox and stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(1, 0, 0)  # Color rojo
	start_button.add_theme_stylebox_override("disabled", stylebox)  # Aplicar el StyleBox modificado
	start_button.add_theme_color_override("font_color_disabled", font_color)  # Cambiar el color del texto cuando está 

# Restaurar el estilo original del botón
func _restore_button_style() -> void:
	start_button.remove_theme_stylebox_override("disabled")  # Elimina la sobrecarga del StyleBox normal deshabilitado
	
func _on_button_hovered():
	if audio_player:
		audio_player.play()  # Reproduce el sonido


func _on_sele_ficha_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/seleccionar_ficha.tscn")


func _on_sele_dado_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/seleccionar_dado.tscn")
