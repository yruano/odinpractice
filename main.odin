package main

import "core:fmt"
import "core:strings"
import "core:os"
import "core:io"

main :: proc() {
  a := make([]int, 6);           // len(a) == 6
  b := make([dynamic]int, 6);    // len(b) == 6, cap(b) == 6
  c := make([dynamic]int, 0, 6); // len(c) == 0, cap(c) == 6
  fmt.println(a);
  fmt.println(b);
  fmt.println(c);
  //fmt.println(cap(a)); // cap 동적 배열에만 있음
  fmt.println(len(a));  // 6
  fmt.println(len(b));  // 6
  fmt.println(len(c));  // 0
  fmt.println(cap(b));  // 6
  fmt.println(cap(c));  // 6
  delete(b);
  delete(c);
  fmt.println(a);
  fmt.println(b);       
  fmt.println(c);       // []
  fmt.println(cap(b));  // 6
  fmt.println(cap(c));  // 6
  fmt.println(len(b));  // 6
  fmt.println(len(c));  // 0


  Direction :: enum{North, East, South, West}
  fmt.println(Direction.North)
  fmt.println(int(Direction.North))


  Fod :: enum {
	  A,
  	B = 4, // Holes are valid
	  C = 7,
	  D = 1337,
  }
  fmt.println(Fod.B)
  fmt.println(int(Fod.B))

  Foc :: enum u8 {A, B, C} // Foo will only be 8 bits
  fmt.println(Foc.A)
  fmt.println(u8(Foc.A))

  Foo :: enum {A, B, C}

  f: Foo
  f = .A
  //f = .B
  //f = .C

  BAR :: bit_set[Foo]{.B, .C}
  
  switch f {
  case .A:
	  fmt.println("foo")
  case .B:
	  fmt.println("bar")
  case .C:
	  fmt.println("baz")
  }

  Foo :: enum {A, B, C}
	using Foo
	a := A
  b := B
  c := C

  fmt.println(a)
  fmt.println(b)
  fmt.println(c)
  
  // 안됨 하지마
  using Bar :: enum {X, Y, Z}
	x := X

  // using이 범위를 오염시킴
  Direction :: enum{North, East, South, West}
  d: Direction
  d = Direction.East
  d = .East


  i := 123
  p := &i
  fmt.println(i)
  fmt.println(p)
  fmt.println(p^) // read  i through the pointer p
  p^ = 1337;       // write i through the pointer p
  fmt.println(i)
  fmt.println(p^)


  Vector2 :: struct {
	x: f32,
	y: f32,
  }
  v := Vector2{1, 2}
  v.x = 4
  fmt.println(v.x)
  p := &v
  fmt.println(p)
  p.x = 1335
  fmt.println(v)
  fmt.println(p)
  Vector3 :: struct {
	x, y, z: f32,
  }
  vc: Vector3
  vc = Vector3{} // Zero value
  vc = Vector3{9, 9, 1}   // 새로운 Vevtor을 선언함
  vc = Vector3{z=1, y=2}  // 새로운 Vevtor을 선언함 {x = 0, y = 2, z = 1}
  fmt.println(vc.x)
  fmt.println(vc.y)
  fmt.println(vc.z)
  assert(vc.x == 0)
  assert(vc.y == 2)
  assert(vc.z == 1)


    // read
  input_builder := read_from_stdin()
  defer strings.destroy_builder(&input_builder)

  fmt.println(strings.to_string(input_builder))
}

read_from_stdin :: proc() -> strings.Builder {
  stdin_stream := os.stream_from_handle(os.stdin)
  stdin_reader := io.to_byte_reader(stdin_stream)
  input_builder := strings.make_builder_none()

  b : byte
  err : io.Error

  for {
    b, err = io.read_byte(stdin_reader)
    if b == '\n' || err != .None { break }
    strings.write_byte(&input_builder, b)
  }

  return input_builder
}