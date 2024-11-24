extends Node

const ANIMATION_DURATION = 4.0
@onready var dice_nodes = get_children()
@onready var result_label = $avanzar  # Cambia "$Label" por la ruta de tu nodo Label
@onready var start_button = $Panel/start  # Cambia "$Button" por la ruta de tu nodo botón
var total_sum = 0
var timer: Timer
@export var player1_avanzar : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Crear un Timer y configurarlo
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = ANIMATION_DURATION
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "stop_dice_animations"))

	# Conectar el botón para iniciar la animación
	start_button.pressed.connect(self._on_button_pressed)

func _on_button_pressed() -> void:
	# Inicia las animaciones de los dados
	 # Hacer que el botón no sea visible
	start_button.visible = false
	
	for die in dice_nodes:
		if die is AnimatedSprite2D:
			die.play()

	# Inicia el temporizador para detener las animaciones
	timer.start()
	result_label.visible = false  # Oculta el Label mientras se ejecuta la animación

func stop_dice_animations() -> void:
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
	

	# Almacena el resultado en la variable global
	SelectedCharacter.player1_avanzar= str(total_sum)
	print(SelectedCharacter.player1_avanzar)

	# Cambia a la siguiente escena después de unos segundos (opcional)
	#await get_tree().create_timer(2.0).timeout
	#get_tree().change_scene_to_file("res://scenes/lanzar_8.tscn")
