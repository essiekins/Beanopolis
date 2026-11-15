/// @DnDAction : YoYo Games.Collisions.If_Object_At
/// @DnDVersion : 1.1
/// @DnDHash : 17F276CE
/// @DnDArgument : "x" "850"
/// @DnDArgument : "y" "360"
/// @DnDArgument : "object" "O_Home"
/// @DnDSaveInfo : "object" "O_Home"
var l17F276CE_0 = instance_place(850, 360, [O_Home]);if ((l17F276CE_0 > 0)){	/// @DnDAction : YoYo Games.Movement.Snap_Position
	/// @DnDVersion : 1
	/// @DnDHash : 3A8BD0F9
	/// @DnDParent : 17F276CE
	/// @DnDArgument : "xsnap" "64"
	/// @DnDArgument : "ysnap" "64"
	move_snap(64, 64);}