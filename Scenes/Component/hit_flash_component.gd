extends Node

@export var health_component: Node
@export var sprite: Sprite2D
@export var hit_flash_material: ShaderMaterial


var hit_flash_tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.health_changed.connect(on_health_changed)
	sprite.material = hit_flash_material

func on_health_changed():
	#If there is already tween that is currently running
	if hit_flash_tween != null && hit_flash_tween.is_valid():
		#Invalidate the tween
		hit_flash_tween.kill()
		
	#re-assign the tween
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hit_flash_tween = create_tween()
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, 0.3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
