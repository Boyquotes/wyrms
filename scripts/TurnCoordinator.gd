extends Node2D

var number_of_players = 4

onready var tank_scene:PackedScene = load("res://scenes/tank.tscn")
onready var current_player_label:RichTextLabel = $currentPlayerLabel
onready var turn_duration_label:RichTextLabel = $turnDuration
var players = []
var current_player = 0

var current_timer = 0.0
var turn_duration = 30.0

func _ready():
    for i in range(0, number_of_players):
        var player = tank_scene.instance()
        add_child(player)
        player.deactivate()
        player.position = Vector2(100 * i, 100 * i)
        player.connect("set_turn_duration", self, "set_turn_duration")
        players.append(player)
    
    players[0].activate()
    update_player_label()
    current_timer = turn_duration

func _physics_process(delta):
    current_timer -= delta 
    update_turn_label()
    if(current_timer <= 0.0):
        players[current_player].deactivate()
        current_timer = turn_duration
        current_player = (current_player + 1) % number_of_players
        players[current_player].activate()
        update_player_label()

func update_player_label():
    current_player_label.text = "Current Player: P" + str(current_player + 1)

func update_turn_label():
    turn_duration_label.text = str(int(current_timer))

func set_turn_duration(duration):
    current_timer = duration

func _on_TurnCoordinator_end_turn():
    current_timer = turn_duration
