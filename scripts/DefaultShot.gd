extends Area2D

const speed = 1000
var parent_collider_id

onready var default_explosion: PackedScene = load("res://scenes/defaultExplosion.tscn")

func _ready():
    pass # Replace with function body.
    
func _physics_process(delta):
    var velocity = Vector2(speed, 0).rotated(rotation)
    position += velocity * delta


func explode():
    print("boom")
    queue_free()


func _on_DefaultShot_body_entered(body):
    if(body.get_instance_id() != parent_collider_id):
        var explosion = default_explosion.instance()
        get_parent().call_deferred("add_child", explosion)
        explosion.position = self.position

        explode()
