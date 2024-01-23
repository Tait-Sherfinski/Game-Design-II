extends Control


func _on_button_pressed():
	$Label.text = "Basketball"


func _on_button_2_pressed():
	$Label.text = ""


func _on_button_3_pressed():
	get_tree().quit()
