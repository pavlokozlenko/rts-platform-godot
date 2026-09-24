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


func replace_component(
	entity_id: EntityId,
	component: RefCounted
) -> bool:
	if not is_alive(entity_id):
		return false

	return component_storage.replace(
		entity_id,
		component
	)


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


func get_entities_with(
	component_script: Script
) -> Array[EntityId]:
	var result: Array[EntityId] = []

	var entity_keys: Array[Vector2i] = (
		component_storage._get_entity_keys_with(
			component_script
		)
	)

	for entity_key in entity_keys:
		var entity_id: EntityId = EntityId.new(
			entity_key.x,
			entity_key.y
		)

		if entity_manager.is_alive(entity_id):
			result.append(entity_id)

	return result


func get_entities_with_all(
	component_scripts: Array[Script]
) -> Array[EntityId]:
	var result: Array[EntityId] = []

	if component_scripts.is_empty():
		return result

	var candidate_entities: Array[EntityId] = (
		get_entities_with(component_scripts[0])
	)

	for entity_id in candidate_entities:
		var has_all_components := true

		for index in range(1, component_scripts.size()):
			var component_script: Script = component_scripts[index]

			if not component_storage.has(
				entity_id,
				component_script
			):
				has_all_components = false
				break

		if has_all_components:
			result.append(entity_id)

	return result
