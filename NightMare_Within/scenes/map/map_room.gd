class_name MapRoom
extends Area2D

signal clicked(room: Room)
signal selected(room: Room)

const ICONS := {
	Room.Type.NOT_ASSIGNED: [null, Vector2.ONE],
	Room.Type.MONSTER: [preload("res://art/ui/map/monster.png"), Vector2.ONE],
	Room.Type.TREASURE: [preload("res://art/ui/map/chest.png"), Vector2.ONE],
	Room.Type.CAMPFIRE: [preload("res://art/ui/map/campfire.png"), Vector2(0.6, 0.6)],
	Room.Type.SHOP: [preload("res://art/ui/map/shop.png"), Vector2(0.6, 0.6)],
	Room.Type.BOSS: [preload("res://art/ui/map/boss.png"), Vector2(1.25, 1.25)],
	Room.Type.EVENT: [preload("res://art/ui/map/event.png"), Vector2(0.9, 0.9)],
}

@onready var sprite_2d: Sprite2D = $Visuals/Sprite2D
@onready var line_2d: Line2D = $Visuals/Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var available := false : set = set_available
var room: Room : set = set_room


func set_available(new_value: bool) -> void:
	available = new_value
	
	if available:
		animation_player.play("highlight")
	elif not room.selected:
		animation_player.play("RESET")


func set_room(new_data: Room) -> void:
	room = new_data
	position = room.position
	line_2d.rotation_degrees = RNG.instance.randi_range(0, 360)
	sprite_2d.texture = ICONS[room.type][0]
	sprite_2d.scale = ICONS[room.type][1]


func show_selected() -> void:
	line_2d.modulate = Color.WHITE


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not available or not event.is_action_pressed("left_mouse"):
		return

	room.selected = true
	clicked.emit(room)
	animation_player.play("select")


# Called by the AnimationPLayer when the 
# "select" animation finishes.
func _on_map_room_selected() -> void:
	selected.emit(room)
