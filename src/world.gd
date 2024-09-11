extends Node2D

signal game_end()

@export var enemy:PackedScene
var max_width_HP_bar

# Appelé dès que le noeud entre dans une scène
func _ready():
	# On prend la taille maximale de la barre de vie
	max_width_HP_bar = $"GUI/HP bar".size.x

# Appelé dès que l'on veut faire apparaitre un ennemi
func _on_enemy_spawn_timer_timeout():
	# On crée un mob (le nom qu'on donnera à l'ennemi qu'on fait apparaître)
	var mob = enemy.instantiate()
	
	# On choisit une position de spawn de notre ennemi, en prenant un point aléatoire sur le chemin de spawn des ennemis
	var mob_spawn_location = $EnemyPath/EnemySpawnPosition
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	# On change la cible de l'ennemi, pour qu'il aille vers la tour
	mob.target = $Tower.global_position
	
	# On ajoute l'ennemi à la scène, pour que celui-ci apparaisse
	add_child(mob)

# Appelé dès que la tour as pris des dégats
func _on_tower_is_hit(health_percent):
	# On change la taille de la barre de vie
	$"GUI/HP bar".size.x = max_width_HP_bar * health_percent

# Appelé dès que la tour est morte
func _on_tower_is_dead():
	# Si la tour est morte, il faut finir la partie 3s plus tard, donc on lance le timer de fin du jeu
	$GameEndTimer.start()

# Appelé dès que le timer de fin du jeu as fini
func _on_game_end_timer_timeout():
	# On fint la partie, en émettant le signal de fin de partie
	game_end.emit()
