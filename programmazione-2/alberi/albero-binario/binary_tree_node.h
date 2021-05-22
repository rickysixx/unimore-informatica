#ifndef B_NODE_H
#define B_NODE_H

#include "value_type.h"
#include "key_type.h"

struct BinaryTreeNode
{
    KeyType key;
    ValueType value;
    BinaryTreeNode* parent = nullptr;
    BinaryTreeNode* left = nullptr;
    BinaryTreeNode* right = nullptr;
};

BinaryTreeNode* new_binary_tree_node(const ValueType& value);
BinaryTreeNode* new_binary_tree_node(KeyType& key, ValueType& value);

KeyType get_key(const BinaryTreeNode* node);

BinaryTreeNode* get_parent(BinaryTreeNode* node);
BinaryTreeNode* get_left_child(BinaryTreeNode* node);
BinaryTreeNode* get_right_child(BinaryTreeNode* node);
ValueType& get_value(BinaryTreeNode* node);

bool has_parent(const BinaryTreeNode* node);
bool has_left_child(const BinaryTreeNode* node);
bool has_right_child(const BinaryTreeNode* node);
bool is_root(const BinaryTreeNode* node);
bool is_leaf(const BinaryTreeNode* node);
bool is_left_child(const BinaryTreeNode* node);
bool is_right_child(const BinaryTreeNode* node);

bool equals(const BinaryTreeNode*, const BinaryTreeNode* b);

#endif