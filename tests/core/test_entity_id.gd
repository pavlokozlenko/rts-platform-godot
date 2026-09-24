extends SceneTree


func _init() -> void:
	var valid_id := EntityId.new(10, 1)
	var same_id := EntityId.new(10, 1)
	var different_generation := EntityId.new(10, 2)
	var invalid_id := EntityId.invalid()

	assert(valid_id.is_valid(), "A valid EntityId must be valid.")
	assert(same_id.is_valid(), "A valid EntityId must be valid.")
	assert(not invalid_id.is_valid(), "An invalid EntityId must not be valid.")

	assert(
		valid_id.equals(same_id),
		"EntityIds with the same index and generation must be equal."
	)

	assert(
		not valid_id.equals(different_generation),
		"EntityIds with different generations must not be equal."
	)

	print("EntityId tests passed.")

	quit()
