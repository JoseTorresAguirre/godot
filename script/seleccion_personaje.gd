extends Node2D

@onready var audio_player = $AudioStreamPlayer2D  # Nodo AudioStreamPlayer en el nodo padre
@onready var buttons = get_children()  # Obtén todos los botones hijos
# Lista de botones
@onready var botones = get_children()  # Asume que los botones son hijos de este nodo


func _on_seleccion_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/vista_1.tscn")

func _on_seleccion_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/vista_2.tscn")




func _ready():
	for button in buttons:
		if button is Button:
			button.connect("mouse_entered", _on_button_hovered)
			
	 # Asume que cada botón tiene una propiedad "personaje_imagen" exportad


func _on_button_hovered():
	if audio_player:
		audio_player.play()  # Reproduce el sonido
