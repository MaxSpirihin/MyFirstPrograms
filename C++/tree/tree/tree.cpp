
#include <stdio.h>
#include <tchar.h>
#include <iostream>
using namespace std;


typedef struct tree
{
	int key;
	tree * right;
	tree * left;
} *ptree;


void insert(int key,ptree *root)
{
	if (NULL==*root)
	{
		(*root)=new tree;
		(*root)->key=key;
		(*root)->left=NULL;
		(*root)->right=NULL;
	}
	else
	{
		if (key>(*root)->key)
			insert(key,&((*root)->right));
		else
			insert(key,&((*root)->left));
	}
}

void bypass(ptree root)
{
	if (NULL!=root)
	{
		bypass(root->left);
		cout<<root->key<<" ";
		bypass(root->right);
	}
}

bool search(int key,ptree root)
{
	if (NULL==root)//если уткнулись в пустоту видимо не нашли
		return false;
	if (root->key==key)//если нашли
		return true;
	if (root->key>key)
		return search(key,root->left);
	else
		return search(key,root->right);
}



int _tmain(int argc, _TCHAR* argv[])
{
	ptree root;
	root=NULL;
	for (int i=2; i<5; i++)
		insert(i,&root);
    bypass(root);
	return 0;
}

