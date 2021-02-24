#include <iostream>
#include <owl/owl.h>

__global__ void testKernel() {
	printf("Hello world!\n");
}

/*__declspec(dllexport) void foo()*/
int main(){
	OWLContext owlContext = owlContextCreate(nullptr, 1);
	testKernel<<<1,1>>>();
	cudaDeviceSynchronize();
	owlContextDestroy(owlContext);
	std::cout << "foo done!\n";
	return 0;
}
