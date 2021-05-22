#ifndef VALUE_TYPE_H
#define VALUE_TYPE_H

#include <iostream>

typedef int ValueType;

int compare_value(const ValueType& a, const ValueType& b);

void print_value(ValueType& a, std::ostream& ostream);
void read_value(ValueType&, std::istream&);

void copy_value(ValueType& target, const ValueType& source);

bool equals(const ValueType& a, const ValueType& b);

#endif