#include <iostream>

void bar();

__global__ void fooKernel() {
	printf("foo!\n");
}

__declspec(dllexport) void foo(){
	bar();
	fooKernel<<<1,1>>>();
	cudaDeviceSynchronize();
	std::cout << "foo done!\n";
}
