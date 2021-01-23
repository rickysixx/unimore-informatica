#include <iostream>
#include <fstream>

const char* FILE_NAME = "queue.dat";

struct Queue
{
    int* array = nullptr;
    unsigned int capacity = 0;
    unsigned int head_index = 0;
    unsigned int elements_count = 0;
};

void reset_queue(Queue& queue)
{
    delete[] queue.array;

    queue.capacity = 0;
    queue.head_index = -1;
    queue.elements_count = 0;
    queue.array = nullptr;
}

void init_queue(Queue& queue, const unsigned int capacity)
{
    reset_queue(queue);

    queue.capacity = capacity;
    queue.array = new int[queue.capacity];
}

bool is_empty(const Queue& queue)
{
    return queue.elements_count == 0;
}

bool is_full(const Queue& queue)
{
    return queue.elements_count == queue.capacity;
}

unsigned int increment_index(const Queue& queue, const unsigned int index)
{
    return (index + 1) % queue.capacity;
}

unsigned int decrement_index(const Queue& queue, const unsigned int index)
{
    return (index == 0) ? queue.capacity - 1 : index - 1;
}

unsigned int get_tail_index(const Queue& queue)
{
    return (is_empty(queue)) ? 0 : (queue.head_index + queue.elements_count - 1) % queue.capacity;
}

bool push_to_head(Queue& queue, const int value)
{
    if (is_full(queue))
    {
        return false;
    }
    else
    {
        queue.head_index = (is_empty(queue)) ? 0 : decrement_index(queue, queue.head_index);
        queue.array[queue.head_index] = value;
        ++queue.elements_count;

        return true;
    } 
}

bool push_to_tail(Queue& queue, const int value)
{
    if (is_full(queue))
    {
        return false;
    }
    else
    {
        int tail_index = get_tail_index(queue);

        if (is_empty(queue))
        {
            queue.head_index = tail_index;
        }
        else
        {
            tail_index = increment_index(queue, tail_index);
        }

        queue.array[tail_index] = value;
        ++queue.elements_count;

        return true;
    }
}

int get_head(const Queue& queue)
{
    return queue.array[queue.head_index];
}

int get_tail(const Queue& queue)
{
    return queue.array[get_tail_index(queue)];
}

void remove_from_head(Queue& queue)
{
    if (!is_empty(queue))
    {
        queue.head_index = increment_index(queue, queue.head_index);
        --queue.elements_count;
    }
}

void remove_from_tail(Queue& queue)
{
    if (!is_empty(queue))
    {
        --queue.elements_count;
    }
}

void print(const Queue& queue)
{
    if (is_empty(queue))
    {
        std::cout << "Queue is empty." << std::endl;
    }
    else
    {
        std::cout << "[" << queue.array[queue.head_index];

        const unsigned int end_loop_index = increment_index(queue, get_tail_index(queue));

        for (unsigned int i = increment_index(queue, queue.head_index); i != end_loop_index; i = increment_index(queue, i))
        {
            std::cout << " " << queue.array[i];
        }
        std::cout << "]" << std::endl;

        std::cout << "The underlying array is:" << std::endl;
        std::cout << "[" << queue.array[0];

        for (unsigned int i = 1; i < queue.capacity; i++)
        {
            std::cout << " " << queue.array[i];
        }
        std::cout << "]" << std::endl;

        std::cout << "Queue capcity is of " << queue.capacity << " elements." << std::endl;
        std::cout << "Queue has " << queue.elements_count << " elements." << std::endl;
        std::cout << "Queue head index is at position " << queue.head_index << "." << std::endl;
        std::cout << "Queue has still " << queue.capacity - queue.elements_count << " free positions." << std::endl;
    }
}

