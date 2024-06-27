extends Node2D

var brush = PackedVector2Array()
var pressing = false

func _ready():
	for i in 30:
		var angle = i * PI / 15
		
		brush.push_back(Vector2(cos(angle), sin(angle)) * 40)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pressing = event.pressed
		else:
			return
	elif !(event is InputEventMouseMotion):
		return
	
	queue_redraw()
	
	if pressing:
		$DestructiblePolygon2D.destruct(brush, event.position)

func _draw():
	var points = Transform2D(0, get_global_mouse_position()) * brush
	
	points.push_back(points[0])
	
	draw_polyline(points, Color.BLACK if pressing else Color.WHITE, 3, true)

func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		queue_redraw()
