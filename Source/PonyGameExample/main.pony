use "lib:PonyGameNative"

use "ponygame"

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

use @RenderText[None](text: Pointer[U8] tag, x: F32, y: F32, text_format_id: I32, red: F32, green: F32, blue: F32, alpha: F32)
use @RenderImage[None](image_id: I32, x: F32, y: F32)

use @Uninitialize[None]()

actor Main
  new create(env: Env) =>
    let game = Game(env)
    game.init()
    
    var game_name': String = "TestGame"
    
    // Initialize window.
    if @Initialize(game_name'.cstring(), 1024, 768) then
      @SetClearColor(0.0, 0.0, 0.0, 1.0)
      
      var font_name': String = "Verdana"
      var big_text_format_id: I32 = @CreateTextFormat(font_name'.cstring(), 32, 0, 0)
      var small_text_format_id: I32 = @CreateTextFormat(font_name'.cstring(), 16, 0, 0)
      var image_id': I32 = @LoadImageResource("pony.png".cstring())
      
      var renderSuccess: Bool = true
      
      var imageX: F32 = 100.0
      var imageY: F32 = 300.0
      
      while renderSuccess do
        // Handle input.
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
        
        if @StartButtonPressed(0) then
          env.out.print("Start pressed!")
        end
        if @BackButtonPressed(0) then
          env.out.print("Back pressed!")
        end
        if @LeftThumbPressed(0) then
          env.out.print("Left thumb pressed!")
        end
        if @RightThumbPressed(0) then
          env.out.print("Right thumb pressed!")
        end
        if @LeftShoulderButtonPressed(0) then
          env.out.print("Left shoulder button pressed!")
        end
        if @RightShoulderButtonPressed(0) then
          env.out.print("Right shoulder button pressed!")
        end
            
        if @ButtonAPressed(0) then
          env.out.print("A pressed!")
        end
        if @ButtonBPressed(0) then
          env.out.print("B pressed!")
        end
        if @ButtonXPressed(0) then
          env.out.print("X pressed!")
        end
        if @ButtonYPressed(0) then
          env.out.print("Y pressed!")
        end
        
        if @GetLeftTrigger(0) > 0 then
          env.out.print("Left trigger value: " + @GetLeftTrigger(0).string())
        end
        if @GetRightTrigger(0) > 0 then
          env.out.print("Right trigger value: " + @GetRightTrigger(0).string())
        end
        
        imageX = imageX + @GetLeftThumbX(0)
        imageY = imageY + @GetLeftThumbY(0)
        
        imageX = imageX + @GetRightThumbX(0)
        imageY = imageY + @GetRightThumbY(0)  
        
        // Draw.
        renderSuccess = @BeginDraw()
        
        if renderSuccess then
          
          // Show elapsed time.
          let elapsed_millis = game.clock().elapsed_millis()
          let elapsed_seconds = elapsed_millis / 1000
          let time_string = "Time: " + elapsed_seconds.string() + "." + (elapsed_millis % 1000).string()
          
          @RenderText(time_string.cstring(), 10.0, 10.0, small_text_format_id, 1.0, 1.0, 1.0, 1.0)
          
          // Show FPS.
          let fps_string = "FPS: " + game.fps_counter().fps().string()
          @RenderText(fps_string.cstring(), 10.0, 30.0, small_text_format_id, 1.0, 1.0, 1.0, 1.0)
          
          let frame_time_string = "Frame Time: " + game.fps_counter().frame_time().string() + " ms"
          @RenderText(frame_time_string.cstring(), 10.0, 50.0, small_text_format_id, 1.0, 1.0, 1.0, 1.0)
          
          // Show moving text. 
          @RenderText("Hello world!".cstring(), F32.from[U64](game.frame() % 1024), 150.0, big_text_format_id, 1.0, 1.0, 1.0, 1.0)
          
          // Show pony.
          @RenderImage(image_id', imageX, imageY)
          
          // Tick game.
          game.tick()
          game.fps_counter().add_tick()
          
          renderSuccess = @EndDraw()
        end        
      end
      
      // Shutdown.
      @Uninitialize()
    end
