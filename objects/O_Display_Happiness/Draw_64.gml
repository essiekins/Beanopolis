/// @DnDAction : YoYo Games.Drawing.Draw_Healthbar
/// @DnDVersion : 1
/// @DnDHash : 70706E49
/// @DnDArgument : "x1" "100"
/// @DnDArgument : "y1" "50"
/// @DnDArgument : "x2" "300"
/// @DnDArgument : "y2" "20"
/// @DnDArgument : "value" "global.Happiness/global.maxHappiness*100"
/// @DnDArgument : "backcol" "$FF264360"
/// @DnDArgument : "barcol" "$FF24FF19"
/// @DnDArgument : "mincol" "$FF4C4CFF"
/// @DnDArgument : "maxcol" "$FF59B259"
draw_healthbar(100, 50, 300, 20, global.Happiness/global.maxHappiness*100, $FF264360 & $FFFFFF, $FF4C4CFF & $FFFFFF, $FF59B259 & $FFFFFF, 0, (($FF264360>>24) != 0), (($FF24FF19>>24) != 0));

/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 44ACC097
/// @DnDArgument : "code" "/// @description Execute Code$(13_10)global.maxHappiness = 100;"
/// @description Execute Code
global.maxHappiness = 100;

/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
/// @DnDVersion : 1
/// @DnDHash : 006C2DB2
/// @DnDArgument : "x" "30"
/// @DnDArgument : "y" "220"
/// @DnDArgument : "caption" ""Happiness: ""
/// @DnDArgument : "text" "global.Purpose + global.Health + global.Recreation/global.maxHappiness*100"
draw_text_transformed(30, 220, string("Happiness: ") + string(global.Purpose + global.Health + global.Recreation/global.maxHappiness*100), 1, 1, 0);