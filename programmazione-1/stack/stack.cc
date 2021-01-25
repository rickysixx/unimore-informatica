#include <iostream>
#include <fstream>

const char* TEXT_FILE_NAME = "stack.txt";
const char* BINARY_FILE_NAME = "stack.dat";

struct Stack
{
    int* array = nullptr;
    unsigned int capacity = 0;
    unsigned int elements_count = 0;
};

void reset_stack(Stack& stack)
{
    delete[] stack.array;

    stack.elements_count = 0;
    stack.capacity = 0;
    stack.array = nullptr;
}

void init_stack(Stack& stack, const unsigned int capacity)
{
    reset_stack(stack);

    stack.capacity = capacity;
    stack.array = new int[stack.capacity];
    stack.elements_count = 0;
}

bool is_full(Stack& stack)
{
    return stack.elements_count == stack.capacity;
}

bool is_empty(const Stack& stack)
{
    return stack.elements_count == 0;
}

bool push(Stack& stack, const int value)
{
    if (is_full(stack))
    {
        return false;
    }
    else
    {
        stack.array[stack.elements_count] = value;
        ++stack.elements_count;

        return true;
    }
}

bool pop(Stack& stack)
{
    if (is_empty(stack))
    {
        return false;
    }
    else
    {
        --stack.elements_count;

        return true;
    }
}

int top(const Stack& stack)
{
    return stack.array[stack.elements_count - 1];
}

void print(const Stack& stack)
{
    if (is_empty(stack))
    {
        std::cout << "Stack is empty." << std::endl;
    }
    else
    {
        std::cout << top(stack) << " <--- top" << std::endl;
        for (int i = stack.elements_count - 2; i >= 0; i--)
        {
            std::cout << stack.array[i] << std::endl;
        }

        std::cout << "Stack has a capacity of " << stack.capacity << " elements." << std::endl;
        std::cout << "Stack has currently " << stack.elements_count << " elements." << std::endl;
    }
}

bool save_to_text_file(const Stack& stack)
{
    std::ofstream file(TEXT_FILE_NAME);

    if (file)
    {
        file << stack.capacity << std::endl;

        file << stack.array[0];
        for (unsigned int i = 1; i < stack.elements_count; i++)
        {
            file << " " << stack.array[i];
        }

        return true;
    }
    else
    {
        return false;
    }
}

bool load_from_text_file(Stack& stack)
{
    std::ifstream file(TEXT_FILE_NAME);

    if (file)
    {
        reset_stack(stack);

        file >> stack.capacity;

        stack.array = new int[stack.capacity];
        stack.elements_count = 0;

        while (file >> stack.array[stack.elements_count])
        {
            ++stack.elements_count;
        }

        return true;
    }
    else
    {
        return false;
    }
}

bool save_to_binary_file(const Stack& stack)
{
    std::ofstream file(BINARY_FILE_NAME);

    if (file)
    {
        file.write(reinterpret_cast<const char*>(&stack.capacity), sizeof(unsigned int));
        file.write(reinterpret_cast<const char*>(&stack.elements_count), sizeof(unsigned int));
        file.write(reinterpret_cast<const char*>(stack.array), sizeof(int) * stack.capacity);

        return true;
    }
    else
    {
        return false;
    }
}

bool load_from_binary_file(Stack& stack)
{
    std::ifstream file(BINARY_FILE_NAME);

    if (file)
    {
        reset_stack(stack);

        file.read(reinterpret_cast<char*>(&stack.capacity), sizeof(unsigned int));
        file.read(reinterpret_cast<char*>(&stack.elements_count), sizeof(unsigned int));

        stack.array = new int[stack.capacity];

        file.read(reinterpret_cast<char*>(stack.array), sizeof(int) * stack.capacity);

        return true;
    }
    else
    {
        return false;
    }
}

int main()
{
    Stack stack;
    const char menu[] = 
        "1. Initialize stack\n"
        "2. Push element to stack\n"
        "3. Pop element from stack\n"
        "4. Print stack\n"
        "5. Save stack to text file\n"
        "6. Load stack from text file\n"
        "7. Save stack to binary file\n"
        "8. Load stack from binary file";
    
    int option;

    while (true)
    {
        std::cout << menu << std::endl;
        std::cout << "Please select an option: ";
        std::cin >> option;

        switch (option)
        {
            case 1: {
                unsigned int stack_capacity;

                std::cout << "Enter stack capacity: ";
                std::cin >> stack_capacity;
                
                init_stack(stack, stack_capacity);

                std::cout << "Stack initialized with a capacity of " << stack_capacity << " elements." << std::endl;

                break;
            }
            case 2: {
                int value;

                std::cout << "Enter the value to push to the stack: ";
                std::cin >> value;

                if (push(stack, value))
                {
                    std::cout << value << " successfully pushed to the stack." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when pushing " << value << " to the stack." << std::endl;
                }
                
                break;
            }
            case 3: {
                if (is_empty(stack))
                {
                    std::cerr << "Stack is currently empty. There are no values to pop." << std::endl;
                }
                else
                {
                    int value = top(stack);

                    pop(stack);

                    std::cout << value << " popped from the stack." << std::endl;
                }
                
                break;
            }
            case 4: {
                print(stack);

                break;
            }
            case 5: {
                if (save_to_text_file(stack))
                {
                    std::cout << "Stack successfully saved to file " << TEXT_FILE_NAME << "." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when saving stack to file " << TEXT_FILE_NAME << "." << std::endl;
                }
                
                break;
            }
            case 6: {
                if (load_from_text_file(stack))
                {
                    std::cout << "Stack successfully loaded from file " << TEXT_FILE_NAME << "." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when loading stack from file " << TEXT_FILE_NAME << "." << std::endl;
                }
                
                break;
            }
            case 7: {
                if (save_to_binary_file(stack))
                {
                    std::cout << "Stack successfully saved to file " << BINARY_FILE_NAME << "." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when saving stack to file " << BINARY_FILE_NAME << "." << std::endl;
                }
                
                break;
            }
            case 8: {
                if (load_from_binary_file(stack))
                {
                    std::cout << "Stack successfully loaded from file " << BINARY_FILE_NAME << "." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when loading stack from file " << BINARY_FILE_NAME << "." << std::endl;
                }
                
                break;
            }
            default:
                return 0;
        }
    }

    return 0;
}