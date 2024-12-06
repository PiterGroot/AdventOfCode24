package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() 
{
	fmt.println("Advent of Code 2 \n");

	data, succes := os.read_entire_file("exampleInput.txt", context.allocator);
	
	if !succes 
	{
		fmt.printfln("Could not read text file!");
		return
	}

	defer delete(data, context.allocator);

	lines := strings.split_lines(string(data));
	safeReports: int = 0;

	reportState : bool = false;

	for i := 0; i < len(lines); i+= 1
	{
		pair := strings.split(lines[i], " ");
	
		//fmt.println("==========");
		//fmt.printf("Report [%i] length: ", i);
		//fmt.println(len(pair));
		//fmt.println("==========");

		reportLength : int = len(pair);
		report := make([dynamic]int);
		
		for j := 0; j < reportLength; j += 1
		{
			reportNum : int = strconv.atoi(pair[j]);
			append(&report, reportNum);
			
			//fmt.println(reportNum)
		}

		fmt.printfln("Is report [%i] safe: %i", i, IsReportSafe(&report));
	}

	fmt.printfln("Output: %i", safeReports);
}

IsReportSafe::proc(arr: ^[dynamic]int) -> bool 
{
	result :bool = true;
	arrFlow: bool = arr[0] > arr[1];
	reportLength : int = len(arr);

	for j := 0; j < reportLength; j += 1
	{
		if(j + 1 > reportLength - 1) do continue;
		
		diff : int = clamp(arr[j] - arr[j + 1], 0, reportLength);

		fmt.printf("%i \n", diff);

		if(arr[j] > arr[j + 1])
		{
			//fmt.println("Increase");
			if(!arrFlow)
			{
				return false;
			}
		}
		else {
			//fmt.println("Decrease");
			if(arrFlow)
			{
				return false;
			}
		}
	}
	
	return result;
}
