#include <iostream>
#include <owl/owl.h>

__global__ void testKernel() {
	printf("foo kernel!\n");
}

__declspec(dllexport) void foo(){
	OWLContext owlContext = owlContextCreate(nullptr, 1);
	testKernel<<<1,1>>>();
	cudaDeviceSynchronize();
	owlContextDestroy(owlContext);
	std::cout << "foo done!\n";
}
