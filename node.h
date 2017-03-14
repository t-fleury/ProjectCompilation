#ifndef NODE_H
#define NODE_H
#include "environ.h"

typedef struct Node{
  char *value;
  struct Node *rightChild;
  struct Node *leftChild;
}Node;

Node* create_Node(char *value, Node *rightChild, Node *leftChild);
void printNode(Node *node);
void createENV(Node *tree);
int eval(int op, int arg1, int arg2);
void makeTree(ENV *env, Node *tree);

#endif
