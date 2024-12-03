package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() 
{
	fmt.println("Advent of Code 1 \n");

	data, succes := os.read_entire_file("input.txt", context.allocator);
	
	if !succes 
	{
		fmt.printfln("Could not read text file!");
		return
	}

	defer delete(data, context.allocator);

	leftList := make([dynamic]int);
	rightList := make([dynamic]int);

	defer delete(leftList);
	defer delete(rightList);
	
	lines := strings.split_lines(string(data));
	pairAmount: int = len(lines);
	sum:int = 0;

	for i := 0; i < len(lines); i+= 1
	{
		pair := strings.split(lines[i], "   ");
	
		left:string = pair[0];
		right:string = pair[1];
		
		append(&leftList, strconv.atoi(left));
		append(&rightList, strconv.atoi(right));
	}
	
	slice.sort(leftList[:]);
	slice.sort(rightList[:]);

	for i:= 0; i < pairAmount; i += 1
	{
		sum += abs(leftList[i] - rightList[i]);
	}

	fmt.printfln("Output: %i", sum);
}