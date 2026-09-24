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

	component_storage.remove_all(entity_id)

	return true


func is_alive(entity_id: EntityId) -> bool:
	return entity_manager.is_alive(entity_id)


func add_component(
	entity_id: EntityId,
	component: RefCounted
) -> bool:
	if not is_alive(entity_id):
		return false

	return component_storage.add(entity_id, component)


func get_component(
	entity_id: EntityId,
	component_script: Script
) -> RefCounted:
	if not is_alive(entity_id):
		return null

	return component_storage.get_component(
		entity_id,
		component_script
	)


func remove_component(
	entity_id: EntityId,
	component_script: Script
) -> bool:
	if not is_alive(entity_id):
		return false

	return component_storage.remove(
		entity_id,
		component_script
	)
