#include <cstdlib>
#include "key_type.h"
#include "value_type.h"
#include "binary_tree_node.h"

BinaryTreeNode* new_binary_tree_node(const ValueType& value)
{
    srand(time(nullptr));

    BinaryTreeNode* node = new BinaryTreeNode;

    copy_value(node->value, value);

    node->key = rand() % 10;

    return node;
}

BinaryTreeNode* new_binary_tree_node(KeyType& key, ValueType& value)
{
    BinaryTreeNode* node = new BinaryTreeNode;

    copy_key(node->key, key);
    copy_value(node->value, value);

    return node;
}

KeyType get_key(const BinaryTreeNode* node)
{
    return node->key;
}

BinaryTreeNode* get_parent(BinaryTreeNode* node)
{
    return (node != nullptr) ? node->parent : nullptr;
}

BinaryTreeNode* get_left_child(BinaryTreeNode* node)
{
    return (node != nullptr) ? node->left : nullptr;
}

BinaryTreeNode* get_right_child(BinaryTreeNode* node)
{
    return (node != nullptr) ? node->right : nullptr;
}

ValueType& get_value(BinaryTreeNode* node)
{
    return node->value;
}

bool has_left_child(const BinaryTreeNode* node)
{
    return node != nullptr && node->left != nullptr;
}

bool has_right_child(const BinaryTreeNode* node)
{
    return node != nullptr && node->right != nullptr;
}

bool is_leaf(const BinaryTreeNode* node)
{
    return node != nullptr && !has_left_child(node) && !has_right_child(node);
}

bool is_root(const BinaryTreeNode* node)
{
    return node != nullptr && node->parent == nullptr;
}

bool equals(const BinaryTreeNode* a, const BinaryTreeNode* b)
{
    if (a != nullptr && b != nullptr)
    {
        return equals_key(a->key, b->key);
    }
    else if (a == nullptr && b == nullptr)
    {
        return true;
    }
    else
    {
        return false;
    }
}

bool has_parent(const BinaryTreeNode* node)
{
    return node != nullptr && node->parent != nullptr;
}

bool is_left_child(const BinaryTreeNode* node)
{
    return has_parent(node) && node->parent->left == node;
}

bool is_right_child(const BinaryTreeNode* node)
{
    return has_parent(node) && node->parent->right == node;
}