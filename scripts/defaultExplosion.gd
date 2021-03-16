extends Area2D

var damaged_entities = []

func _physics_process (delta):
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if(body.is_in_group("player")):
            if not(body.get_instance_id() in damaged_entities):
                print("damaging body: " + str(body.get_instance_id()))
                body.damage(90)
                damaged_entities.append(body.get_instance_id())
        if(body.is_in_group("destructible")):
            body.explode()
    queue_free()
