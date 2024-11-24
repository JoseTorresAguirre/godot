extends Node

const ANIMATION_DURATION = 4.0
@onready var dice_nodes = get_children()
@onready var result_label = $Label  # Cambia "$Label" por la ruta de tu nodo Label 
@export var selected_turnos_player1 : String = ""
var total_sum = 0
var timer: Timer

func _ready():
	for die in dice_nodes:
		if die is AnimatedSprite2D:
			die.play()

	await get_tree().create_timer(ANIMATION_DURATION).timeout
	stop_dice_animations()
	
	# Crear un Timer y configurarlo
	timer = Timer.new()
	add_child(timer)
	
	# Configurar el temporizador
	timer.wait_time = 2.0  # 5 segundos
	timer.one_shot = true   # Solo se activa una vez
	
	# Conectar la señal timeout del temporizador
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	
	# Iniciar el temporizador
	timer.start()


func stop_dice_animations():
	total_sum = 0

	for die in dice_nodes:
		if die is AnimatedSprite2D:
			die.stop()
			var random_value = randi() % 6 + 1
			die.frame = random_value - 1
			total_sum += random_value

	# Muestra el mensaje en el Label
	result_label.text = "¡Felicidades! Obtuviste " + str(total_sum) + " puntos"
	result_label.visible = true
	SelectedCharacter.selected_turnos_player1 = str(total_sum)
	
# Esta función se llama cuando el temporizador se acaba
func _on_Timer_timeout():
	# Cambiar a la siguiente escena
	
	get_tree().change_scene_to_file("res://scenes/lanzar_5.tscn")
