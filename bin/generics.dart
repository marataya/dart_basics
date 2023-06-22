class Node<T> {
  T value;

  Node(this.value);

  Node<T>? leftChild;
  Node<T>? rightChild;

  @override
  String toString() {
    final left = leftChild?.toString() ?? '';
    final parent = value.toString();
    final right = rightChild?.toString() ?? '';
    return '$left $parent $right';
  }
}

Node<E>? createTree<E>(List<E> nodes, [int index = 0]) {
  if (index >= nodes.length) return null;

  final node = Node(nodes[index]);

  final leftChildIndex = 2 * index + 1;
  final rightChildIndex = 2 * index + 2;

  node.leftChild = createTree(nodes, leftChildIndex);
  node.rightChild = createTree(nodes, rightChildIndex);

  return node;
}

class BinarySearchTree<E extends Comparable<E>> {
  Node<E>? root;

  void insert(E value) {
    root = _insertAt(root, value);
  }

  Node<E> _insertAt(Node<E>? node, E value) {
    if (node == null) {
      return Node(value);
    }
    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    } else {
      node.rightChild = _insertAt(node.leftChild, value);
    }
    return node;
  }

  @override
  String toString() => root.toString();
}

class Stack<T> {
  List<T> _stack = [];

  void push(T value) {
    _stack.add(value);
  }

  T? pop() {
    if (_stack.isNotEmpty)
      return _stack.removeLast();
    else
      return null;
  }

  bool isEmpty() {
    return _stack.isEmpty;
  }

  @override
  String toString() {
    return 'Stack{_stack: $_stack}';
  }
}

void main() {
  final tree = createTree([7, 1, 9, 0, 5, 8]);
  print('\nInt tree:');
  print(tree?.value);
  print(tree?.leftChild?.value);
  print(tree?.rightChild?.value);
  print(tree?.leftChild?.leftChild?.value);
  print(tree?.leftChild?.rightChild?.value);
  print(tree?.rightChild?.rightChild?.value);

  final tree1 = createTree(['seven', 'one', 'nine', 'zero', 'five', 'eight']);
  print('\nString tree:');
  print(tree1?.value);
  print(tree1?.leftChild?.value);
  print(tree1?.rightChild?.value);
  print(tree1?.leftChild?.leftChild?.value);
  print(tree1?.leftChild?.rightChild?.value);
  print(tree1?.rightChild?.leftChild?.value);
  print(tree1?.rightChild?.rightChild?.value);
  var BST = BinarySearchTree<num>();

  BST.insert(7);
  BST.insert(1);
  BST.insert(9);
  BST.insert(0);
  BST.insert(5);
  BST.insert(8);

  print('\nBST:');
  print(BST);

  print('Stack:');
  final stack = Stack();
  stack.push(5);
  stack.push(7);
  stack.push(9);
  stack.push(10);
  print(stack);
  stack.pop();
  print(stack);
  stack.push('asd');
  print(stack);


}
