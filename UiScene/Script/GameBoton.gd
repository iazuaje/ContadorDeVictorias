extends PanelContainer

onready var nombre = $MarginContainer/Nombre
var nombreDelJuego : String

signal juegoElegido

func initBoton(tituloJuego):
	nombre.text = tituloJuego
	nombreDelJuego = tituloJuego

func _on_Button_pressed():
	emit_signal("juegoElegido", nombreDelJuego)
