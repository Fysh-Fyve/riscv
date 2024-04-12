; ModuleID = 'fysh'
source_filename = "simple-matrix.fysh"

define i32 @set_pixel(i32 %row, i32 %col) {
entry:
  %andtmp = shl i32 %row, 3
  %shltmp = and i32 %andtmp, 56
  %andtmp1 = and i32 %col, 7
  %ortmp = or i32 %andtmp1, 128
  %ortmp2 = or i32 %ortmp, %shltmp
  call void @fysh_gpio_write_all(i32 %ortmp2)
  ret i32 %ortmp2
}

declare void @fysh_gpio_write_all(i32)

define i32 @draw_fysh(i32 %dy, i32 %dx) {
entry:
  %0 = call i32 @set_pixel(i32 %dy, i32 %dx)
  %addtmp3 = add i32 %dx, 2
  %1 = call i32 @set_pixel(i32 %dy, i32 %addtmp3)
  %addtmp5 = add i32 %dx, 3
  %2 = call i32 @set_pixel(i32 %dy, i32 %addtmp5)
  %addtmp6 = add i32 %dy, 1
  %addtmp7 = add i32 %dx, 1
  %3 = call i32 @set_pixel(i32 %addtmp6, i32 %addtmp7)
  %addtmp9 = add i32 %dx, 4
  %4 = call i32 @set_pixel(i32 %addtmp6, i32 %addtmp9)
  %addtmp10 = add i32 %dy, 2
  %5 = call i32 @set_pixel(i32 %addtmp10, i32 %dx)
  %6 = call i32 @set_pixel(i32 %addtmp10, i32 %addtmp3)
  %7 = call i32 @set_pixel(i32 %addtmp10, i32 %addtmp5)
  ret i32 %7
}

define i32 @main() {
entry:
  br label %loop_cond

loop_cond:                                        ; preds = %loop_cond, %entry
  call void @draw_frame(i32 1, i32 0)
  call void @draw_frame(i32 1, i32 1)
  call void @draw_frame(i32 1, i32 2)
  call void @draw_frame(i32 1, i32 3)
  call void @draw_frame(i32 1, i32 4)
  call void @draw_frame(i32 1, i32 5)
  call void @draw_frame(i32 1, i32 6)
  call void @draw_frame(i32 1, i32 7)
  br label %loop_cond
}

declare void @draw_frame(i32, i32)
