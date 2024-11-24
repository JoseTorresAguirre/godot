extends Node2D
@onready var audio_player = $AudioStreamPlayer2D  # Nodo AudioStreamPlayer en el nodo padre
@onready var buttons = get_children()  # Obtén todos los botones hijos

@export var dado1 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732113951/dados-crop5_hyqsvt.png"
@export var dado2 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732114025/dados-crop4_uhucym.png"
@export var dado3 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732114025/dados-crop1_bssgng.png" 
@export var dado4 : String = "https://res.cloudinary.com/dj3xwsle9/image/upload/v1732114024/dados-crop3_coysd6.png"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Conectar las señales de los botones
	for button in buttons:
		if button is Button:
			button.connect("mouse_entered", _on_button_hovered)
			# Conectar las señales de presionar el botón
			if button.name == "Button1":
				button.connect("pressed", _on_button_1_pressed)
			elif button.name == "Button2":
				button.connect("pressed", _on_button_2_pressed)
			elif button.name == "Button3":
				button.connect("pressed", _on_button_3_pressed)
			elif button.name == "Button4":
				button.connect("pressed", _on_button_4_pressed)
			
			


func _on_button_hovered():
	if audio_player:
		audio_player.play()  # Reproduce el sonido


func _on_button_1_pressed() -> void:
	SelectedCharacter.selected_dado = dado1
	get_tree().change_scene_to_file("res://scenes/vista_1_2.1.tscn")


func _on_button_2_pressed() -> void:
	SelectedCharacter.selected_dado = dado2
	get_tree().change_scene_to_file("res://scenes/vista_1_2.1.tscn")


func _on_button_3_pressed() -> void:
	SelectedCharacter.selected_dado = dado3
	get_tree().change_scene_to_file("res://scenes/vista_1_2.1.tscn")


func _on_button_4_pressed() -> void:
	SelectedCharacter.selected_dado = dado4
	get_tree().change_scene_to_file("res://scenes/vista_1_2.1.tscn")
