#include <iostream>

void bar();

__global__ void fooKernel() {
	printf("foo!\n");
}

int main(){
	bar();
	fooKernel<<<1,1>>>();
	cudaDeviceSynchronize();
	std::cout << "foo done!\n";
	return 0;
}
