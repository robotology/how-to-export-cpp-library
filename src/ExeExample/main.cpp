#include "LibTemplateCMake/LibTemplateCMake.h"

#include <cstdlib>
#include <cmath>
#include <iostream>

int main()
{
    std::cout << "Example executable." << std::endl;


    std::cout << "Sum of doubles." << std::endl;

    double told = 1e-10;
    double opd1 = 15.0;
    double opd2 = 10.0;

    if( fabs(LibTemplateCMake::sum(opd1, opd2) - (opd1 + opd2)) > told )
    {
        std::cerr << "[ERR] LibTemplateCMake::sum(" << opd1 << ", " << opd2
                  << ") is equal to " << LibTemplateCMake::sum(opd1, opd2)
                  << " instead of the expected " << opd1 + opd2 << std::endl;
        return EXIT_FAILURE;
    }
    else
    {
        std::cout << "[INFO] LibTemplateCMake::sum(" << opd1 << ", " << opd2
                  << ") is equal to " << LibTemplateCMake::sum(opd1, opd2)
                  << " as expected." << std::endl;
    }


    std::cout << "Sum of ints." << std::endl;

    int opi1 = 15;
    int opi2 = 10;

    if( LibTemplateCMake::sum(opi1, opi2) - (opi1 + opi2) != 0)
    {
        std::cerr << "[ERR] LibTemplateCMake::sum(" << opi1 << ", " << opi2
                  << ") is equal to " << LibTemplateCMake::sum(opi1, opi2)
                  << " instead of the expected " << opi1 + opi2 << std::endl;
        return EXIT_FAILURE;
    }
    else
    {
        std::cout << "[INFO] LibTemplateCMake::sum(" << opi1 << ", " << opi2
                  << ") is equal to " << LibTemplateCMake::sum(opi1, opi2)
                  << " as expected." << std::endl;
    }

    return EXIT_SUCCESS;
}
