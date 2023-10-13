class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum = 0


func add_item(item, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight


func remove_item(item_to_remove):
	#Give us all items in the items array that are not equal to item_to_remove
	items = items.filter(func (item): return item["item"] != item_to_remove)
	#set the weight sum to zero
	weight_sum = 0
	#loop through the new array of items adding up the weights
	for item in items:
		weight_sum += item["weight"]


func pick_item(exclude: Array = []):
	var adjusted_items: Array[Dictionary] = items
	var adjusted_weight_sum = weight_sum
	
	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		#iterate over each item and get the object of the godot variant and
		for item in items:
			#check if said item is in exclude array
			if item["item"] in exclude:
				#continue = go to next item in loop
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]
	
	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	
	for item in adjusted_items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
