/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 1435838E
/// @DnDArgument : "expr" "S_Home_img"
/// @DnDArgument : "var" "cursor_sprite"
cursor_sprite = S_Home_img;

/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 6B9AEDA0
/// @DnDArgument : "expr" "cursor_sprite == S_Home_img && mb_left"
if(cursor_sprite == S_Home_img && mb_left){	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 57FB3FA2
	/// @DnDParent : 6B9AEDA0
	/// @DnDArgument : "xpos" "mouse_x"
	/// @DnDArgument : "ypos" "mouse_y"
	/// @DnDArgument : "objectid" "O_Home"
	/// @DnDSaveInfo : "objectid" "O_Home"
	instance_create_layer(mouse_x, mouse_y, "Instances", O_Home);}