class_name Status
extends Resource

signal status_applied(status: Status)
signal status_changed

enum BuffType {BUFF, DOT_DEBUFF, CONTROL_DEBUFF, WEAKING_DEBUFF}
enum Type {START_OF_TURN, END_OF_TURN, EVENT_BASED}
enum StackType {NONE, INTENSITY, DURATION, BOTH}

@export_group("Status Data")
@export var id: String
@export var buff_type : BuffType
@export var type: Type
@export var stack_type: StackType
@export var can_expire: bool
@export var duration: int : set = set_duration
@export var stacks: int : set = set_stacks

@export_group("Status Visuals")
@export var icon: Texture
@export_multiline var tooltip: String

func initialize_status(_target: Node) -> void:
	pass
	
func apply_status(_target: Node) -> void:
	status_applied.emit(self)

func get_tooltip() -> String:
	return tooltip

func set_duration(new_duration: int) -> void:
	duration = new_duration
	status_changed.emit()

func set_stacks(new_stacks: int) -> void:
	stacks = new_stacks
	status_changed.emit()
