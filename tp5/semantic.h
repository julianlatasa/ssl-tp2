#ifndef SEMANTIC_H_INCLUDED
#define SEMANTIC_H_INCLUDED

void do_read(const char* id_name);
char * do_operation(char * operation, char * param1, char * param2);
void add_semantic_error();
int semantic_error();

#endif // SEMANTIC_H_INCLUDED