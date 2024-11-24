extends Panel

# Llamado cuando el nodo entra en el árbol de escena
func _ready() -> void:
	# Puedes conectar las señales aquí si no están conectadas en el editor
	pass

func _on_button_1_mouse_entered() -> void:
	# Accede al estilo del panel y cambia el color del fondo
	var stylebox = get_theme_stylebox("panel")  # Obtenemos el estilo "panel"
	if stylebox and stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(0.29, 0.82, 0.51)  # Cambiar el color a verde claro

func _on_button_1_mouse_exited() -> void:
	# Restablece el color de fondo cuando el mouse sale
	var stylebox = self.get_theme_stylebox("panel")  # Obtenemos el estilo "panel"
	if stylebox and stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(1, 1, 1)  # Restablecer el color a blanco
