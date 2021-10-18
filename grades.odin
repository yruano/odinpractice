package main

import "core:fmt"
import "core:os"
import "core:io"
import "core:strings"
import "core:intrinsics"
import "core:mem"
import "core:strconv"
import "core:unicode/utf8"
import "core:bytes"

main :: proc() {
  fmt.printf("점수 입력 : ")
  input_builder := read_from_stdin()
  defer strings.destroy_builder(&input_builder)

  input := strings.to_string(input_builder)
  
  grades := Grades(input)
}

Grades :: proc(input : string) -> f32 {
  syn_num := [3]int{0, 0, 0}
  com_num := 0
  sum_num := 0
  gra : string
  l := -1
  n := 0
  
  mix_arr :: 3
  cur_arr := 0
  for ch in input {
    cl_num := strings.index_rune(" 0123456789", ch) - 1

    if ch == ' ' {
      cur_arr = 0
      l = -1
      n += 1
      continue
    }

    cur_arr += 1
    if cur_arr <= mix_arr {
      if cl_num >= 0 {
        l += 1
        syn_num[l] = cl_num
        if cur_arr == 1 { 
          com_num = syn_num[l]
          //sum_num += com_num
          fmt.println(sum_num)
        }
        if cur_arr == 2 { 
          com_num = (syn_num[0] * 10) + syn_num[1]
          //sum_num += com_num
          fmt.println(sum_num)
        }
        if cur_arr == 3 { 
          com_num = (syn_num[0] * 10 * 10) + (syn_num[1] * 10) + syn_num[2]
          //sum_num += com_num
          fmt.println(sum_num)
        }
        sum_num += com_num
      }
    } else {
      fmt.println("3자리수 까지 입력 가능합니다")
      break
    }
    
    if cl_num == '\n'{ fmt.println("ehla") }
    if cl_num < 0 {
      fmt.println("숫자가 아닙니다")
      break
    }

    if com_num >= 50 {
      switch {
        case com_num >= 90 : gra = "A 학점입니다."
        
        case com_num >= 80 : gra = "B 학점입니다."
      
        case com_num >= 70 : gra = "C 학점입니다."
      
        case com_num >= 60 : gra = "D 학점입니다."
      
        case com_num >= 50 : gra = "F 학점입니다."
      }
    } else {
      gra = " 죽어!!!!!! "
    }
  }
  fmt.println(gra)
  fmt.println(n)
  fmt.println(sum_num)

  return 0
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