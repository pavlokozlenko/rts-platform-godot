class_name EntityManager
extends RefCounted


class Slot:
	var generation: int = EntityId.INVALID_GENERATION
	var alive: bool = false


var _slots: Array[Slot] = []


func create_entity() -> EntityId:
	for index in _slots.size():
		var slot := _slots[index]

		if not slot.alive:
			slot.generation += 1
			slot.alive = true

			return EntityId.new(index, slot.generation)

	var slot := Slot.new()
	slot.generation = 1
	slot.alive = true

	_slots.append(slot)

	return EntityId.new(_slots.size() - 1, slot.generation)


func destroy_entity(entity_id: EntityId) -> bool:
	if not is_alive(entity_id):
		return false

	var slot := _slots[entity_id.index]
	slot.alive = false

	return true


func is_alive(entity_id: EntityId) -> bool:
	if entity_id == null:
		return false

	if entity_id.index < 0 or entity_id.index >= _slots.size():
		return false

	var slot := _slots[entity_id.index]

	return (
		slot.alive
		and slot.generation == entity_id.generation
	)

