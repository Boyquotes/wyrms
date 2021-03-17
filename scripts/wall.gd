extends StaticBody2D

var coordinate
var tilemap:TileMap

var max_health = 30
var health = max_health


func explode(damage):
    health -= damage

    if(health <= 0):
        tilemap.set_cellv(coordinate, 1)
        queue_free()

    $crack.modulate.a = max_health/health
