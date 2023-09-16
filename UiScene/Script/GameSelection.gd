extends Control

var GameBoton = preload("res://UiScene/GameBoton.tscn")
var CreacionDeJuego = preload("res://UiScene/creacionDeJuego.tscn")

onready var containerJuego = $"MarginContainer/VBoxContainer/boxFull/container Juego"

var id_Window

func _ready():
	var dir = Directory.new()
	dir.open("user://")
	if not dir.dir_exists("user://juegos"):
		dir.make_dir("juegos")
	updateListaDeJuegos()

func eliminarHijos():
	var hijos = containerJuego.get_children()
	for hijo in hijos:
		containerJuego.remove_child(hijo)
		hijo.queue_free()

func updateListaDeJuegos():
	eliminarHijos()
	var juegos = UserManager.list_files_in_directory("user://juegos//")
	for juego in juegos:
		var juegoBoton = GameBoton.instance()
		containerJuego.add_child(juegoBoton)
		juegoBoton.initBoton(juego)
		juegoBoton.connect("juegoElegido", self, "elegirJuego")

func elegirJuego(juegoElegido):
	DataGlobal.JuegoElegido = juegoElegido
	SceneTransition.changeScene("res://UiScene/MainScene.tscn")

func agregarJuego(juego):
	var dir = Directory.new()
	dir.open("user://juegos//")
	dir.make_dir(juego)
	updateListaDeJuegos()

func eliminarVentana():
	var ventana = instance_from_id(id_Window)
	self.remove_child(ventana)
	ventana.queue_free()

func _on_AgregarJuegoBoton_pressed():
	var ventana = CreacionDeJuego.instance()
	self.add_child(ventana)
	ventana.connect("aceptarPresionado",self, "agregarJuego")
	ventana.connect("atrasPresionado", self, "eliminarVentana")
	id_Window = ventana.get_instance_id()

func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		UserManager.save_all()
		get_tree().quit() # default behavior

func _on_eliminarTodos_pressed():
	var dir : Directory = Directory.new()
	dir.open("user://juegos")
	var juegos = UserManager.list_files_in_directory("user://juegos")
	for juego in juegos:
		var inside_dir = Directory.new()
		inside_dir.open("user://juegos//" + juego)
		var usuarios = UserManager.list_files_in_directory("user://juegos//" + juego)
		for usuario in usuarios:
			inside_dir.remove("user://juegos//" + juego + "//" + usuario)
		dir.remove("user://juegos//" + juego)
	updateListaDeJuegos()
