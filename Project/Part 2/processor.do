vsim processor

view wave
add wave instruction
add wave reset
add wave Clock
add wave enable
add wave Output

force instruction 000000000110011111111100 0, 000001100101011111111100 55, 011001010111000111111100 110, 000001111000100111111100 165
force reset 0 0
force Clock 0 0, 1 5 -repeat 10
force enable 1 0

run 250