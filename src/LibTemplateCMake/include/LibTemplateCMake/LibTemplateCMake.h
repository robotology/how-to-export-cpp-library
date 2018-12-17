#ifndef LIB_TEMPLATE_CMAKE_H
#define LIB_TEMPLATE_CMAKE_H

/**
 * \ingroup LibTemplateCMake_namespace
 *
 * LibTemplateCMake namespace.
 */
namespace LibTemplateCMake {

/**
 * @class LibTemplateCMake::summationClass
 * @headerfile LibTemplateCMake.h <LibTemplateCMake/LibTemplateCMake.h>
 *
 * @brief A class from LibTemplateCMake namespace.
 *
 * This class does a summation.
 */
class summationClass
{
public:
    /**
     * Constructor
     */
    summationClass();

    /**
     * Destructor
     */
    virtual ~summationClass();

    /**
     * A method that does a summation
     */
    virtual double doSomething(double op1, double op2);
};


/**
 * @class LibTemplateCMake::differenceClass
 * @headerfile LibTemplateCMake.h <LibTemplateCMake/LibTemplateCMake.h>
 *
 * @brief A derived class from LibTemplateCMake namespace.
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
     * Destructor
     */
    virtual ~differenceClass();

    /**
     * A method that does something
     */
    virtual double doSomething(double op1, double op2);
};


} // namespace LibTemplateCMake

#endif /* LIB_TEMPLATE_CMAKE_H */
