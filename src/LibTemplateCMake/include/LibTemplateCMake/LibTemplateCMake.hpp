#ifndef LIB_TEMPLATE_CMAKE_H
#define LIB_TEMPLATE_CMAKE_H

namespace LibTemplateCMake {

/**
* \class LibTemplateCMake::aClass
* \headerfile template-lib.h <TemplateLib/templatelib.h>
*
* \brief A class from LibTemplateCMake namespace.
*
* This class that does a summation.
*/
class summationClass
{
public:
    /**
    * Constructor
    */
    summationClass();

    /**
    * Destructory
    */
    virtual ~summationClass();

    /**
    * A method that does a summation
    */
    virtual double doSomething(double op1, double op2);
};


/**
* \class LibTemplateCMake::anotherClass
* \headerfile template-lib.h <TemplateLib/templatelib.h>
*
* \brief A derived class from LibTemplateCMake namespace.
*
* This class performs a difference.
*/
class differenceClass : public summationClass
{
public:
    /**
    * Constructor
    */
    differenceClass();

    /**
    * Destructory
    */
    virtual ~differenceClass();

    /**
    * A method that does something
    */
    virtual double doSomething(double op1, double op2);
};


} // namespace LibTemplateCMake

#endif // LIB_TEMPLATE_CMAKE_H