bool save_to_file(const Queue& queue)
{
    std::ofstream file(FILE_NAME);

    if (file)
    {
        file.write(reinterpret_cast<const char*>(&queue.capacity), sizeof(int));
        file.write(reinterpret_cast<const char*>(&queue.head_index), sizeof(int));
        file.write(reinterpret_cast<const char*>(&queue.elements_count), sizeof(int));
        file.write(reinterpret_cast<const char*>(queue.array), sizeof(int) * queue.capacity);

        return true;
    }
    else
    {
        return false;
    }
}

bool load_from_file(Queue& queue)
{
    std::ifstream file(FILE_NAME);

    if (file)
    {
        reset_queue(queue);

        char* buffer = new char[sizeof(int)];

        file.read(buffer, sizeof(int));
        queue.capacity = *(reinterpret_cast<int*>(buffer));

        file.read(buffer, sizeof(int));
        queue.head_index = *(reinterpret_cast<int*>(buffer));

        file.read(buffer, sizeof(int));
        queue.elements_count = *(reinterpret_cast<int*>(buffer));

        delete[] buffer;

        buffer = new char[queue.capacity * sizeof(int)];

        file.read(buffer, queue.capacity * sizeof(int));
        queue.array = reinterpret_cast<int*>(buffer);

        return true;
    }
    else
    {
        return false;
    }
    
}

int main()
{
    Queue queue;
    const char menu[] =
        "1. Initialize queue\n"
        "2. Push element to head\n"
        "3. Push element to tail\n"
        "4. Remove from head\n"
        "5. Remove from tail\n"
        "6. Print queue\n"
        "7. Save queue to file\n"
        "8. Load queue from file\n"
        "Select other values or press CTRL+C to exit.";
    
    while (true)
    {
        std::cout << menu << std::endl;

        int option;
        std::cout << "Please select an option: ";
        std::cin >> option;

        switch (option)
        {
            case 1: {
                int queue_capacity;

                std::cout << "Enter queue capacity: ";
                std::cin >> queue_capacity;

                init_queue(queue, queue_capacity);

                std::cout << "Queue initialized with a capacity of " << queue_capacity << " elements." << std::endl;

                break;
            }
            case 2: {
                int value;

                std::cout << "Enter the value to add to the queue: ";
                std::cin >> value;

                if (push_to_head(queue, value))
                {
                    std::cout << value << " pushed successfully into the queue." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when pushing " << value << " into the queue." << std::endl;
                }
                
                break;
            }
            case 3: {
                int value;

                std::cout << "Enter the value to add to the queue: ";
                std::cin >> value;

                if (push_to_tail(queue, value))
                {
                    std::cout << value << " pushed successfully into the queue." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when pushing " << value << " into the queue." << std::endl;
                }
                
                break;
            }
            case 4: {
                if (is_empty(queue))
                {
                    std::cerr << "Queue is empty. There are no elements to remove." << std::endl;
                }
                else
                {
                    int removed_value = get_head(queue);

                    remove_from_head(queue);

                    std::cout << "Value " << removed_value << " removed from the queue." << std::endl;
                }
                
                break;
            }
            case 5: {
                if (is_empty(queue))
                {
                    std::cerr << "Queue is empty. There are no elements to remove." << std::endl;
                }
                else
                {
                    int removed_value = get_tail(queue);

                    remove_from_tail(queue);

                    std::cout << "Value " << removed_value << " removed from the queue." << std::endl;
                }
                
                break;
            }
            case 6:
                print(queue);
                break;
            case 7:
                if (save_to_file(queue))
                {
                    std::cout << "Queue successfully saved to file " << FILE_NAME << "." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when saving queue to file " << FILE_NAME << "." << std::endl;
                }
                
                break;
            case 8:
                if (load_from_file(queue))
                {
                    std::cout << "Queue successfully loaded from file " << FILE_NAME << "." << std::endl;
                }
                else
                {
                    std::cerr << "An error occurred when loading queue from file " << FILE_NAME << "." << std::endl;
                }
                
                break;
            default:
                return 0;
        }
    }

    return 0;
}