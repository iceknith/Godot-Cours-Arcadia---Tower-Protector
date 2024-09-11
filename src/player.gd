# Le "extends CharacterBody2D" signale au système que notre noeud est un CharacterBody2D
extends CharacterBody2D

# On crée des variables (dees petites boîtes dans lesquelles on peut mettre des valeurs)
# le @export de ces variables signifie que ces valeurs seront montrées dans l'éditeur, 
# et pourront être changé depuis l'éditeur
@export var speed = 300.0
@export var acceleration = 50.0

# Appelé dès que le noeud entre dans une scène
func _ready():
	# On met l'annimation du joueur à "idle", et on la joue
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

# Appelé chaque frame, delta représente le temps passé entre la frame précédente et la frame actuelle
func _physics_process(delta):
	
	# On récupère les entrées joueurs, et on les transforme en un vecteur qui donnera 
	# la direction dans laquelle le joueur ira
	var direction:Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	
	# On fait bouger le joueur en fonction de cette direction, en utilisant une fonction lerp pour "adoucir" le mouvement
	velocity = lerp(velocity, direction * speed, delta * acceleration)
	
	# On change la direction du sprite du joueur, si celui-ci change de direction
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		
	# Si le joueur arrête d'avancer, et que l'annimation n'est pas "idle"
	if direction == Vector2.ZERO and $AnimatedSprite2D.animation != "idle":
		# On met l'annimation à "idle"
		$AnimatedSprite2D.animation = "idle"
	# Si le joueur avance, et que l'annimation n'est pas "run"
	elif direction != Vector2.ZERO and $AnimatedSprite2D.animation != "run":
		# On met l'annimation à "idle"
		$AnimatedSprite2D.animation = "run"
	
	# On appelle une fonction de godot, qui bougera le joueur, et qui gèrera les collisions
	move_and_slide()
