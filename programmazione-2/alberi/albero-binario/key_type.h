#ifndef KEY_TYPE_H
#define KEY_TYPE_H

#include <iostream>

typedef int KeyType;

int compare_key(const KeyType& a, const KeyType& b);

void print_key(const KeyType& a, std::ostream& ostream);
void read_key(KeyType&, std::istream&);

void copy_key(KeyType& target, const KeyType& source);

bool equals_key(const KeyType& a, const KeyType& b);

#endif