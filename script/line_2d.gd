extends Line2D

func _ready():
	var num_points = 100  # Número de puntos para el círculo
	var radius = 100  # Radio del círculo
	var center = Vector2(0, 0)  # Centro del círculo
	
	for i in range(num_points):
		var angle = i * 2 * PI / num_points
		var point = center + Vector2(cos(angle), sin(angle)) * radius
		add_point(point)
