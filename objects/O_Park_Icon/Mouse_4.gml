/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Pressed
/// @DnDVersion : 1.1
/// @DnDHash : 7369FA8F
var l7369FA8F_0;l7369FA8F_0 = mouse_check_button_pressed(mb_left);if (l7369FA8F_0){	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 17B2CD51
	/// @DnDParent : 7369FA8F
	/// @DnDArgument : "xpos" "mouse_x"
	/// @DnDArgument : "ypos" "mouse_y"
	/// @DnDArgument : "objectid" "O_Park"
	/// @DnDSaveInfo : "objectid" "O_Park"
	instance_create_layer(mouse_x, mouse_y, "Instances", O_Park);}