extends Node2D

var number_of_players = 4
var current_number_of_players = number_of_players

onready var tank_scene:PackedScene = load("res://scenes/tank.tscn")
onready var current_player_label:RichTextLabel = $currentPlayerLabel
onready var turn_duration_label:RichTextLabel = $turnDuration
var players = []
var current_player = 0
var game_running = true

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


func manage_turns(delta):
    if(count_current_players() <= 1):
        end_game()
        
    current_timer -= delta
    update_timer_label()
    if(current_timer <= 0):
        deactivate_current_player()
        restart_turn()
        activate_next_player()
        update_player_label()

func _physics_process(delta):
    if(game_running):
        manage_turns(delta)

func end_game():
    game_running = false

func count_current_players():
    var counter = 0
    for player in players:
        print(player)
        if(player):
            counter += 1
    return counter

func deactivate_current_player():
    if(players[current_player]):
        players[current_player].deactivate()
        
func restart_turn():
    current_timer = turn_duration

func end_turn():
    current_timer = 0
    
func activate_next_player():
    current_player = (current_player + 1) % number_of_players
    if(players[current_player]):
        players[current_player].activate()
    else:
        end_turn()
       
func update_player_label():
    current_player_label.text = "Current Player: P" + str(current_player + 1)

func update_timer_label():
    turn_duration_label.text = str(int(current_timer))

func set_turn_duration(duration):
    current_timer = duration

func _on_TurnCoordinator_end_turn():
    current_timer = turn_duration
