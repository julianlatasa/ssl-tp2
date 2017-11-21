#ifndef SEMANTIC_H_INCLUDED
#define SEMANTIC_H_INCLUDED

void do_read(const char* id_name);
void do_write(const char* id_name);
void do_assign(const char* id_name, const char* temp_id);
char * do_operation(char * operation, char * param1, char * param2);
int declared_id(const char *id_name);
void add_semantic_error();
int semantic_error();

#endif // SEMANTIC_H_INCLUDED