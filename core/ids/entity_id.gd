class_name EntityId
extends RefCounted


const INVALID_INDEX: int = -1
const INVALID_GENERATION: int = -1


var index: int
var generation: int


static func invalid() -> EntityId:
	return EntityId.new()


func _init(
	entity_index: int = INVALID_INDEX,
	entity_generation: int = INVALID_GENERATION
) -> void:
	index = entity_index
	generation = entity_generation


func is_valid() -> bool:
	return index >= 0 and generation >= 0


func equals(other: EntityId) -> bool:
	if other == null:
		return false

	return index == other.index and generation == other.generation


func _to_string() -> String:
	return "EntityId(%d, %d)" % [index, generation]
