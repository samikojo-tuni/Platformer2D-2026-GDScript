class_name AudioControl extends VBoxContainer

@onready var bus_name_label: Label = $Label
@onready var volume_slider: HSlider = $HSlider
@export var audio_bus_name: StringName = ""

var _bus_index : int = -1
var _initial_volume_db : float = 0
var current_volume_db : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if _bus_index < 0:
		_bus_index = AudioServer.get_bus_index(audio_bus_name);
	
	if _bus_index < 0:
		push_error("Can't bind audio bus with the name %s" % audio_bus_name)
		return
	
	# Update label
	bus_name_label.text = audio_bus_name
	
	volume_slider.value_changed.connect(_on_volume_changed)

func update_slider() -> void:
	var db_volume : float = AudioServer.get_bus_volume_db(_bus_index)
	var linear_volume : float = db_to_linear(db_volume)
	volume_slider.value = linear_volume
	
	# Save initial volume to a variable
	_initial_volume_db = db_volume
	current_volume_db = db_volume

## Restores the volume to its initial value.
func resore_values() -> void:
	AudioServer.set_bus_volume_db(_bus_index, _initial_volume_db)

## linear_volume: Arvo väliltä [0,1]. O: 0%, 1: 100%
func _on_volume_changed(linear_volume: float) -> void:
	current_volume_db = linear_to_db(linear_volume)
	AudioServer.set_bus_volume_db(_bus_index, current_volume_db)
	
