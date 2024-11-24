extends Node2D

@onready var audio_player = $AudioStreamPlayer2D  # Nodo AudioStreamPlayer en el nodo padre
@onready var buttons = get_children()  # Obtén todos los botones hijos


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/vista_1_2.1.tscn")


func _ready():
	for button in buttons:
		if button is Button:
			button.connect("mouse_entered", _on_button_hovered)

func _on_button_hovered():
	if audio_player:
		audio_player.play()  # Reproduce el sonido
