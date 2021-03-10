extends Node2D

var number_of_players = 4

onready var tank_scene:PackedScene = load("res://scenes/tank.tscn")
onready var current_player_label:RichTextLabel = $currentPlayerLabel
var players = []
var current_player = 0

var current_timer = 0.0
var turn_duration = 5.0

func _ready():
    for i in range(0, number_of_players):
        var player = tank_scene.instance()
        add_child(player)
        player.deactivate()
        player.position = Vector2(100 * i, 100 * i)
        players.append(player)
    
    players[0].activate()
    update_player_label()

func _physics_process(delta):
    current_timer += delta 
    if(current_timer >= turn_duration):
        players[current_player].deactivate()
        current_timer = 0
        current_player = (current_player + 1) % number_of_players
        players[current_player].activate()
        update_player_label()

func force_end_turn():
    current_timer = turn_duration

func update_player_label():
    current_player_label.text = "Current Player: P" + str(current_player + 1)
