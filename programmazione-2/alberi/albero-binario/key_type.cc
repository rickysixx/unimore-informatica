#include <iostream>
#include "key_type.h"

int compare_key(const KeyType& a, const KeyType& b)
{
    return a - b;
}

void print_key(const KeyType& value, std::ostream& ostream)
{
    ostream << value;
}

void read_key(KeyType& target, std::istream& istream)
{
    istream >> target;
}

void copy_key(KeyType& target, const KeyType& source)
{
    target = source;
}

bool equals_key(const KeyType& a, const KeyType& b)
{
    return compare_key(a, b) == 0;
}