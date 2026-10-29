//

//left_press = keyboard_check(ord("D"))
var left_press = keyboard_check(vk_left) || keyboard_check(ord("A"));
var right_press = keyboard_check(vk_right) ||keyboard_check(ord("D"));

var jump_press = keyboard_check_pressed(vk_space);
var jump_hold = keyboard_check(vk_space)
var down_press = keyboard_check(vk_down) || keyboard_check(ord("W"));
var up_press = keyboard_check(vk_up) || keyboard_check(ord("S"));

var x_move = (right_press - left_press) * player_xspeed;


if x_move != 0 {
		if (!jumping and !climbing) sprite_index = sprite_player_walk;
		image_xscale = sign(x_move);
}

if (x_move == 0 and !jumping and !climbing) sprite_index = sprite_player_idle;

move_and_collide(x_move, 0, o_wall);