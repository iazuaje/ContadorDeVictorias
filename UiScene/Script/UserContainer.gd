extends PanelContainer

onready var nombre = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/name
onready var count = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/count

var usuario : Usuario

func updateLabel():
	nombre.text = usuario.nombre
	count.text = String(usuario.puntaje)
	UserManager.save(usuario)

func setup(_usuario):
	usuario = _usuario
	updateLabel()

func _on_restaBoton_pressed():
	usuario.puntaje -= 1
	updateLabel()

func _on_sumarBoton_pressed():
	usuario.puntaje += 1
	updateLabel()

func _on_botonBorrar_pressed():
	UserManager.eliminarUsuario(usuario)
	SceneTransition.changeScene("res://UiScene/MainScene.tscn")
