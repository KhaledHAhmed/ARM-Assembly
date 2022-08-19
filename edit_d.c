#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "edit_distance.h"

/*  Suggestions
- When you work with 2D arrays, be careful. Either manage the memory yourself, or
work with local 2D arrays. Note C99 allows parameters as array sizes as long as
they are declared before the array in the parameter list. See:
https://www.geeksforgeeks.org/pass-2d-array-parameter-c/

Worst case time complexity to compute the edit distance from T test words
to D dictionary words where all words have length MaxLen:
Student answer:  Theta(T*D)

*/

/* You can write helper functions here */

int min(int num1, int num2)
{
	return (num1 > num2 ) ? num2 : num1;
}

int edit_distance(char * first_string, char * second_string, int print_table){

	int i ,j;
	int row = strlen (first_string) + 1;   // the row length
	int col = strlen (second_string) + 1;  // the col length
	int sol [row] [col];


	sol [0][0]=0;

	for(i=0 ; i<row ; i++){
		for(j=0; j<col ; j++){

			if (i==0 && j==0){
				sol [0][0]=0;
			}
			else if (i==0){
				sol[i][j] = j;
			}
			else if (j==0){
				sol[i][j] = i;
			}
			else{
				int temp = min (1+ sol[i-1][j], 1+ sol[i][j-1]);
				if (first_string[i-1] == second_string[j-1]){
					sol[i][j] =   min (temp , sol [i-1][j-1]);
				}
				else{
					sol[i][j] =   min (temp , 1+ sol [i-1][j-1]);
				}
			}
		}
	}

	if (print_table == 1){

		printf("\n");
		printf("%2c|", ' ');
		printf("%3c|", ' ');

		for(j=0; j<col-1; j++){

			printf("%3c|", second_string[j]);
		}

		printf("\n");
		printf("---");
		for(j=0; j<col*4 ; j++){
			printf("-");
		}
		printf("\n");

		for(i=0 ; i<row ; i++){
			if (i==0){
				printf("%2c|", ' ');
			}
			else{
				printf("%2c|", first_string[i-1]);
			}

			for(j=0; j<col ; j++){
				printf("%3d|", sol[i][j]);
			}
			printf("\n");
			printf("---");
			for(j=0; j<col*4 ; j++){
				printf("-");
			}
			printf("\n");
		}
		printf("\n");
	}
	else {

	}
	return  sol[row-1][col-1];
}

char** read_file(char ** Table, char* filename, char* name){
	FILE * fp;
	char line [101];
	char * token;
	char *mode="r";
  int l;
	int i=0;



	fp=fopen(filename,mode);

	if (fp==NULL){
		printf("File not found\n");
	}
	else{
		printf("Loading the %s file: %s\n", name,filename);
		Table=malloc(sizeof(char*));
		fgets(line,101,fp);
		token=strtok(line,"\n");
		l = stoi(token);
		Table[l][50];
		while(fgets(line,101,fp)!= NULL){
			token=strtok(line,"\n");
			Table[i]=malloc(sizeof(char)*(strlen(token)+1));
			strcpy(Table[i],token);
			i=i+1;
			//Table=realloc(Table, sizeof(char*)*(i+1));

		}
		fclose(fp);

	}

	return Table;
}

void free_fun(char** Table, int n){
  int i;
  for (i=0; i <= n;i++){
    free(Table[i]);
  }
  free(Table);
}

void spellcheck(char * dictname, char * testname){

	char ** Dictionary;
	char ** Test;
	int i,j;


	Dictionary = read_file(Dictionary,dictname,"dictionary");
	Test = read_file(Test, testname,"test");

	int num_dic = atoi(Dictionary[0]);
	int num_test = atoi(Test[0]);

	int distance [num_dic];
	distance [0] = -1;

	for(i=1 ; i <= num_test ; i++){
			int min_distance=10;
		printf("\n------- Current test word: %s\n", Test[i] );

		for(j=1; j <= num_dic ; j++){
			 	distance [j] = edit_distance(Dictionary[j], Test[i], 0);
				if (distance [j] < min_distance){
					min_distance = distance [j];
				}
		}

		printf("Minimum distance: %d\n", min_distance);
		printf("Words that give minimum distance:\n");
     	for(j=1; j <= num_dic ; j++){
				if (distance [j] == min_distance){
					printf("%s\n", Dictionary[j]);
				}
			}

	}
free_fun(Dictionary, num_dic);
free_fun(Test, num_test);
}
