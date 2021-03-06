
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value)
    @data = value
    @next = nil
  end
end

# Defines the singly linked list
class LinkedList
  def initialize
    @head = nil # keep the head private. Not accessible outside this class
  end

  # method to add a new node with the specific data value in the linked list
  # insert the new node at the beginning of the linked list
  def insert(value)
    current = Node.new(value)
    if @head == nil
      @head = current
    else
      current.next = @head
      @head = current
    end
  end

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  def search(value)
    if @head == nil
      false
    end
    current = @head
    until current.next == nil
      if current.data == value
        return true
      end
      current = current.next
    end
    return false
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  def find_max
    if @head == nil
      puts "This list is empty"
      return
    end
    current = @head
    max = @head
    until current.next == nil
      if current.next.data > max.data
        max = current.next
      end
      current = current.next
    end
    return max.data
  end

  # method to return the min value in the linked list
  # returns the data value and not the node
  def find_min
    if @head == nil
      puts "This list is empty"
      return
    end
    current = @head
    min = @head
    until current.next == nil
      if current.next.data < min.data
        min = current.next
      end
      current = current.next
    end
    return min.data
  end

  # method that returns the length of the singly linked list
  def length
    if @head == nil
      return 0
    end

    current = @head
    count = 1

    until current.next == nil
      current = current.next
      count += 1
    end
    return count

  end

  # method to return the value of the nth element from the beginning
  # assume indexing starts at 0 while counting to n
  def find_nth_from_beginning(n)
    if n < 0
      puts "n must be 0 or bigger than 0"
      return
    elsif @head == nil
      puts "This list is empty"
      return
    end

    current = @head
    # # while current.next != nil
    n.times do
      n -= 1
      current = current.next
      if current.next == nil && n > 0
        puts "There's no nth element in this list"
        return
      end
    end
    return current.data
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  def insert_ascending(value)
    new_node = Node.new(value)
    current = @head

    if @head == nil || @head.data > new_node.data
      @head = new_node
      @head.next = current
      return
    end

    until current.next == nil
      if current.next.data >= new_node.data
        temp = current.next
        current.next = new_node
        new_node.next = temp
        return
      else
        current = current.next
      end
    end

    current.next = new_node

  end

  # method to print all the values in the linked list
  def visit
    current = @head
    print "#{current.data} "
    while current.next != nil
      current = current.next
      print "#{current.data} "
    end
    puts
  end

  # method to delete the first node found with specified value
  def delete(value)
    current = @head
    if current.data == value && current.next == nil
      @head = nil
    elsif current.data == nil
      puts "This list is empty"
      return
    elsif current.data == value && current.next != nil
      @head = current.next
      return
    end

    until current.next == nil
      previous = current
      current = current.next
      if current.data == value
        previous.next = current.next
        return
      end
    end

    puts "#{value} is not found in this list"
    return

  end

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  def reverse
    if @head == nil || @head.next == nil
      return @head
    end

    current = @head
    temp = current.next
    current.next = nil
    while temp != nil
      temp_next = temp.next
      temp.next = current
      current = temp
      @head = current
      temp = temp_next
    end

    @head = current
  end

  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  def find_middle_value
    if @head == nil || @head.next == nil || @head.next.next == nil
      return @head
    end

    current = @head
    double_current = @head
    until double_current.next == nil
      current =  current.next
      2.times do
        if double_current.next == nil
          return current.data
        else
        double_current = double_current.next
        end
      end
    end

    return current.data



  end

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  def find_nth_from_end(n)
    if @head == nil
      puts "This is an empty list"
      return
    end

    current = @head
    nth_current = @head
    if n > 0
      n.times do
        if nth_current == nil
          return "list is shorter than n"
        end
        nth_current = nth_current.next
      end
    end
    until nth_current.next == nil
      current = current.next
      nth_current = nth_current.next
    end
    return current.data

  end

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  def has_cycle
    if @head == nil || @head.next == nil
      return false
    end

    current = @head
    double_current = @head.next

    until double_current == current
      current =  current.next
      2.times do
        if double_current.next == nil
          return false
        else
        double_current = double_current.next
        end
      end
    end

    return true
  end

  # Creates a cycle in the linked list for testing purposes
  # Assumes the linked list has at least one node
  def create_cycle
    return if @head == nil # don't do anything if the linked list is empty

    # navigate to last node
    current = @head
    while current.next != nil
      current = current.next
    end

    current.next = @head # make the last node link to first node
  end
end

## --- END of class definitions --- ##

# Create an object of linked list class
my_linked_list = LinkedList.new()

# Add some values to the linked list
puts "Adding 5, 3 and 1 to the linked list."
my_linked_list.insert(5)
my_linked_list.insert(3)
my_linked_list.insert(1)

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

# Find the value at the nth node
puts "Confirming values in the linked list using find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 5 and is #{value}" if value != 5
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_beginning(0)
puts "BUG: Value at index 0 should be 1 and is #{value}" if value != 1

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

# Insert ascending
puts "Adding 4 in ascending order."
my_linked_list.insert_ascending(4)
# check newly inserted value
puts "Checking values by calling find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_beginning(3)
puts "BUG: Value at index 3 should be 5 and is #{value}" if value != 5
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 3 and is #{value}" if value != 3

# Insert ascending
puts "Adding 6 in ascening order."
my_linked_list.insert_ascending(6)

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

# vaidate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 5 and not #{my_linked_list_length}" if my_linked_list_length != 5

# find min and max
puts "Confirming min and max values in the linked list."
min = my_linked_list.find_min
puts "BUG: Min value should be 1 and not #{min}" if min != 1
max = my_linked_list.find_max
puts "BUG: Max value should be 5 and not #{max}" if max != 6

# delete value
puts "Deleting node with value 5 from the linked list."
my_linked_list.delete(5)
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 4 and not #{my_linked_list_length}" if my_linked_list_length != 4

# delete value
puts "Deleting node with value 1 from the linked list."
my_linked_list.delete(1)
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 3 and not #{my_linked_list_length}" if my_linked_list_length != 3

# find middle element
puts "Confirming middle value in the linked list."
middle = my_linked_list.find_middle_value
puts "BUG: Middle value should be 4 and not #{middle}" if middle != 4

# reverse the linked list
puts "Reversing the linked list."
my_linked_list.reverse
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# verify the reversed list
puts "Verifying the reveresed linked list by calling find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_beginning(0)
puts "BUG: Value at index 0 should be 6 and is #{value}" if value != 6

# nth from the end
puts "Verifying find_nth_from_end method."
value = my_linked_list.find_nth_from_end(0)
puts "BUG: Value at index 0 from the end, should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_end(1)
puts "BUG: Value at index 1 from the end, should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_end(2)
puts "BUG: Value at index 2 from the end, should be 6 and is #{value}" if value != 6

# check for cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if my_linked_list.has_cycle

# create cycle and then test for it
puts "Creating a cycle in the linked list."
my_linked_list.create_cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if !(my_linked_list.has_cycle)
