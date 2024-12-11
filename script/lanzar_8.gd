extends Node2D

@onready var tablero = $tablero_1  # Nodo principal del tablero
@onready var enero_panel = $"tablero_1/Enero/panel-inicio"  # Contenedor del panel de inicio
@onready var ficha = $"tablero_1/Enero/panel-inicio/Personaje1Conejo"  # Ruta completa a la ficha
@onready var mes = $tablero_1/Enero/mes # label mes
@onready var borde = $tablero_1/Enero # label bordes

var casillas = []  # Lista de Marker2D

# Inicializa las referencias de las casillas y configura la posición inicial
func _ready():
	# Comprobamos que la ruta del nodo sea correcta
	if not enero_panel:
		print("Error: No se encontró el panel de inicio.")
		return

	if not ficha:
		print("Error: No se encontró la ficha.")
		return

	# Verificar que la ficha sea un Sprite2D
	#if ficha is Sprite2D:
	#	print("Ficha encontrada:", ficha)
	#else:
	#	print("La ficha no es un Sprite2D válido.")

	# Inicializamos la lista de casillas
	casillas = []
	for i in range(0, 29):  # Asegúrate de que el rango coincida con el número de casillas
		var casilla_name = "dia" + str(i)
		var casilla = enero_panel.get_node_or_null(casilla_name)
		if casilla:
			# Buscar el nodo '1', '2', '3', etc., dentro de cada 'diaX'
			var marker = casilla.get_node_or_null(str(i))  # El nombre del nodo es '1', '2', '3', etc.
			if marker:
				casillas.append(marker)  # Agregamos el nodo Marker2D a la lista
			else:
				print("Advertencia: No se encontró el Marker2D para la casilla", casilla_name)
		else:
			print("Advertencia: Casilla no encontrada:", casilla_name)

	#print("Casillas cargadas:", casillas)

	# Verificar las posiciones de los Marker2D
	#for i in range(casillas.size()):
	#	print("Posición del Marker2D", i+1, ":", casillas[i].global_position)

	# Simulación de tirar un dado (valor entre 1 y 12)
	var dado = int(SelectedCharacter.player1_avanzar)  # Convertimos el valor de dado a entero (asegúrate de que sea numérico)
	
	# Lista de meses y colores correspondientes
	var meses = [
		{"mes": "Enero", "color": "ffffff"},   # Enero
		{"mes": "Febrero", "color": "c40000"},  # Febrero
		{"mes": "Marzo", "color": "ff6347"},    # Marzo
		{"mes": "Abril", "color": "4682b4"},    # Abril
		{"mes": "Mayo", "color": "32cd32"},     # Mayo
		{"mes": "Junio", "color": "ffcc00"},    # Junio
		{"mes": "Julio", "color": "ff4500"},    # Julio
		{"mes": "Agosto", "color": "ff1493"},   # Agosto
		{"mes": "Septiembre", "color": "20b2aa"},# Septiembre
		{"mes": "Octubre", "color": "8b0000"},   # Octubre
		{"mes": "Noviembre", "color": "ff8c00"}, # Noviembre
		{"mes": "Diciembre", "color": "32cd32"}  # Diciembre
	]



		
	# Lógica que verifica si el jugador ha llegado o superado la casilla 29
	if SelectedCharacter.player1_avanzar >= casillas.size():
		print("Advertencia: El jugador ha llegado a la última casilla.")
		
		# Cambiar mes
		var mes_index = meses.find({"mes": SelectedCharacter.mes})  # Buscar el índice del mes actual
		
		# Asegurarnos de que el mes se actualice
		if mes_index == -1:
			# Si el mes actual no está en la lista, asignamos "Enero" como predeterminado
			mes_index = 0

		# Incrementar el índice del mes y hacer el ciclo cuando lleguemos a diciembre (índice 11)
		mes_index = (mes_index + 1) % meses.size()  # Esto asegura que después de Diciembre volvamos a Enero

		# Actualizar las variables globales del mes y color
		SelectedCharacter.mes = meses[mes_index]["mes"]
		SelectedCharacter.mes_color = meses[mes_index]["color"]
		
		print("Mes cambiado a: ", SelectedCharacter.mes, " con color: ", SelectedCharacter.mes_color)

		# Restablecer la posición del jugador
		SelectedCharacter.player1_avanzar = 0  # Resetear la posición a 0 para el próximo mes
		SelectedCharacter.player1_presupuesto += 500 

	# Asegúrate de que el dado no exceda el número de casillas (29 en este caso)
	if dado > casillas.size():
		print("Advertencia: El valor del dado es mayor que el número de casillas disponibles.")
		dado = casillas.size()  # Ajustamos el valor del dado al máximo posible




	# Mover la ficha a la posición de la casilla correspondiente
	if casillas.size() > 0:
		# Usamos global_position para obtener la posición global de la casilla
		var target_position = casillas[dado - 1].global_position
		
		# Calcular la posición local dentro del panel
		var local_position = target_position - enero_panel.global_position
		
		# Mover la ficha a la posición local
		ficha.position = local_position
		print("Ficha movida a la posición local del Marker2D", dado, ":", local_position)
		


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lanzar_7.tscn")
