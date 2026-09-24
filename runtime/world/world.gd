class_name World
extends RefCounted


const ENTITY_WORLD_SCRIPT: Script = preload(
	"res://runtime/entity/entity_world.gd"
)


var entity_world: RefCounted


func _init() -> void:
	entity_world = ENTITY_WORLD_SCRIPT.new()
