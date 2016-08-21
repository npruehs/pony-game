use @DPadUpPressed[Bool](user_index: I32)
use @DPadDownPressed[Bool](user_index: I32)
use @DPadLeftPressed[Bool](user_index: I32)
use @DPadRightPressed[Bool](user_index: I32)
use @StartButtonPressed[Bool](user_index: I32)
use @BackButtonPressed[Bool](user_index: I32)
use @LeftThumbPressed[Bool](user_index: I32)
use @RightThumbPressed[Bool](user_index: I32)
use @LeftShoulderButtonPressed[Bool](user_index: I32)
use @RightShoulderButtonPressed[Bool](user_index: I32)
use @ButtonAPressed[Bool](user_index: I32)
use @ButtonBPressed[Bool](user_index: I32)
use @ButtonXPressed[Bool](user_index: I32)
use @ButtonYPressed[Bool](user_index: I32)

use @GetLeftTrigger[F32](user_index: I32)
use @GetRightTrigger[F32](user_index: I32)
use @GetLeftThumbX[F32](user_index: I32)
use @GetLeftThumbY[F32](user_index: I32)
use @GetRightThumbX[F32](user_index: I32)
use @GetRightThumbY[F32](user_index: I32)

use @SetVibration[None](user_index: I32, left_motor_speed: F32, right_motor_speed: F32)


