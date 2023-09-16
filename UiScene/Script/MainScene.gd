extends Control

var UserContainerNode = preload("res://UiScene/UserContainer.tscn")

onready var contenedor_usuarios = $MarginContainer/VBoxContainer/contenedorUsuarios/contenedorUsuarios
onready var subtitulo_juego = $"MarginContainer/VBoxContainer/Subtitulo Juego"

func _ready():
	UserManager.load_data()
	for usuario in UserManager.UsuariosActivos:
		var userBox = UserContainerNode.instance()
		contenedor_usuarios.add_child(userBox)
		userBox.setup(usuario)
	subtitulo_juego.text = DataGlobal.JuegoElegido

func _on_AgregarJugadorBoton_pressed():
	SceneTransition.changeScene("res://UiScene/CreacionUsuario.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		UserManager.save_all()
		get_tree().quit() # default behavior

func _on_atrasBoton_pressed():
	UserManager.save_all()
	DataGlobal.JuegoElegido = ""
	SceneTransition.changeScene("res://UiScene/GameSelection.tscn")
