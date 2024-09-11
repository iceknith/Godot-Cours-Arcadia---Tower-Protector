extends Area2D

@export var speed = 50.0
@export var acceleration = 10.0

var velocity:Vector2
var target:Vector2 = Vector2.ZERO

# Appelé dès que le noeud entre dans une scène
func _ready():
	$AnimatedSprite2D.play("spawn")

# Appelé chaque frame, delta représente le temps passé entre la frame précédente et la frame actuelle
func _physics_process(delta):
	# Si l'ennemi est en train de courrir, et qu'il as une cible
	if $AnimatedSprite2D.animation == "run" && target != Vector2.ZERO:
		
		# On donne la direction de l'ennemi
		var direction = (target - global_position).normalized()
		
		# On donne une velocité à l'ennemi
		velocity = lerp(velocity, direction * speed, delta * acceleration)
		
		# On change la direction du sprite de l'ennemi, si celui-ci change de direction
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif direction.x > 0:
			$AnimatedSprite2D.flip_h = false
		
		# On change la position de l'ennemi
		position = position + velocity * delta

func _on_body_entered(body):
	# Si il y as eu une collision entre un corps et cette Area2D
	
	# Si le corps est un joueur
	if body.name == "Player":
		# On joue l'annimation de mort de l'ennemi
		$AnimatedSprite2D.animation = "die"
		
	# Si le corps est une tour
	if body.name == "Tower":
		# On joue l'annimation d'explosion de l'ennemi
		$AnimatedSprite2D.animation = "explode"
		# On dit à la tour de prendre des dégats
		body.damage()

func _on_animated_sprite_2d_animation_looped():
	# Une fois qu'une annimation est finie
	
	# Si cette animation est l'annimation de spawn
	if $AnimatedSprite2D.animation == "spawn":
		# On change cette annimation en l'animation de course
		$AnimatedSprite2D.animation = "run"
		
	# Si cette animation est l'animation de mort, ou d'explosion
	elif $AnimatedSprite2D.animation == "die" or $AnimatedSprite2D.animation == "explode":
		# On fait disparaitre cet objet
		queue_free()
