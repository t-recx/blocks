require 'gosu'

class InputKeyHandler
	def initialize(keyboard_key, gamepad_key, milliseconds_until_next_keypress)
		@keyboard_key, @gamepad_key = keyboard_key, gamepad_key
		@milliseconds_until_next_keypress = milliseconds_until_next_keypress
		@last_pressed_milliseconds = 0
	end

	def pressed
		if Gosu::button_down? @keyboard_key or Gosu::button_down? @gamepad_key then
			return if (Gosu::milliseconds - @last_pressed_milliseconds).abs < @milliseconds_until_next_keypress

			@last_pressed_milliseconds = Gosu::milliseconds
			return true
		end

		@last_pressed_milliseconds = 0

		return false
	end
end

class Input
	def initialize(munkp)
		@munkp = munkp
		@drop_key_handler = InputKeyHandler.new(Gosu::KbSpace, Gosu::GpButton4, @munkp)
		@rotate_key_handler = InputKeyHandler.new(Gosu::KbUp, Gosu::GpButton0, @munkp)
		@down_key_handler = InputKeyHandler.new(Gosu::KbDown, Gosu::GpDown, @munkp)
		@left_key_handler = InputKeyHandler.new(Gosu::KbLeft, Gosu::GpLeft, @munkp)	
		@right_key_handler = InputKeyHandler.new(Gosu::KbRight, Gosu::GpRight, @munkp)
		@start_key_handler = InputKeyHandler.new(Gosu::KbReturn, Gosu::GpButton1, @munkp)
		@exit_key_handler = InputKeyHandler.new(Gosu::KbEscape, Gosu::GpButton3, @munkp)
	end

	def drop
		@drop_key_handler.pressed
	end

	def rotate 
		@rotate_key_handler.pressed
	end

	def down
		@down_key_handler.pressed
	end

	def left
		@left_key_handler.pressed	
	end

	def right
		@right_key_handler.pressed
	end

	def start
		@start_key_handler.pressed
	end

	def exit
		@exit_key_handler.pressed
	end
end
