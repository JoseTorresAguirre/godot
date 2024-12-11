extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Cambiar el texto
	text = SelectedCharacter.mes
	
	# Cambiar el color del texto
	add_theme_color_override("font_color", Color(SelectedCharacter.mes_color))
