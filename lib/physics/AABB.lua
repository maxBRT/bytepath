local AABB = function(box_a, box_b)
	print("checking")
	return (
		box_a.x < box_b.x + box_b.w
		and box_a.x + box_a.w > box_b.x
		and box_a.y < box_b.y + box_b.h
		and box_a.y + box_a.h > box_b.y
	)
end

return AABB
