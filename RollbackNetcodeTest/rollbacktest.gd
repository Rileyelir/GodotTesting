extends Node2D

const PlayerScene = preload("res://RollbackNetcodeTest/player.tscn")
@export var p1spawn: Node2D
@export var p2spawn: Node2D

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	SyncManager.sync_started.connect(_on_sync_started)

func host_game() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(9999)
	multiplayer.multiplayer_peer = peer

func join_game(ip: String) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, 9999)
	multiplayer.multiplayer_peer = peer

func _on_peer_connected(id: int) -> void:
	print(str(multiplayer.get_unique_id()) + ": Peer connected with id " + str(id))
	SyncManager.add_peer(id)
	
	# Spawn player scenes
	var peers = multiplayer.get_peers()
	peers.append(multiplayer.get_unique_id())
	peers.sort()
	for i in peers:
		_spawn_player(i)
	
	# Start match
	if multiplayer.is_server():
		SyncManager.start()

func _on_sync_started():
	pass

func _on_connected_to_server() -> void:
	print(str(multiplayer.get_unique_id()) + ": Connected to server successfully")

func _spawn_player(peer_id: int) -> void:
	var p = SyncManager.spawn("Player%d" % peer_id, p1spawn if peer_id == 1 else p2spawn, PlayerScene, {"owner_peer_id": peer_id})
	p.add_to_group("network_sync")

# ------------------------------------------------------------

func _on_join_game_button_down() -> void:
	$CanvasLayer.queue_free()
	join_game("127.0.0.1")

func _on_host_game_button_down() -> void:
	$CanvasLayer.queue_free()
	host_game()
