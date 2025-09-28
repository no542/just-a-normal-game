extends Node2D

@onready var player = $Player
@onready var camera = $Player/Camera2D
@onready var end_zone = $EndZone
@onready var fade_rect = $CanvasLayer/FadeRect

var initial_player_position: Vector2

func _ready():
	initial_player_position = player.position
	var error = end_zone.connect("body_entered", _on_body_entered)
	if error != OK:
		print("Failed to connect body_entered signal: ", error)
	fade_rect.modulate = Color(0, 0, 0, 0)

func _on_body_entered(body):
	print("Player entered EndZone!")
	if body.is_in_group("player"):
		_on_player_reached_end()

func _on_player_reached_end():
	player.set_physics_process(false)
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0)
	tween.tween_callback(_reset_player)
	tween.tween_property(fade_rect, "modulate:a", 0.0, 1.0)
	tween.tween_callback(_enable_player)

func _reset_player():
	get_tree().change_scene_to_file("res://Scenes/world_7.tscn")
	player.position = initial_player_position
	camera.position = Vector2.ZERO
func _enable_player():
	player.set_physics_process(true)
