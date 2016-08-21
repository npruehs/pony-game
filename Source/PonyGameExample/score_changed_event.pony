use "ponygame"

class ScoreChangedEvent is GameEvent
  var score: I32

  new create(score': I32) =>
    score = score'

  fun event_type(): String =>
    "ScoreChangedEvent"
