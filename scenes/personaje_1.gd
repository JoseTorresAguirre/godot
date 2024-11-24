extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_seleccion_1_mouse_entered() -> void:
	# Obtén el StyleBoxFlat del panel (clave "panel" en las Theme Overrides)
	var stylebox = get_theme_stylebox("panel")  # Cambia "panel" por la clave exacta de tu Theme Override
	if stylebox and stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(0.29, 0.82, 0.51)  # Cambia el color a tu preferencia


func _on_seleccion_1_mouse_exited() -> void:
	# Obtén el StyleBoxFlat del panel (clave "panel" en las Theme Overrides)
	var stylebox = get_theme_stylebox("panel")  # Cambia "panel" por la clave exacta de tu Theme Override
	if stylebox and stylebox is StyleBoxFlat:
		stylebox.bg_color = Color(1, 1, 1)  # Cambia el color a tu preferencia
