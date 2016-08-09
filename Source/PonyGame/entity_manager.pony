use "collections"

class EntityManager
  var _components: Map[String, Map[U64, EntityComponent]]
  var _next_id: U64
  var _killed: List[U64]
  
  new create() =>
    _components = Map[String, Map[U64, EntityComponent]]
    _next_id = 1
    _killed = List[U64]
    
  fun ref create_entity(): U64 =>
    _next_id = _next_id + 1
    
  fun ref add_component(entity_id: U64, entity_component: EntityComponent) =>
      var map = _component_map(entity_component.component_type())
      map(entity_id) = entity_component

  fun ref get_component(entity_id: U64, component_type: String): EntityComponent ? =>
    var map = _component_map(component_type)
    
    try
      map(entity_id)
    else
      error
    end
  
  fun ref kill(entity_id: U64) =>
    _killed.push(entity_id)
    
  fun ref cleanup(): None =>
    while _killed.size() > 0 do
      try
        var entity_id = _killed.pop()
      
        for component_type in _components.keys() do
          var map = _components(component_type)
        
          try
            map.remove(entity_id)
          end
        end
      end
    end

  fun ref _component_map(component_type: String): Map[U64, EntityComponent] =>
    try
      _components(component_type)
    else
      let map = Map[U64, EntityComponent]
      _components.add(component_type, map)
      map
    end
