class_name ComponentStorage
extends RefCounted


var _components: Dictionary = {}


func add(entity_id: EntityId, component: RefCounted) -> bool:
	if entity_id == null or not entity_id.is_valid():
		return false

	if component == null:
		return false

	var key := entity_id.to_key()

	if _components.has(key):
		return false

	_components[key] = component

	return true


func remove(entity_id: EntityId) -> bool:
	if entity_id == null or not entity_id.is_valid():
		return false

	return _components.erase(entity_id.to_key())


func has(entity_id: EntityId) -> bool:
	if entity_id == null or not entity_id.is_valid():
		return false

	return _components.has(entity_id.to_key())


func get_component(entity_id: EntityId) -> RefCounted:
	if not has(entity_id):
		return null

	return _components[entity_id.to_key()]