class Input
  let _user_count: USize
  
  var _dpad_up_pressed_last_frame: Array[Bool]
  var _dpad_down_pressed_last_frame: Array[Bool]
  var _dpad_left_pressed_last_frame: Array[Bool]
  var _dpad_right_pressed_last_frame: Array[Bool]
  var _start_button_pressed_last_frame: Array[Bool]
  var _back_button_pressed_last_frame: Array[Bool]
  var _left_thumb_pressed_last_frame: Array[Bool]
  var _right_thumb_pressed_last_frame: Array[Bool]
  var _left_shoulder_button_pressed_last_frame: Array[Bool]
  var _right_shoulder_button_pressed_last_frame: Array[Bool]
  var _button_a_pressed_last_frame: Array[Bool]
  var _button_b_pressed_last_frame: Array[Bool]
  var _button_x_pressed_last_frame: Array[Bool]
  var _button_y_pressed_last_frame: Array[Bool]
  
  var _dpad_up_pressed: Array[Bool]
  var _dpad_down_pressed: Array[Bool]
  var _dpad_left_pressed: Array[Bool]
  var _dpad_right_pressed: Array[Bool]
  var _start_button_pressed: Array[Bool]
  var _back_button_pressed: Array[Bool]
  var _left_thumb_pressed: Array[Bool]
  var _right_thumb_pressed: Array[Bool]
  var _left_shoulder_button_pressed: Array[Bool]
  var _right_shoulder_button_pressed: Array[Bool]
  var _button_a_pressed: Array[Bool]
  var _button_b_pressed: Array[Bool]
  var _button_x_pressed: Array[Bool]
  var _button_y_pressed: Array[Bool]

  new create() =>
    _user_count = 4
    
    _dpad_up_pressed_last_frame = Array[Bool].init(false, _user_count)
    _dpad_down_pressed_last_frame = Array[Bool].init(false, _user_count)
    _dpad_left_pressed_last_frame = Array[Bool].init(false, _user_count)
    _dpad_right_pressed_last_frame = Array[Bool].init(false, _user_count)
    _start_button_pressed_last_frame = Array[Bool].init(false, _user_count)
    _back_button_pressed_last_frame = Array[Bool].init(false, _user_count)
    _left_thumb_pressed_last_frame = Array[Bool].init(false, _user_count)
    _right_thumb_pressed_last_frame = Array[Bool].init(false, _user_count)
    _left_shoulder_button_pressed_last_frame = Array[Bool].init(false, _user_count)
    _right_shoulder_button_pressed_last_frame = Array[Bool].init(false, _user_count)
    _button_a_pressed_last_frame = Array[Bool].init(false, _user_count)
    _button_b_pressed_last_frame = Array[Bool].init(false, _user_count)
    _button_x_pressed_last_frame = Array[Bool].init(false, _user_count)
    _button_y_pressed_last_frame = Array[Bool].init(false, _user_count)
    
    _dpad_up_pressed = Array[Bool].init(false, _user_count)
    _dpad_down_pressed = Array[Bool].init(false, _user_count)
    _dpad_left_pressed = Array[Bool].init(false, _user_count)
    _dpad_right_pressed = Array[Bool].init(false, _user_count)
    _start_button_pressed = Array[Bool].init(false, _user_count)
    _back_button_pressed = Array[Bool].init(false, _user_count)
    _left_thumb_pressed = Array[Bool].init(false, _user_count)
    _right_thumb_pressed = Array[Bool].init(false, _user_count)
    _left_shoulder_button_pressed = Array[Bool].init(false, _user_count)
    _right_shoulder_button_pressed = Array[Bool].init(false, _user_count)
    _button_a_pressed = Array[Bool].init(false, _user_count)
    _button_b_pressed = Array[Bool].init(false, _user_count)
    _button_x_pressed = Array[Bool].init(false, _user_count)
    _button_y_pressed = Array[Bool].init(false, _user_count)


  fun ref tick(): None =>
    var user_index: USize = 0
    
    try
      while (user_index < _user_count) do
        _dpad_up_pressed_last_frame(user_index) = _dpad_up_pressed(user_index)
        _dpad_down_pressed_last_frame(user_index) = _dpad_down_pressed(user_index)
        _dpad_left_pressed_last_frame(user_index) = _dpad_left_pressed(user_index)
        _dpad_right_pressed_last_frame(user_index) = _dpad_right_pressed(user_index)
        _start_button_pressed_last_frame(user_index) = _start_button_pressed(user_index)
        _back_button_pressed_last_frame(user_index) = _back_button_pressed(user_index)
        _left_thumb_pressed_last_frame(user_index) = _left_thumb_pressed(user_index)
        _right_thumb_pressed_last_frame(user_index) = _right_thumb_pressed(user_index)
        _left_shoulder_button_pressed_last_frame(user_index) = _left_shoulder_button_pressed(user_index)
        _right_shoulder_button_pressed_last_frame(user_index) = _right_shoulder_button_pressed(user_index)
        _button_a_pressed_last_frame(user_index) = _button_a_pressed(user_index)
        _button_b_pressed_last_frame(user_index) = _button_b_pressed(user_index)
        _button_x_pressed_last_frame(user_index) = _button_x_pressed(user_index)
        _button_y_pressed_last_frame(user_index) = _button_y_pressed(user_index)
        
        _dpad_up_pressed(user_index) = @DPadUpPressed(user_index.i32())
        _dpad_down_pressed(user_index) = @DPadDownPressed(user_index.i32())
        _dpad_left_pressed(user_index) = @DPadLeftPressed(user_index.i32())
        _dpad_right_pressed(user_index) = @DPadRightPressed(user_index.i32())
        _start_button_pressed(user_index) = @StartButtonPressed(user_index.i32())
        _back_button_pressed(user_index) = @BackButtonPressed(user_index.i32())
        _left_thumb_pressed(user_index) = @LeftThumbPressed(user_index.i32())
        _right_thumb_pressed(user_index) = @RightThumbPressed(user_index.i32())
        _left_shoulder_button_pressed(user_index) = @LeftShoulderButtonPressed(user_index.i32())
        _right_shoulder_button_pressed(user_index) = @RightShoulderButtonPressed(user_index.i32())
        _button_a_pressed(user_index) = @ButtonAPressed(user_index.i32())
        _button_b_pressed(user_index) = @ButtonBPressed(user_index.i32())
        _button_x_pressed(user_index) = @ButtonXPressed(user_index.i32())
        _button_y_pressed(user_index) = @ButtonYPressed(user_index.i32())

        user_index = user_index + 1
      end
    end      

  fun dpad_up_pressed(user_index: I32): Bool =>
    try _dpad_up_pressed(user_index.usize()) else false end

  fun dpad_up_just_pressed(user_index: I32): Bool =>
    try _dpad_up_pressed(user_index.usize()) and (not _dpad_up_pressed_last_frame(user_index.usize())) else false end
    
  fun dpad_up_just_released(user_index: I32): Bool =>
    try (not _dpad_up_pressed(user_index.usize())) and _dpad_up_pressed_last_frame(user_index.usize()) else false end
    
    
  fun dpad_down_pressed(user_index: I32): Bool =>
    try _dpad_down_pressed(user_index.usize()) else false end
    
  fun dpad_down_just_pressed(user_index: I32): Bool =>
    try _dpad_down_pressed(user_index.usize()) and (not _dpad_down_pressed_last_frame(user_index.usize())) else false end
    
  fun dpad_down_just_released(user_index: I32): Bool =>
    try (not _dpad_down_pressed(user_index.usize())) and _dpad_down_pressed_last_frame(user_index.usize()) else false end
    
    
  fun dpad_left_pressed(user_index: I32): Bool =>
    try _dpad_left_pressed(user_index.usize()) else false end
    
  fun dpad_left_just_pressed(user_index: I32): Bool =>
    try _dpad_left_pressed(user_index.usize()) and (not _dpad_left_pressed_last_frame(user_index.usize())) else false end
    
  fun dpad_left_just_released(user_index: I32): Bool =>
    try (not _dpad_left_pressed(user_index.usize())) and _dpad_left_pressed_last_frame(user_index.usize()) else false end
    
    
  fun dpad_right_pressed(user_index: I32): Bool =>
    try _dpad_right_pressed(user_index.usize()) else false end
    
  fun dpad_right_just_pressed(user_index: I32): Bool =>
    try _dpad_right_pressed(user_index.usize()) and (not _dpad_right_pressed_last_frame(user_index.usize())) else false end
    
  fun dpad_right_just_released(user_index: I32): Bool =>
    try (not _dpad_right_pressed(user_index.usize())) and _dpad_right_pressed_last_frame(user_index.usize()) else false end
    
    
  fun start_button_pressed(user_index: I32): Bool =>
    try _start_button_pressed(user_index.usize()) else false end
    
  fun start_button_just_pressed(user_index: I32): Bool =>
    try _start_button_pressed(user_index.usize()) and (not _start_button_pressed_last_frame(user_index.usize())) else false end
    
  fun start_button_just_released(user_index: I32): Bool =>
    try (not _start_button_pressed(user_index.usize())) and _start_button_pressed_last_frame(user_index.usize()) else false end
    
    
  fun back_button_pressed(user_index: I32): Bool =>
    try _back_button_pressed(user_index.usize()) else false end
    
  fun back_button_just_pressed(user_index: I32): Bool =>
    try _back_button_pressed(user_index.usize()) and (not _back_button_pressed_last_frame(user_index.usize())) else false end
    
  fun back_button_just_released(user_index: I32): Bool =>
    try (not _back_button_pressed(user_index.usize())) and _back_button_pressed_last_frame(user_index.usize()) else false end
    
    
  fun left_thumb_pressed(user_index: I32): Bool =>
    try _left_thumb_pressed(user_index.usize()) else false end
    
  fun left_thumb_just_pressed(user_index: I32): Bool =>
    try _left_thumb_pressed(user_index.usize()) and (not _left_thumb_pressed_last_frame(user_index.usize())) else false end
    
  fun left_thumb_just_released(user_index: I32): Bool =>
    try (not _left_thumb_pressed(user_index.usize())) and _left_thumb_pressed_last_frame(user_index.usize()) else false end
    
    
  fun right_thumb_pressed(user_index: I32): Bool =>
    try _right_thumb_pressed(user_index.usize()) else false end
    
  fun right_thumb_just_pressed(user_index: I32): Bool =>
    try _right_thumb_pressed(user_index.usize()) and (not _right_thumb_pressed_last_frame(user_index.usize())) else false end
    
  fun right_thumb_just_released(user_index: I32): Bool =>
    try (not _right_thumb_pressed(user_index.usize())) and _right_thumb_pressed_last_frame(user_index.usize()) else false end
    
    
  fun left_shoulder_button_pressed(user_index: I32): Bool =>
    try _left_shoulder_button_pressed(user_index.usize()) else false end
    
  fun left_shoulder_button_just_pressed(user_index: I32): Bool =>
    try _left_shoulder_button_pressed(user_index.usize()) and (not _left_shoulder_button_pressed_last_frame(user_index.usize())) else false end
    
  fun left_shoulder_button_just_released(user_index: I32): Bool =>
    try (not _left_shoulder_button_pressed(user_index.usize())) and _left_shoulder_button_pressed_last_frame(user_index.usize()) else false end
    
    
  fun right_shoulder_button_pressed(user_index: I32): Bool =>
    try _right_shoulder_button_pressed(user_index.usize()) else false end

  fun right_shoulder_button_just_pressed(user_index: I32): Bool =>
    try _right_shoulder_button_pressed(user_index.usize()) and (not _right_shoulder_button_pressed_last_frame(user_index.usize())) else false end
    
  fun right_shoulder_button_just_released(user_index: I32): Bool =>
    try (not _right_shoulder_button_pressed(user_index.usize())) and _right_shoulder_button_pressed_last_frame(user_index.usize()) else false end
    
    
  fun button_a_pressed(user_index: I32): Bool =>
    try _button_a_pressed(user_index.usize()) else false end
    
  fun button_a_just_pressed(user_index: I32): Bool =>
    try _button_a_pressed(user_index.usize()) and (not _button_a_pressed_last_frame(user_index.usize())) else false end
    
  fun button_a_just_released(user_index: I32): Bool =>
    try (not _button_a_pressed(user_index.usize())) and _button_a_pressed_last_frame(user_index.usize()) else false end
    
    
  fun button_b_pressed(user_index: I32): Bool =>
    try _button_b_pressed(user_index.usize()) else false end
    
  fun button_b_just_pressed(user_index: I32): Bool =>
    try _button_b_pressed(user_index.usize()) and (not _button_b_pressed_last_frame(user_index.usize())) else false end
    
  fun button_b_just_released(user_index: I32): Bool =>
    try (not _button_b_pressed(user_index.usize())) and _button_b_pressed_last_frame(user_index.usize()) else false end
    
    
  fun button_x_pressed(user_index: I32): Bool =>
    try _button_x_pressed(user_index.usize()) else false end
    
  fun button_x_just_pressed(user_index: I32): Bool =>
    try _button_x_pressed(user_index.usize()) and (not _button_x_pressed_last_frame(user_index.usize())) else false end
    
  fun button_x_just_released(user_index: I32): Bool =>
    try (not _button_x_pressed(user_index.usize())) and _button_x_pressed_last_frame(user_index.usize()) else false end
    
    
  fun button_y_pressed(user_index: I32): Bool =>
    try _button_y_pressed(user_index.usize()) else false end
    
  fun button_y_just_pressed(user_index: I32): Bool =>
    try _button_y_pressed(user_index.usize()) and (not _button_y_pressed_last_frame(user_index.usize())) else false end
    
  fun button_y_just_released(user_index: I32): Bool =>
    try (not _button_y_pressed(user_index.usize())) and _button_y_pressed_last_frame(user_index.usize()) else false end
    
    
  fun get_left_trigger(user_index: I32): F32 =>
    @GetLeftTrigger(user_index)
    
  fun get_right_trigger(user_index: I32): F32 =>
    @GetRightTrigger(user_index)
    
    
  fun get_left_thumb_x(user_index: I32): F32 =>
    @GetLeftThumbX(user_index)
    
  fun get_left_thumb_y(user_index: I32): F32 =>
    @GetLeftThumbY(user_index)
    
  fun get_right_thumb_x(user_index: I32): F32 =>
    @GetRightThumbX(user_index)
    
  fun get_right_thumb_y(user_index: I32): F32 =>
    @GetRightThumbY(user_index)
    
    
  fun set_vibration(user_index: I32, left_motor_speed: F32, right_motor_speed: F32): None =>
    @SetVibration(user_index, left_motor_speed, right_motor_speed)
