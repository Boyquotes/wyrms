extends StaticBody2D

var coordinate
var tilemap:TileMap

func explode():
    tilemap.set_cellv(coordinate, 1)
    queue_free()
