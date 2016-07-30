use "lib:PonyGameNative"

use @Initialize[Bool](game_name: Pointer[U8] tag, width: I32, height: I32)
use @SetClearColor[None](red: F32, green: F32, blue: F32, alpha: F32)
use @CreateTextFormat[I32](font_name: Pointer[U8] tag, fontSize: F32, textAlignment: I32, paragraphAlignment: I32)
use @Render[Bool]()
use @RenderText[None](text: Pointer[U8] tag, x: F32, y: F32, textFormatId: I32, red: F32, green: F32, blue: F32, alpha: F32)
use @Uninitialize[None]()

actor Main
  new create(env: Env) =>
    env.out.print("Initializing...")
    
    var frame: U64 = 1
    var game_name': String = "TestGame"
    
    if @Initialize(game_name'.cstring(), 1024, 768) then
      @SetClearColor(0.0, 0.0, 0.0, 1.0)
      
      var font_name': String = "Verdana"
      var textFormatId: I32 = @CreateTextFormat(font_name'.cstring(), 50, 0, 0)
      
      while @Render() do
        @RenderText("Hello world!".cstring(), 100.0, 100.0, textFormatId, 1.0, 1.0, 1.0, 1.0)
        frame = frame + 1
      end
      
      @Uninitialize()
    end
