#include <iostream>

__global__ void barKernel() {
	printf("bar!\n");
}

__declspec(dllexport) void bar(){
	barKernel<<<1,1>>>();
	std::cout << "bar done!\n";
}
