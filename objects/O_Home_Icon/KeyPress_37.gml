/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 48BCB399
/// @DnDArgument : "expr" "cursor_sprite"
if(cursor_sprite){	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 6CC9404C
	/// @DnDParent : 48BCB399
	/// @DnDArgument : "xpos" "mouse_x"
	/// @DnDArgument : "ypos" "mouse_y"
	/// @DnDArgument : "var" "cursor_sprite"
	/// @DnDArgument : "objectid" "S_Home"
	/// @DnDSaveInfo : "objectid" "S_Home"
	cursor_sprite = instance_create_layer(mouse_x, mouse_y, "Instances", S_Home);}