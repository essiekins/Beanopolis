/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Down
/// @DnDVersion : 1.1
/// @DnDHash : 4ED3458E
var l4ED3458E_0;l4ED3458E_0 = mouse_check_button(mb_left);if (l4ED3458E_0){	/// @DnDAction : YoYo Games.Instances.Call_User_Event
	/// @DnDVersion : 1
	/// @DnDHash : 3B24F36B
	/// @DnDParent : 4ED3458E
	/// @DnDArgument : "event" "ev_gesture_drag_start"
	event_user(ev_gesture_drag_start);}

/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Released
/// @DnDVersion : 1.1
/// @DnDHash : 1B0A5E96
var l1B0A5E96_0;l1B0A5E96_0 = mouse_check_button_released(mb_left);if (l1B0A5E96_0){}

/// @DnDAction : YoYo Games.Instances.Call_User_Event
/// @DnDVersion : 1
/// @DnDHash : 4BADB644
/// @DnDArgument : "event" "ev_gesture_drag_end"
event_user(ev_gesture_drag_end);