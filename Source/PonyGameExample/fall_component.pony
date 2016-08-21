use "ponygame"

class FallComponent is EntityComponent
  var last_fall_time: U64
  
  
  new create() =>
    last_fall_time = 0
    
    
  fun component_type(): String =>
    "FallComponent"