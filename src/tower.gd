extends StaticBody2D

# On crée des signaux (un moyens de connecter des évènements de plusieurs objets entres eux de façon simple)
# Le premier signal sert à dire quand la tour est touchée, et dire combien de vie il lui reste
# Le deuxième signal sert à dire quand la tour est morte, et qu'il faut finir la partie, et retourner au menu
signal is_hit(health_percent:float)
signal is_dead()

@export var max_Health = 5
var health:float

# Appelé dès que le noeud entre dans une scène
func _ready():
	# On met la vie de la tour à sa vie maximale
	health = max_Health
	# On met l'animation de la tour à l'animation par défaut
	$AnimatedSprite2D.animation = "base animation"

func damage():
	# Cette fonction est appelée par un ennemi, quand il rentre dans la tour, et lui cause des dégats
	
	# Si la vie de la tour est nulle, on ne peut pas l'abaisser, donc on ne passe pas dans la fonction
	if (health <= 0): return
	
	# On enlève 1 à la vie de la tour
	health-=1
	# On dit que la tour est émise, et on donne sa vie, en émettant le signal
	is_hit.emit(health/max_Health)
	if (health == 0):
		# Si la tour n'as plus de vie, on émet le signal de mort, et on change l'animation de la tour
		is_dead.emit()
		$AnimatedSprite2D.animation = "dead"
