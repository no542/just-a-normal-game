extends Area2D

signal player_reached_end  # 自定義信號，當玩家到達終點時觸發

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):  # 假設玩家在 "player" 群組中
		emit_signal("player_reached_end")
