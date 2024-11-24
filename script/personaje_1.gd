extends Panel

# Llamado cuando el nodo entra en el árbol de escena
func _ready() -> void:
	pass  # Aquí puedes conectar las señales del botón si aún no lo están

func _on_button_1_focus_entered() -> void:
	# Accede al StyleBoxFlat del Panel desde el Theme Override
	var stylebox = get_theme_stylebox("panel")
	if stylebox and stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(0.29, 0.82, 0.51)  # Cambiar a verde claro

func _on_button_1_mouse_exited() -> void:
	# Restaura el color original del StyleBoxFlat
	var stylebox = get_theme_stylebox("panel")
	if stylebox and stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(1, 1, 1)  # Restablecer a blanco
