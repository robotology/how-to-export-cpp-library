#include <LibTemplateCMake/LibTemplateCMake.h>

LibTemplateCMake::summationClass::summationClass()
{
}

LibTemplateCMake::summationClass::~summationClass()
{
}

double LibTemplateCMake::summationClass::doSomething(double op1, double op2)
{
    return op1 + op2;
}

LibTemplateCMake::differenceClass::differenceClass() :
        summationClass()
{
}

LibTemplateCMake::differenceClass::~differenceClass()
{
}

double LibTemplateCMake::differenceClass::doSomething(double op1, double op2)
{
    return op1 - op2;
}
