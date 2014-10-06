#ifndef LIB_TEMPLATE_CMAKE_H
#define LIB_TEMPLATE_CMAKE_H

#include "template-lib-export.h"

namespace LibTemplateCMake {

/**
 * \class LibTemplateCMake::aClass
 * \headerfile template-lib.h <TemplateLib/templatelib.h>
 *
 * \brief A class from LibTemplateCMake namespace.
 *
 * This class that does a summation.
 */
class TEMPLATE_LIB_EXPORT summationClass
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
class TEMPLATE_LIB_EXPORT differenceClass : public summationClass
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