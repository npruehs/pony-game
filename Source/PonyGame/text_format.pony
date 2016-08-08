use "collections"

class val TextFormat is (Hashable & Equatable[TextFormat box])
  let _font_name: String
  let _font_size: F32
  let _horizontal_alignment: HorizontalAlignment
  let _vertical_alignment: VerticalAlignment
  
  new val create(font_name: String, font_size: F32, horizontal_alignment: HorizontalAlignment, vertical_alignment: VerticalAlignment) =>
    _font_name = font_name
    _font_size = font_size
    _horizontal_alignment = horizontal_alignment
    _vertical_alignment = vertical_alignment
  
  fun hash(): U64 val =>
    var hash_code = _font_name.hash()
    hash_code = (hash_code * 397) xor _font_size.u64()
    hash_code = (hash_code * 397) xor _horizontal_alignment().u64()
    hash_code = (hash_code * 397) xor _vertical_alignment().u64()
    hash_code
    
  fun eq(that: TextFormat box): Bool =>
    _font_name.eq(that._font_name) and
    _font_size.eq(that._font_size) and
    _horizontal_alignment().eq(that._horizontal_alignment()) and
    _vertical_alignment().eq(that._vertical_alignment())

 
type HorizontalAlignment is
  ( HorizontalAlignmentLeft
  | HorizontalAlignmentRight
  | HorizontalAlignmentCenter
  | HorizontalAlignmentJustified
  )

primitive HorizontalAlignmentLeft
  fun apply(): I32 => 0

primitive HorizontalAlignmentRight
  fun apply(): I32 => 1

primitive HorizontalAlignmentCenter
  fun apply(): I32 => 2

primitive HorizontalAlignmentJustified
  fun apply(): I32 => 3


type VerticalAlignment is
  ( VerticalAlignmentLeft
  | VerticalAlignmentRight
  | VerticalAlignmentCenter
  )

primitive VerticalAlignmentLeft
  fun apply(): I32 => 0

primitive VerticalAlignmentRight
  fun apply(): I32 => 1

primitive VerticalAlignmentCenter
  fun apply(): I32 => 2
