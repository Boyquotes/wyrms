extends StaticBody2D

var coordinate
var tilemap:TileMap

var max_health = 30
var health = max_health

func _process(delta):
    if tilemap.get_cellv(coordinate + Vector2(0, 1)) == -1:
        tilemap.set_cellv(coordinate, 3)

func explode(damage):
    health -= damage

    if(health <= 0):
        tilemap.set_cellv(coordinate, -1)
        queue_free()
    print("wall" + str(health/max_health))
    $crack.modulate.a = 1 - health/max_health
