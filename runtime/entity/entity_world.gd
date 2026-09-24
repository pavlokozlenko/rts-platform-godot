class_name EntityWorld
extends RefCounted


const ENTITY_MANAGER_SCRIPT: Script = preload(
	"res://runtime/entity/entity_manager.gd"
)

const COMPONENT_STORAGE_SCRIPT: Script = preload(
	"res://runtime/entity/component_storage.gd"
)


var entity_manager: RefCounted
var component_storage: RefCounted


func _init() -> void:
	entity_manager = ENTITY_MANAGER_SCRIPT.new()
	component_storage = COMPONENT_STORAGE_SCRIPT.new()


func create_entity() -> EntityId:
	return entity_manager.create_entity()


func destroy_entity(entity_id: EntityId) -> bool:
	if not entity_manager.destroy_entity(entity_id):
		return false

	component_storage.remove(entity_id)

	return true


func is_alive(entity_id: EntityId) -> bool:
	return entity_manager.is_alive(entity_id)
