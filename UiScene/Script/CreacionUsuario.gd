extends Control

onready var nombre_edit = $MarginContainer/VBoxContainer/NombreEditBox/VBoxContainer/nombreEdit
onready var puntaje_edit = $MarginContainer/VBoxContainer/PuntajeEditBox/VBoxContainer/puntajeEdit

func _on_AtrasBoton_pressed():
	SceneTransition.changeScene("res://UiScene/MainScene.tscn")

func _on_crearBoton_pressed():
	if (nombre_edit.text == ""):
		_on_AtrasBoton_pressed()
	var usuario = Usuario.new()
	usuario.initUsuario(nombre_edit.text, puntaje_edit.text.to_int())
	UserManager.save(usuario)
	_on_AtrasBoton_pressed()
