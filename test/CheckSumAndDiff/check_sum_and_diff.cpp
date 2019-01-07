#include <LibTemplateCMake/LibTemplateCMake.h>

#include <cstdlib>
#include <cmath>
#include <iostream>

int main()
{
    std::cout << "Running test on the exported library!" << std::endl;

    LibTemplateCMake::summationClass sumClass;
    LibTemplateCMake::differenceClass diffClass;

    double tol = 1e-10;
    double op1 = 15.0;
    double op2 = 10.0;

    if( fabs(sumClass.doSomething(op1, op2) - (op1 + op2)) > tol )
    {
        std::cerr << "[ERR] sumClass.doSomething(" << op1 << "," << op2
                  << ") is equal to " << sumClass.doSomething(op1, op2)
                  << " instead of the expected " << op1 + op2 << std::endl;
        return EXIT_FAILURE;
    }

    if( fabs(diffClass.doSomething(op1, op2) - (op1 - op2)) > tol )
    {
        std::cerr << "[ERR] sumClass.doSomething(" << op1 << "," << op2
                  << ") is equal to " << diffClass.doSomething(op1, op2)
                  << " instead of the expected " << op1 - op2 << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
