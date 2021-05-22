#include <iostream>
#include <iomanip>
#include "binary_tree_node.h"
#include "binary_search_tree.h"
#include "key_type.h"

bool is_empty(const BinarySearchTree& bst)
{
    return bst == nullptr;
}

void insert_node(BinarySearchTree& bst, BinaryTreeNode* node)
{
    if (is_empty(bst))
    {
        bst = node;
    }
    else
    {
        if (compare_key(get_key(bst), get_key(node)) >= 0)
        {
            if (has_left_child(bst))
            {
                insert_node(bst->left, node);
            }
            else
            {
                bst->left = node;
                node->parent = bst;
            }
        }
        else
        {
            if (has_right_child(bst))
            {
                insert_node(bst->right, node);
            }
            else
            {
                bst->right = node;
                node->parent = bst;
            }
        }
    }
}

void print_bst(const BinarySearchTree& bst, std::ostream& out)
{
    if (!is_empty(bst))
    {
        print_bst(get_left_child(bst), out);

        out << "Key = ";
        print_key(get_key(bst), out);
        out << ", value = ";
        print_value(get_value(bst), out);
        out << std::endl;

        print_bst(get_right_child(bst), out);
    }
}

BinaryTreeNode* search_node(const BinarySearchTree& bst, const KeyType& key)
{
    if (is_empty(bst))
    {
        return nullptr;
    }
    else if (equals_key(get_key(bst), key))
    {
        return bst;
    }
    else if (compare_key(get_key(bst), key) < 0)
    {
        return search_node(get_right_child(bst), key);
    }
    else
    {
        return search_node(get_left_child(bst), key);
    }
}

/**
 * @brief Search the node with the minimum key in the given tree.
 * 
 * @param bst 
 * @return BinaryTreeNode* 
 */
static BinaryTreeNode* search_min(const BinarySearchTree& bst)
{
    if (!has_left_child(bst))
    {
        return bst;
    }
    else
    {
        return search_min(get_left_child(bst));
    }
}

/**
 * @brief Searches the node with the maximum key in the given tree.
 * 
 * @param bst 
 * @return BinaryTreeNode* 
 */
static BinaryTreeNode* search_max(const BinarySearchTree& bst)
{
    if (!has_right_child(bst))
    {
        return bst;
    }
    else
    {
        return search_max(get_right_child(bst));
    }
}

static BinaryTreeNode* find_replacing_node_for_delete(BinaryTreeNode* node_to_delete)
{
    BinaryTreeNode* min_on_right = search_min(get_right_child(node_to_delete));

    return (min_on_right != nullptr) ? min_on_right : search_max(get_left_child(node_to_delete));
}

void remove_node(BinarySearchTree& bst, BinaryTreeNode*& node)
{
    if (!is_empty(bst))
    {
        BinaryTreeNode* node_parent = get_parent(node);
        BinaryTreeNode* replacing_node = find_replacing_node_for_delete(node);
        
        if (node_parent != nullptr) // node to remove is a leaf or an intermediate node
        {
            if (is_left_child(node))
            {
                node_parent->left = replacing_node;
            }
            else
            {
                node_parent->right = replacing_node;
            }
        }
        else // node to remove is the root
        {
            bst = replacing_node;
        }

        if (replacing_node != nullptr) // node to remove is not a leaf
        {
            BinaryTreeNode* replacing_node_parent = get_parent(replacing_node);

            if (is_left_child(replacing_node))
            {
                replacing_node_parent->left = replacing_node->left;
            }
            else
            {
                replacing_node_parent->right = replacing_node->right;
            }

            replacing_node->parent = node_parent;
            replacing_node->left = node->left;
            replacing_node->right = node->right;

            if (has_left_child(node))
            {
                node->left->parent = replacing_node;
            }

            if (has_right_child(node))
            {
                node->right->parent = replacing_node;
            }
        }

        delete node;
        node = nullptr;
    }
}

void serialize(const BinarySearchTree& bst, std::ostream& out)
{
    if (!is_empty(bst))
    {
        out << "(";
        print_value(get_value(bst), out);

        serialize(get_left_child(bst), out);
        serialize(get_right_child(bst), out);

        out << ")";
    }
}

static void serialize_to_json(const BinarySearchTree& bst, std::ostream& out, unsigned int indentation)
{
    out << std::setfill(' ') << std::setw(indentation) << ' ' << "\"parent\": \"" << static_cast<void*>(get_parent(bst)) << "\"," << std::endl;
    out << std::setfill(' ') << std::setw(indentation) << ' ' << "\"address\": \"" << static_cast<void*>(bst) << "\"," << std::endl;
    out << std::setfill(' ') << std::setw(indentation) << ' ' << "\"key\": \"";
    print_key(get_key(bst), out);
    out << "\"," << std::endl;

    out << std::setfill(' ') << std::setw(indentation) << ' ' << "\"value\": \"";
    print_value(get_value(bst), out);
    out << "\"";

    if (has_left_child(bst))
    {
        out << "," << std::endl;
        out << std::setfill(' ') << std::setw(indentation) << ' ' << "\"left\": {" << std::endl;
        
        serialize_to_json(get_left_child(bst), out, indentation + 4);

        out << std::setfill(' ') << std::setw(indentation) << ' ' << '}';
    }

    if (has_right_child(bst))
    {
        out << ',' << std::endl;
        out << std::setfill(' ') << std::setw(indentation) << ' ' << "\"right\": {" << std::endl;

        serialize_to_json(get_right_child(bst), out, indentation + 4);

        out << std::setfill(' ') << std::setw(indentation) << ' ' << '}';
    }

    out << std::endl;
}

void serialize_to_json(const BinarySearchTree& bst, std::ostream& out)
{
    if (!is_empty(bst))
    {
        out << '{' << std::endl;

        serialize_to_json(bst, out, 4);

        out << '}' << std::endl;
    }
}