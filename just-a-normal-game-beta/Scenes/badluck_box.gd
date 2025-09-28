extends Area2D

var spike_scene = preload("res://trap/spike(16x_32).tscn")

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		spawn_spike_up()
		spawn_spike_down()

func spawn_spike_down():
	var spike = spike_scene.instantiate()
	# 使用 call_deferred 延遲添加至場景樹
	get_tree().current_scene.call_deferred("add_child", spike)
	spike.position = position + Vector2(0, 24)  # 設置位置
	spike.add_to_group("Hex")  # 加入 traps 組

func spawn_spike_up():
	var spike = spike_scene.instantiate()
	# 使用 call_deferred 延遲添加至場景樹
	get_tree().current_scene.call_deferred("add_child", spike)
	spike.position = position + Vector2(0, -24)  # 設置位置
	spike.add_to_group("Hex")  # 加入 traps 組H
