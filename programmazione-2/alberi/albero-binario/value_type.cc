#include <iostream>
#include "value_type.h"

int compare_value(const ValueType& a, const ValueType& b)
{
    return a - b;
}

void print_value(ValueType& value, std::ostream& ostream)
{
    ostream << value;
}

void read_value(ValueType& target, std::istream& istream)
{
    istream >> target;
}

void copy_value(ValueType& target, const ValueType& source)
{
    target = source;
}

bool equals(const ValueType& a, const ValueType& b)
{
    return compare_value(a, b) == 0;
}