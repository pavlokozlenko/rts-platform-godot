class_name ComponentStorage
extends RefCounted


var _components: Dictionary = {}


func add(entity_id: EntityId, component: RefCounted) -> bool:
	if entity_id == null or not entity_id.is_valid():
		return false

	if component == null:
		return false

	var entity_key := entity_id.to_key()
	var component_key := _get_component_key(component)

	if component_key.is_empty():
		return false

	if not _components.has(entity_key):
		_components[entity_key] = {}

	var entity_components: Dictionary = _components[entity_key]

	if entity_components.has(component_key):
		return false

	entity_components[component_key] = component

	return true


func remove(
	entity_id: EntityId,
	component_script: Script
) -> bool:
	if entity_id == null or not entity_id.is_valid():
		return false

	if component_script == null:
		return false

	var entity_key := entity_id.to_key()

	if not _components.has(entity_key):
		return false

	var component_key := component_script.resource_path

	if component_key.is_empty():
		return false

	var entity_components: Dictionary = _components[entity_key]

	var removed := entity_components.erase(component_key)

	if entity_components.is_empty():
		_components.erase(entity_key)

	return removed


func has(
	entity_id: EntityId,
	component_script: Script
) -> bool:
	if entity_id == null or not entity_id.is_valid():
		return false

	if component_script == null:
		return false

	var entity_key := entity_id.to_key()

	if not _components.has(entity_key):
		return false

	var component_key := component_script.resource_path

	if component_key.is_empty():
		return false

	var entity_components: Dictionary = _components[entity_key]

	return entity_components.has(component_key)


func get_component(
	entity_id: EntityId,
	component_script: Script
) -> RefCounted:
	if not has(entity_id, component_script):
		return null

	var entity_key := entity_id.to_key()
	var component_key := component_script.resource_path
	var entity_components: Dictionary = _components[entity_key]

	return entity_components[component_key]


func remove_all(entity_id: EntityId) -> bool:
	if entity_id == null or not entity_id.is_valid():
		return false

	return _components.erase(entity_id.to_key())


func _get_component_key(component: RefCounted) -> String:
	var component_script: Script = component.get_script()

	if component_script == null:
		return ""

	return component_script.resource_path
