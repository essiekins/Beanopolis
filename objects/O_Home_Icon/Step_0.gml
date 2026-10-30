/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Pressed
/// @DnDVersion : 1.1
/// @DnDHash : 3002C3B1
var l3002C3B1_0;l3002C3B1_0 = mouse_check_button_pressed(mb_left);if (l3002C3B1_0){	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 3B8F1186
	/// @DnDParent : 3002C3B1
	/// @DnDArgument : "xpos" "mouse_x"
	/// @DnDArgument : "ypos" "mouse_y"
	/// @DnDArgument : "var" "cursor_sprite"
	/// @DnDArgument : "objectid" "S_Home"
	/// @DnDSaveInfo : "objectid" "S_Home"
	cursor_sprite = instance_create_layer(mouse_x, mouse_y, "Instances", S_Home);}