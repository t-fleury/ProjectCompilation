#ifndef NODE_H
#define NODE_H

typedef struct Node{
  char *value;
  struct Node *rightChild;
  struct Node *leftChild;
}Node;

Node* create_Node(char *value, Node *rightChild, Node *leftChild);
void printNode(Node *node);

#endif
