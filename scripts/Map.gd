extends Node2D

onready var tilemap:TileMap = $FGTilemap
onready var cell_nodes:Node2D = $cellNodes

onready var wall_scene:PackedScene = load("res://scenes/tiles/wall.tscn")

func _ready():
    populate_tilemap_with_logic_nodes()

func populate_tilemap_with_logic_nodes():
    var cells = tilemap.get_used_cells_by_id(4)
    for cell in cells:
        var cell_node = wall_scene.instance()
        cell_node.coordinate = cell
        cell_node.tilemap = tilemap
        print(tilemap.cell_size)
        cell_node.position = Vector2(cell.x * tilemap.cell_size.x, cell.y * tilemap.cell_size.y)
        cell_nodes.add_child(cell_node)

func get_spawn_points():
    var children = $spawnPoints.get_children()
    var points = []
    for child in children:
        points.append(child.position)
    return points
