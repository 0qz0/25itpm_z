class_name Room
extends Resource

enum Type {NOT_ASSIGNED, MONSTER, ELITE,TREASURE, CAMPFIRE, SHOP, BOSS, EVENT}

@export var type: Type
@export var row: int
@export var column: int
@export var position: Vector2
@export var next_rooms: Array[Room]
@export var selected := false
@export var event_scene: PackedScene
 # only used in battles
@export var battle_stats: BattleStats

func _to_string() -> String:
	return "%s (%s)" % [column, Type.keys()[type][0]]
