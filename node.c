#include "node.h"
#include "environ.h"
#include <string.h>
char* strdup(const char *s);
int isdigit(int c);


Node* create_Node(char *value, Node *leftChild, Node *rightChild){
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

void createENV(Node *tree){
  ENV env = Envalloc();
  if(tree != NULL){
    makeTree(&env, tree);
    ecrire_env((ENV)env);
  }
}

int eval(char *op, int arg1, int arg2)
{
  if(!strcmp("Pl", op)){
      return(arg1 + arg2);
  }else if(!strcmp("Mo", op)){
      return(arg1 - arg2);
  }else if(!strcmp("Mu", op)){
      return(arg1 * arg2);
  }
  return(0);
}

int makeTree(ENV *env, Node *tree){
  if(!strcmp(tree->value, "Af")){
    initenv(env, tree->leftChild->value);
    return affect(*env, tree->leftChild->value, makeTree(env, tree->rightChild));
  }else if(!strcmp(tree->value, "Wh")){
    while(makeTree(env, tree->leftChild)){
      makeTree(env, tree->rightChild);
    }
  }else if(!strcmp(tree->value, "If")){
    if(valch(*env,tree->leftChild->value) != 0){
      printf("%s\n", tree->rightChild->leftChild->leftChild->value);
      makeTree(env, tree->rightChild->leftChild);
    }else{
      makeTree(env, tree->rightChild->rightChild);
    }
  }else if(!strcmp(tree->value, "Pl") || !strcmp(tree->value, "Mo") || !strcmp(tree->value, "Mu")){
    return eval(tree->value, makeTree(env, tree->leftChild), makeTree(env, tree->rightChild));
  }else if(!strcmp(tree->value,"Se")){
    makeTree(env, tree->leftChild);
    makeTree(env, tree->rightChild);
  }
  bool valid = true;
  for (int i = 0; i < strlen(tree->value); i++) {
    if (!isdigit(tree->value[i])){
      valid = false;
      break;
    }
  }
  if (valid == true)
    return atoi(tree->value);
  if (valch(*env, tree->value) != 0)
    return valch(*env, tree->value);
}
