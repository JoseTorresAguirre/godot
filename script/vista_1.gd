extends Node2D

@onready var audio_player = $AudioStreamPlayer2D  # Nodo AudioStreamPlayer en el nodo padre
@onready var buttons = get_children()  # Obtén todos los botones hijos

# Función que maneja el cambio de escena al presionar cualquier botón
func _on_button_pressed() -> void:
	# Cambia a la escena vista_1 cuando cualquier botón es presionado
	get_tree().change_scene_to_file("res://scenes/vista_1_1.tscn")


func _ready():
	for button in buttons:
		if button is Button:
			button.connect("mouse_entered", _on_button_hovered)
			
			 # Conecta la señal "pressed" de cada botón a la función _on_button_pressed
			button.connect("pressed", _on_button_pressed)

func _on_button_hovered():
	if audio_player:
		audio_player.play()  # Reproduce el sonido
