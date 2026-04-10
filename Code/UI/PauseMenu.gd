class_name PauseMenu extends Control

@onready var master_audio_control: AudioControl = $Background/AudioControls/MasterAudioControl
@onready var music_audio_control: AudioControl = $Background/AudioControls/MusicAudioControl
@onready var effects_audio_control: AudioControl = $Background/AudioControls/EffectsAudioControl

var _is_open: bool = false

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		if _is_open:
			close()
		else:
			open()

func open() -> void:
	_is_open = true
	pause()
	show()
	
	master_audio_control.update_slider()
	music_audio_control.update_slider()
	effects_audio_control.update_slider()
	
func close() -> void:
	_is_open = false
	resume()
	hide()

func pause() -> void:
	GameManager.get_scene_tree().paused = true

func resume() -> void:
	GameManager.get_scene_tree().paused = false


func _on_ok_pressed() -> void:
	_save_settings()
	close()

func _on_cancel_pressed() -> void:
	_resore_settings()
	close()
	
func _resore_settings() -> void:
	master_audio_control.resore_values()
	music_audio_control.resore_values()
	effects_audio_control.resore_values()

func _save_settings() -> void:
	var settings_file = ConfigFile.new()
	
	settings_file.set_value(GameManager.AUDIO_SECTION, GameManager.MASTER_BUS, master_audio_control.current_volume_db)
	settings_file.set_value(GameManager.AUDIO_SECTION, GameManager.MUSIC_BUS, music_audio_control.current_volume_db)
	settings_file.set_value(GameManager.AUDIO_SECTION, GameManager.EFFECTS_BUS, effects_audio_control.current_volume_db)
	
	settings_file.save(GameManager.SETTINGS_PATH)
