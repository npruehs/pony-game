use "lib:PonyGameNative"

use @Initialize[Bool]()
use @Render[Bool]()
use @Uninitialize[None]()

actor Main
  new create(env: Env) =>
    env.out.print("Initializing...")
    
    var frame: U64 = 1
    
    if @Initialize() then
      while @Render() do
        frame = frame + 1
      end
      
      @Uninitialize()
    end
     