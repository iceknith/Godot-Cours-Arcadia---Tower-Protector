extends Node

# On définit la scène du monde, qui sera crée une fois la partie lancée
var world_scene:PackedScene = load("res://src/world.tscn")

func _on_game_end():
	# Quand une partie est finie, on enlève le monde, et on montre le menu
	get_node("world").queue_free()
	$Menu.show()

func _on_start_button_button_down():
	# Quand la partie commence, on cache le menu, on instantie le monde, 
	# on connecte le signal de la fin de la partie, et on ajoute le monde à la scène
	$Menu.hide()
	var world = world_scene.instantiate()
	world.connect("game_end", _on_game_end)
	add_child(world)

func _on_start_button_mouse_entered():
	# Si la souris est sur le bouton, on baisse le texte,
	# pour donner l'impression que le texte est sur le bouton
	$Menu/Play.position.y += 10

func _on_start_button_mouse_exited():
	# Si la souris est sors du bouton, on remonte le texte,
	# pour donner l'impression que le texte est sur le bouton
	$Menu/Play.position.y -= 10
