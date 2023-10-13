extends Node

@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}
var upgrade_pool: WeightedTable = WeightedTable.new()

var resource_string: String = "resource"
var quantity_string: String = "quantity"

var upgrade_axe = preload("res://Resources/Upgrades/Axe.tres")
var upgrade_axe_damage = preload("res://Resources/Upgrades/AxeDamage.tres")
var upgrade_sword_rate = preload("res://Resources/Upgrades/SwordRate.tres")
var upgrade_sword_damage = preload("res://Resources/Upgrades/SwordDamage.tres")

func _ready():
	#The greater the weight the more likely it is to be chosen
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	
	experience_manager.level_up.connect(on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade):
	#Does the current upgrade have a key that matches chosen upgrade
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			resource_string: upgrade,
			quantity_string: 1
		}
	else:
		current_upgrades[upgrade.id][quantity_string] += 1
		
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)
	
	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)


func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	
	for i in 3:
		#if exclude array is equal to the upgrade pool then the table will not contain any upgrades
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
			
		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)
	
	return chosen_upgrades


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func on_level_up(current_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
