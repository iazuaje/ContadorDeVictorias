extends Node

var UsuariosActivos = []

func save(usuario) -> void:
	var file_name = "user://juegos//" + DataGlobal.JuegoElegido + "//" + usuario.nombre + ".res"
	var result = ResourceSaver.save(file_name, usuario)
	assert(result == OK)
	
func save_all():
	for usuario in UsuariosActivos:
		save(usuario)

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files

func load_data():
	UsuariosActivos.clear()
	var files = list_files_in_directory("user://juegos//" + DataGlobal.JuegoElegido)
	for file in files:
		if ResourceLoader.exists("user://juegos//" + DataGlobal.JuegoElegido + "//" + file):
			var usuario = ResourceLoader.load("user://juegos//" + DataGlobal.JuegoElegido + "//" + file)
			if usuario is Usuario: # Check that the data is valid
				UsuariosActivos.append(usuario)

static func eliminarUsuario(usuario : Usuario):
	var dir : Directory = Directory.new()
	dir.open("user://juegos//" + DataGlobal.JuegoElegido)
	if dir.file_exists("user://juegos//" + DataGlobal.JuegoElegido + "//" + usuario.nombre + ".res"): 
		dir.remove("user://juegos//" + DataGlobal.JuegoElegido + "//" + usuario.nombre + ".res")
