use "lib:PonyGameNative"

use @Initialize[Bool](game_name: Pointer[U8] tag, width: I32, height: I32)
use @SetClearColor[None](red: F32, green: F32, blue: F32, alpha: F32)
use @Render[Bool]()
use @Uninitialize[None]()

actor Main
  new create(env: Env) =>
    env.out.print("Initializing...")
    
    var frame: U64 = 1
    var name: String = "TestGame"
    
    if @Initialize(name.cstring(), 1024, 768) then
      @SetClearColor(0.0, 0.0, 0.0, 0.0)
      
      while @Render() do  
        frame = frame + 1
      end
      
      @Uninitialize()
    end
