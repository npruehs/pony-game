class FpsCounter
  let _clock: GameClock
  
  let _tick_buffer_size: USize
  let _tick_buffer: Array[U64]
  
  var _tick_index: USize
  var _tick_sum: U64
  var _last_tick_time: U64
  
  
  new create(clock: GameClock) =>
    _clock = clock
    
    _tick_index = 0
    _tick_sum = 0
    _tick_buffer_size = 60
    _tick_buffer = Array[U64].init(0, _tick_buffer_size)
    _last_tick_time = 0
    
    
  fun ref add_tick(): U64 =>
    // Compute elapsed tick time.
    let time: U64 = _clock.elapsed_millis()
    let tick_time: U64 = time - _last_tick_time
    _last_tick_time = time
  
    // Compute average frame time, based on
    // http://stackoverflow.com/a/87732/1700174
    try
        // Subtract oldest buffered value.
        _tick_sum = _tick_sum - _tick_buffer(_tick_index)
        
        // Add new value.
        _tick_sum = _tick_sum + tick_time
        
        // Buffer new value.
        _tick_buffer(_tick_index) = tick_time
        
        // Increase buffer index.
        _tick_index = _tick_index + 1
        
        if (_tick_index == _tick_buffer_size) then
        _tick_index = 0
        end
        
        // Return tick time.
        tick_time
    else
      // Can never happen, buffer size always applied correctly.
      0
    end
    
  fun frame_time(): U64 =>
    _tick_sum / U64.from[USize](_tick_buffer_size)

  fun fps(): F64 =>
    1000.0 / F64.from[U64](frame_time())