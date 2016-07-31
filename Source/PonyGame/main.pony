use "lib:PonyGameNative"

use @Initialize[Bool](game_name: Pointer[U8] tag, width: I32, height: I32)
use @SetClearColor[None](red: F32, green: F32, blue: F32, alpha: F32)
use @CreateTextFormat[I32](font_name: Pointer[U8] tag, fontSize: F32, textAlignment: I32, paragraphAlignment: I32)
use @LoadImageResource[I32](file_name: Pointer[U8] tag)

use @BeginDraw[Bool]()
use @EndDraw[Bool]()

use @DPadUpPressed[Bool](user_index: I32)
use @DPadDownPressed[Bool](user_index: I32)
use @DPadLeftPressed[Bool](user_index: I32)
use @DPadRightPressed[Bool](user_index: I32)

use @RenderText[None](text: Pointer[U8] tag, x: F32, y: F32, text_format_id: I32, red: F32, green: F32, blue: F32, alpha: F32)
use @RenderImage[None](image_id: I32, x: F32, y: F32)

use @Uninitialize[None]()

actor Main
  new create(env: Env) =>
    env.out.print("Initializing...")
    
    var frame: U64 = 1
    var game_name': String = "TestGame"
    
    if @Initialize(game_name'.cstring(), 1024, 768) then
      @SetClearColor(0.0, 0.0, 0.0, 1.0)
      
      var font_name': String = "Verdana"
      var text_format_id': I32 = @CreateTextFormat(font_name'.cstring(), 50, 0, 0)
      var image_id': I32 = @LoadImageResource("pony.png".cstring())
      
      var renderSuccess: Bool = true
      
      var imageX: F32 = 100.0
      var imageY: F32 = 200.0
      
      while renderSuccess do
        renderSuccess = @BeginDraw()
        
        if renderSuccess then
          @RenderText("Hello world!".cstring(), F32.from[U64](frame % 1024), 100.0, text_format_id', 1.0, 1.0, 1.0, 1.0)
          
          if @DPadUpPressed(0) then
            imageY = imageY - 1
          end
          if @DPadDownPressed(0) then
            imageY = imageY + 1
          end
          if @DPadLeftPressed(0) then
            imageX = imageX - 1
          end
          if @DPadRightPressed(0) then
            imageX = imageX + 1
          end
          
          @RenderImage(image_id', imageX, imageY)
          frame = frame + 1
          
          renderSuccess = @EndDraw()
        end        
      end
      
      @Uninitialize()
    end
