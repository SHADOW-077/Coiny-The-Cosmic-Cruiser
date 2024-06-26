extends Node2D

signal coin_spawned(coin_inst)#sends a signal coin is spawned
var coin = preload("res://scene/coin.tscn") #preloading the coin scene as coin
var number_coins = 0 #creates a variable
var alive = true
var player
var turret
var coin_cont
func _ready():
	pass
	player = get_parent().get_parent().find_child("Player")
	turret = get_parent().get_parent().find_child("Truck")
	coin_cont = get_parent().get_parent().find_child("coin_container")

func spawn_coin(): #custom func
	var too_close_to_bodies = true
	var spawn_pos = Vector2(randf_range($pos_x1.position.x,$pos_x2.position.x),randf_range($pos_x2.position.y,$pos_y.position.y))
	#while loop to make sure coins dont spawn on player
	#while too_close_to_bodies:
		#var valid_spawn = true
		#for i in coin_cont.get_children():
			#if not spawn_pos.distance_to(i.position) > 75:
				#valid_spawn = false
				#break
#
		#if valid_spawn and spawn_pos.distance_to(player.position) > 50 and spawn_pos.distance_to(turret.position ) > 300:
			#too_close_to_bodies = false
		#else:
			#spawn_pos = Vector2(randf_range(50,500), randf_range(50,680))
	var coin_inst = coin.instantiate()
	coin_inst.position = spawn_pos
	emit_signal("coin_spawned", coin_inst)#emits signal coin spawned with parameters spawn_position,coin_instance


func _on_timer_timeout():
	if number_coins <= randf_range(10,16) && alive == true: #gets random max value for no of coins
		spawn_coin()


func _on_game_no_of_coins(number):
	number_coins = number# the number from signal is assigned to a local var in script since it cant be accessed outside signal


func _on_game_alive(is_alive):
	alive = is_alive
