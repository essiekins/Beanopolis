/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Down
/// @DnDVersion : 1.1
/// @DnDHash : 4D3C6603
var l4D3C6603_0;l4D3C6603_0 = mouse_check_button(mb_left);if (l4D3C6603_0){	/// @DnDAction : YoYo Games.Instances.Call_User_Event
	/// @DnDVersion : 1
	/// @DnDHash : 366AEA32
	/// @DnDParent : 4D3C6603
	/// @DnDArgument : "event" "ev_gesture_drag_start"
	event_user(ev_gesture_drag_start);}

/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Released
/// @DnDVersion : 1.1
/// @DnDHash : 6C8B99C5
var l6C8B99C5_0;l6C8B99C5_0 = mouse_check_button_released(mb_left);if (l6C8B99C5_0){}

/// @DnDAction : YoYo Games.Instances.Call_User_Event
/// @DnDVersion : 1
/// @DnDHash : 18922E32
/// @DnDArgument : "event" "ev_gesture_drag_end"
event_user(ev_gesture_drag_end);