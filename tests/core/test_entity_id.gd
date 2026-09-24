extends SceneTree


func _init() -> void:
	var first_id := EntityId.new(10, 1)
	var same_id := EntityId.new(10, 1)
	var different_generation := EntityId.new(10, 2)
	var zero_generation := EntityId.new(10, 0)
	var invalid_id := EntityId.invalid()

	assert(first_id.is_valid(), "A positive generation must produce a valid EntityId.")
	assert(same_id.is_valid(), "A positive generation must produce a valid EntityId.")
	assert(different_generation.is_valid(), "A positive generation must produce a valid EntityId.")

	assert(
		not zero_generation.is_valid(),
		"Generation zero must be reserved for invalid EntityIds."
	)

	assert(
		not invalid_id.is_valid(),
		"An invalid EntityId must not be valid."
	)

	assert(
		first_id.equals(same_id),
		"EntityIds with the same index and generation must be equal."
	)

	assert(
		not first_id.equals(different_generation),
		"EntityIds with different generations must not be equal."
	)

	print("EntityId tests passed.")

	quit()
