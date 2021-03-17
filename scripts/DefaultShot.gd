extends Area2D

const speed = 1000
var parent_collider_id
var has_exploded = false

onready var default_explosion: PackedScene = load("res://scenes/defaultExplosion.tscn")
onready var explosion_particle: PackedScene = load("res://scenes/explosionParticle.tscn")

func _physics_process(delta):
    var velocity = Vector2(speed, 0).rotated(rotation)
    position += velocity * delta

func _on_DefaultShot_body_entered(body):
    if(body.get_instance_id() != parent_collider_id):
        if(not(has_exploded)):
            has_exploded = true
            print("firing explosion")
            var explosion = default_explosion.instance()
            explosion.setup(100, 30)
            get_parent().call_deferred("add_child", explosion)
            explosion.position = self.position

            var particles = explosion_particle.instance()
            particles.position = self.position
            get_parent().call_deferred("add_child", particles)
            particles.call_deferred("restart")
            queue_free()
