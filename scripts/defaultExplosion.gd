extends Area2D

var damaged_entities = []
var radius
var damage

func setup(explosionRadius, explosionDamage):
    radius = explosionRadius
    damage = explosionDamage
    set_collider_shape()


func _physics_process (delta):
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if(body.is_in_group("player")):
            if not(body.get_instance_id() in damaged_entities):
                body.damage(proportional_damage(body))
                #body.damage(30)
                damaged_entities.append(body.get_instance_id())
        if(body.is_in_group("destructible")):
            body.explode()
    queue_free()

func set_collider_shape():
    var shape = CircleShape2D.new()
    shape.radius = radius
    $explosionCollider.shape = shape

func proportional_damage(body):
    var distance = body.global_position.distance_to(self.global_position)
    var proportional_damage = damage  - ((distance / radius) * damage)
    print('---')
    print(proportional_damage)
    print(distance)
    print((distance - radius) *damage)
    print('---')
    return int(proportional_damage)

