#ifndef BINARY_SEARCH_TREE_H
#define BINARY_SEARCH_TREE_H
#include <iostream>
#include "binary_tree_node.h"

typedef BinaryTreeNode* BinarySearchTree;

bool is_empty(const BinarySearchTree&);

void insert_node(BinarySearchTree&, BinaryTreeNode*);

BinaryTreeNode* search_node(const BinarySearchTree&, const KeyType&);

void remove_node(BinarySearchTree&, BinaryTreeNode*&);

/**
 * @brief Prints tree's nodes in ascendent order by key.
 * 
 */
void print_bst(const BinarySearchTree&, std::ostream&);

/**
 * @brief Serializes the tree using balanced brackets to the given output stream.
 * 
 */
void serialize(const BinarySearchTree&, std::ostream&);

void serialize_to_json(const BinarySearchTree&, std::ostream&);

#endif