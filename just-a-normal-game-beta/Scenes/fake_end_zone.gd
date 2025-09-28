extends Area2D

signal player_reached_end  # 自定義信號，當玩家到達終點時觸發

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):  # 假設玩家在 "player" 群組中
		# 讓 Area2D 慢慢向上移動
		var float_speed = 75.0  # 上升速度（像素/秒）
		var is_floating = true
		var initial_position = position  # 記錄初始位置

		while is_floating:
			position.y -= float_speed * get_process_delta_time()  # 逐步向上移動
			# 可選：設置最大高度後停止（例如上升 100 像素）
			if position.y <= initial_position.y - 1000:
				is_floating = false
			await get_tree().process_frame  # 等待下一幀
