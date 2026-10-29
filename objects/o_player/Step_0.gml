//

var left_press = keyboard_check(vk_left) || keyboard_check(ord("A"));
var right_press = keyboard_check(vk_right) ||keyboard_check(ord("D"));

var jump_press = keyboard_check_pressed(vk_space);
var jump_hold = keyboard_check(vk_space)
var down_press = keyboard_check(vk_down) || keyboard_check(ord("W"));
var up_press = keyboard_check(vk_up) || keyboard_check(ord("S"));

var x_move = (right_press - left_press) * player_xspeed;

// Apply gravity and limit fall speed:
player_yspeed += player_gravity;


if x_move != 0 {
		if (!jumping and !climbing) sprite_index = sprite_player_walk;
		image_xscale = sign(x_move);
}

if (x_move == 0 and !jumping and !climbing) sprite_index = sprite_player_idle;


// Vertical Movement
var one_way_obj = instance_place(x, y + player_yspeed, o_wall_oneway);
var top_of_one_way = one_way_obj != noone && self.bbox_bottom <= one_way_obj.bbox_top+1;

if place_meeting(x, y + player_yspeed, o_wall) or place_meeting(x, y + player_yspeed, o_wall_oneway) && top_of_one_way && !down_press {
	player_yspeed = 0;
	if jumping sprite_index = sprite_player_land_jump;
}

if !climbing {
	move_and_collide(0, player_yspeed, o_wall, 4, 0, 0, 0, player_max_fall_speed);
	move_and_collide(x_move, 0, o_wall);
}



// Jumping:
if jump_press && (place_meeting(x, y + 1, o_wall) or place_meeting(x, y + 1, o_wall_oneway)) {
	player_yspeed = player_jump_speed;
	image_index = 0;
	jumping = true;
	sprite_index = sprite_player_jump;
}

// Soft jump:
if jumping && !jump_held && player_yspeed < 0 {
	player_yspeed *= 0.5	
}