package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"

leftList := make([dynamic]int);
rightList := make([dynamic]int);

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

	defer delete(leftList);
	defer delete(rightList);
	
	lines := strings.split_lines(string(data));
	pairAmount: int = len(lines);
	
	similarityScore:int = 0;

	for i := 0; i < len(lines); i+= 1
	{
		pair := strings.split(lines[i], "   ");
	
		left:string = pair[0];
		right:string = pair[1];
		
		append(&leftList, strconv.atoi(left));
		append(&rightList, strconv.atoi(right));
	}

	for i:= 0; i < pairAmount; i += 1
	{
		similarityScore +=  leftList[i] * GetNumberCount(leftList[i]);
	}

	fmt.printfln("Output: %i", similarityScore);
}

GetNumberCount::proc(number : int) -> int
{
	count : int = 0;
	for i:= 0; i < len(rightList); i += 1
	{
		if(rightList[i] == number)
		{
			count += 1;
		}

	}

	return count;
}