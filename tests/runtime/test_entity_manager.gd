extends SceneTree


const ENTITY_MANAGER_SCRIPT: Script = preload("res://runtime/entity/entity_manager.gd")


func _init() -> void:
	var manager: RefCounted = ENTITY_MANAGER_SCRIPT.new()

	var first_id: EntityId = manager.create_entity()

	assert(
		first_id.is_valid(),
		"create_entity() must return a valid EntityId."
	)

	assert(
		manager.is_alive(first_id),
		"A newly created entity must be alive."
	)

	assert(
		first_id.index == 0,
		"The first entity must use slot 0."
	)

	assert(
		first_id.generation == 1,
		"The first entity generation must be 1."
	)

	var second_id: EntityId = manager.create_entity()

	assert(
		second_id.index == 1,
		"The second entity must use slot 1."
	)

	assert(
		second_id.generation == 1,
		"A newly allocated slot must start at generation 1."
	)

	assert(
		manager.destroy_entity(first_id),
		"Destroying an alive entity must succeed."
	)

	assert(
		not manager.is_alive(first_id),
		"A destroyed entity must no longer be alive."
	)

	assert(
		manager.destroy_entity(first_id) == false,
		"Destroying an already destroyed entity must fail."
	)

	var reused_id: EntityId = manager.create_entity()

	assert(
		reused_id.index == first_id.index,
		"A destroyed slot should be reused."
	)

	assert(
		reused_id.generation == 2,
		"Reused slots must increment their generation."
	)

	assert(
		manager.is_alive(reused_id),
		"The reused entity must be alive."
	)

	assert(
		not manager.is_alive(first_id),
		"The old EntityId must remain invalid after slot reuse."
	)

	assert(
		manager.is_alive(second_id),
		"An unrelated entity must remain alive."
	)

	assert(
		not manager.is_alive(EntityId.invalid()),
		"An invalid EntityId must never be alive."
	)

	assert(
		not manager.is_alive(EntityId.new(999, 1)),
		"An EntityId outside the slot range must never be alive."
	)

	print("EntityManager tests passed.")

	quit()

