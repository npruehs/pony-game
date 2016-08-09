use "collections"

class EventManager
  var _events: List[GameEvent]
  var _listeners: Map[String, List[EventListener]]
  
  new create() =>
    _events = List[GameEvent]
    _listeners = Map[String, List[EventListener]]
    
  fun ref process(): None =>
    while _events.size() > 0 do
      try
        var event = _events.shift()
        
        var listeners = _listener_list(event.event_type())
        
        for listener in listeners.values() do
          listener.notify(event)
        end
      end
    end
     
   fun ref push(event: GameEvent): None =>
     _events.push(event)
     
   fun ref add_listener(event_type: String, listener: EventListener): None =>
     _listener_list(event_type).push(listener)
   
   fun ref _listener_list(event_type: String): List[EventListener] =>
     try
       _listeners(event_type)
     else
       let listener_list = List[EventListener]
       _listeners(event_type) = listener_list
       listener_list
     end
     