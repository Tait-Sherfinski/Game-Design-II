extends Control




func _on_button_pressed():
	var length = int($LineEdit.text)
	var width = int($LineEdit2.text)
	var area = length * width
	var perim = 2 * length + 2 * width
	$Label3.text = "Area: " + str(area)
	$Label4.text = "Perimeter: " + str(perim)


func _on_button_2_pressed():
	$Label3.text = ""
	$Label4.text = ""
	$LineEdit.text = ""
	$LineEdit2.text = ""


func _on_button_3_pressed():
	get_tree().quit()
