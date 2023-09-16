extends Control
class_name VentanaCreacionJuego

signal atrasPresionado
signal aceptarPresionado

onready var nombre_edit = $Control/VBoxContainer/MarginContainer2/VBoxContainer/nombreEdit

func _on_atras_pressed():
	emit_signal("atrasPresionado")

func _on_aceptar_pressed():
	if nombre_edit.text != "":
		emit_signal("aceptarPresionado", nombre_edit.text)
	_on_atras_pressed()
