#ifndef LIB_TEMPLATE_CMAKE_H
#define LIB_TEMPLATE_CMAKE_H

namespace LibTemplateCMake {

/**
* A function that sums to number of the same type
*/
template<typename DatumType>
DatumType sum(DatumType op1, DatumType op2)
{
    return (op1 + op2);
}


} // namespace LibTemplateCMake

#endif // LIB_TEMPLATE_CMAKE_H
