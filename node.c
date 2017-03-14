#include "node.h"
#include <string.h>
char* strdup(const char *s);

Node* create_Node(char *value, Node *rightChild, Node *leftChild){
  Node *node = malloc(sizeof(Node*));
  node->value = strdup(value);
  node->rightChild = rightChild;
  node->leftChild = leftChild;
  return node;
}

void printNode(Node *node){
  if(node == NULL){return;}
  printf("%s ", node->value);
  if(node->rightChild != NULL && node->leftChild != NULL){
      printNode(node->leftChild);
      printNode(node->rightChild);
  }
}
