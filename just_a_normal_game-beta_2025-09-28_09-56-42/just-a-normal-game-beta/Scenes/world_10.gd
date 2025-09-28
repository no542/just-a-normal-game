extends Node2D

@onready var player = $Player
@onready var camera = $Player/Camera2D
@onready var end_zone = $EndZone
@onready var clear_label = $CanvasLayer/ClearLabel
@onready var blur_rect = $CanvasLayer/BlurRect
@onready var fade_rect = $CanvasLayer/FadeRect

var initial_player_position: Vector2

func _ready():
	initial_player_position = player.position
	var error = end_zone.connect("body_entered", _on_body_entered)
	if error != OK:
		print("Failed to connect body_entered signal: ", error)
	clear_label.modulate = Color(1, 1, 1, 0)
	blur_rect.material.set_shader_parameter("blur_amount", 0.0)
	fade_rect.modulate = Color(0, 0, 0, 0)

func _on_body_entered(body):
	print("Player entered EndZone!")
	if body.is_in_group("player"):
		_on_player_reached_end()

func _on_player_reached_end():
	player.set_physics_process(false)
	var tween = get_tree().create_tween()
	tween.tween_property(clear_label, "modulate:a", 1.0, 1.0)
	tween.tween_interval(0.5)
	tween.tween_property(blur_rect.material, "shader_parameter/blur_amount", 5.0, 0.5)
	tween.tween_property(blur_rect.material, "shader_parameter/blur_amount", 0.0, 0.5)
	tween.tween_callback(_change_to_clear_question)
	tween.tween_interval(2.0)
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0)
	tween.tween_callback(_reset_player)
	tween.tween_property(fade_rect, "modulate:a", 0.0, 1.0)
	tween.tween_callback(_enable_player)

func _change_to_clear_question():
	clear_label.text = "Clear!!!"

func _reset_player():
	get_tree().change_scene_to_file("res://end_menu.tscn")
	camera.position = Vector2.ZERO
	clear_label.modulate = Color(1, 1, 1, 0)  # 強制隱藏 "Clear?"

func _enable_player():
	player.set_physics_process(true)
