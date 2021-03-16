extends Area2D

func _physics_process (delta):
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if(body.is_in_group("player")):
            body.damage(90)
    queue_free()
