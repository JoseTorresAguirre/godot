extends Node2D
var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Crear un Timer y configurarlo
	timer = Timer.new()
	add_child(timer)
	
	# Configurar el temporizador
	timer.wait_time = 4.0  # 4 segundos
	timer.one_shot = true   # Solo se activa una vez
	
	# Conectar la señal timeout del temporizador
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	
	# Iniciar el temporizador
	timer.start()


# Esta función se llama cuando el temporizador se acaba
func _on_Timer_timeout():
	# Cambiar a la siguiente escena
	
	get_tree().change_scene_to_file("res://scenes/lanzar_2.tscn")
