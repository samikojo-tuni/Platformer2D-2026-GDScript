extends Node

# Signals
# score_changed is triggered when the score changes
signal score_changed(new_score : int)

# Player's score in this session
var _score : int = 0
var _current_level : Level = null
var _scene_tree : SceneTree = null

#region Settings data
const SETTINGS_PATH : String = "user://settings.cfg"
const AUDIO_SECTION : String = "Audio"
const MASTER_BUS : String = "Master"
const MUSIC_BUS : String = "Music"
const EFFECTS_BUS : String = "Effects"
const DEFAULT_VOLUME_DB : float = -6.0
#endregion

#region Godot messages
func _ready() -> void:
	_restore_settings()
#endregion

#region Score functionality
func reset() -> void:
	set_score(0)
	
func add_score(amount: int) -> void:
	# Only a positive amount can be added to the score
	if amount > 0:
		set_score(_score + amount)
	
func get_score() -> int:
	return _score

func set_score(new_score : int) -> void:
	# Validate the new_score before setting it
	_score = max(new_score, 0)
	# Emit a signal every time the score is updated.
	score_changed.emit(_score)

func get_scene_tree() -> SceneTree:
	if _scene_tree == null:
		_scene_tree = get_tree()
	return _scene_tree
#endregion	

#region Level functionality
func get_current_level() -> Level:
	return _current_level

func register_current_level(new_level: Level) -> void:
	if _current_level == null:
		_current_level = new_level
		
func go_to_scene(scene_path: String) -> void:
	_load_scene.call_deferred(scene_path)

func _load_scene(scene_path: String) -> void:
	if _current_level != null:
		# Delete the current level from memory
		_current_level.free()
	
	var next_scene: PackedScene = ResourceLoader.load(scene_path) as PackedScene
	if next_scene != null:
		_current_level = next_scene.instantiate() as Level
	else:
		push_error("GameManager: Failed to load a scene in the path %s" % scene_path)
		return
	
	if _scene_tree == null:
		_scene_tree = get_tree()
		
	if _scene_tree != null:
		_scene_tree.root.add_child(_current_level)
		_scene_tree.current_scene = _current_level
	
#endregion

#region Internal functionality
func _restore_settings() -> void:
	var config_file : ConfigFile = ConfigFile.new()
	var load_error : Error = config_file.load(SETTINGS_PATH)
	
	var master_volume_db : float = DEFAULT_VOLUME_DB
	var music_volume_db  : float = DEFAULT_VOLUME_DB
	var effects_volume_db  : float = DEFAULT_VOLUME_DB
	
	if load_error != Error.OK:
		push_warning("Error loading settings: %s" % load_error)
	else:
		# Loading file succeeded
		master_volume_db = config_file.get_value(AUDIO_SECTION, MASTER_BUS, DEFAULT_VOLUME_DB)
		music_volume_db = config_file.get_value(AUDIO_SECTION, MUSIC_BUS, DEFAULT_VOLUME_DB)
		effects_volume_db = config_file.get_value(AUDIO_SECTION, EFFECTS_BUS, DEFAULT_VOLUME_DB)
	
	_set_volume(MASTER_BUS, master_volume_db)
	_set_volume(MUSIC_BUS, music_volume_db)
	_set_volume(EFFECTS_BUS, effects_volume_db)

func _set_volume(audio_bus: String, volume_db: float) -> bool:
	var bus_index = AudioServer.get_bus_index(audio_bus)
	if bus_index < 0:
		return false
	
	AudioServer.set_bus_volume_db(bus_index, volume_db)
	return true
	
#endregion
