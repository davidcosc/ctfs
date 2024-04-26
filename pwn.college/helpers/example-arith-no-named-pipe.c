#include <unistd.h>
#include <stdio.h>
#include <string.h>


int pwncollege() {
    return 0;
}

int main() {
	int pid, i, pipefd[4][2], outfd, j;
        FILE *outf;
        char *cmds[4][3] = {{"/usr/bin/cat", NULL, NULL}, {"/challenge/embryoio_level139", NULL, NULL}, {"/usr/bin/cat", NULL, NULL}, {"/usr/bin/python", "arith.py", NULL}};

	pid = syscall(39);
        printf("Parent %i.\n", (int)pid);

	for (i=0; i<4; ++i) {
		syscall(293, pipefd[i], 0);
                printf("Create pipe %i %i.\n", pipefd[i][0], pipefd[i][1]);
	}

	for (i=0; i<4; ++i) {
		printf("Fork %i.\n", i);
		pid = syscall(57);

		if (pid == -1) {
			printf("Error create child %i.\n", i);
			syscall(60, 1);
		}
		else if (pid == 0) {
			pid = syscall(39);
        		printf("Child %i.\n", (int)pid);

			outfd =syscall(32, 1);
			printf("Child %i: Dup stdout to %i.\n", i, outfd);
			outf = fdopen(outfd, "w");
                        fprintf(outf, "Child %i: Get new stout fd file.\n", i);
			syscall(3, 1);
			fprintf(outf, "Child %i: Close old stdout.\n", i);

			for (j=0; j<4; ++j) {
				if (j==i || j==i-1 || (i==0 && j==3)) {
					continue;
				}
				syscall(3, pipefd[j][0]);
                		syscall(3, pipefd[j][1]);
				fprintf(outf, "Child %i: Close pipefd %i %i %i.\n", i, j, pipefd[j][0], pipefd[j][1]);
			}

			syscall(3, pipefd[i][0]);
			fprintf(outf, "Child %i: Close pipefd %i read end %i.\n", i, i, pipefd[i][0]);

			if (i > 0) {
				syscall(3, pipefd[i-1][1]);
                        	fprintf(outf, "Child %i: Close pipefd %i write end %i.\n", i, i-1, pipefd[i-1][1]);
			}

			if (i == 0) {
				syscall(3, pipefd[3][1]);
				fprintf(outf, "Child %i: Close pipefd %i write end %i.\n", i, 3, pipefd[3][1]);
				syscall(33, pipefd[3][0], 0);
				fprintf(outf, "Child %i: Dup pipefd %i read end %i to stdin.\n", i, 3, pipefd[3][0]);
				syscall(3, pipefd[3][0]);
                                fprintf(outf, "Child %i: Close old pipefd %i read end %i.\n", i, 3, pipefd[3][0]);
				syscall(33, pipefd[i][1], 1);
				fprintf(outf, "Child %i: Dup pipefd %i write end %i to stdout.\n", i, i, pipefd[i][1]);
				syscall(3, pipefd[i][1]);
                                fprintf(outf, "Child %i: Close old pipefd %i write end %i.\n", i, i, pipefd[i][1]);
			}

			if (i != 0) {
				syscall(33, pipefd[i-1][0], 0);
                                fprintf(outf, "Child %i: Dup pipefd %i read end %i to stdin.\n", i, i-1, pipefd[i-1][0]);
				syscall(3, pipefd[i-1][0]);
				fprintf(outf, "Child %i: Close old pipefd %i read end %i.\n", i, i-1, pipefd[i-1][0]);
                                syscall(33, pipefd[i][1], 1);
                                fprintf(outf, "Child %i: Dup pipefd %i write end %i to stdout.\n", i, i, pipefd[i][1]);
				syscall(3, pipefd[i][1]);
                                fprintf(outf, "Child %i: Close old pipefd %i write end %i.\n", i, i, pipefd[i][1]);
			}


			//sleep(300);

			//Execve args and env arrays must be NULL terminated
            		fprintf(outf, "Child %i: Exec %s.\n", i, cmds[i][0]);
            		fprintf(outf, "Child %i: Closing stdout file before exec.\n", i);
            		syscall(3, outfd);
            		syscall(59, cmds[i][0], cmds[i], NULL);
            		perror("Execve error. Exit child.");
            		syscall(60, 1);
		}
	}

	for (i=0; i<4; ++i) {
		syscall(3, pipefd[i][0]);
		syscall(3, pipefd[i][1]);
		printf("Close pipefd %i %i.\n", pipefd[i][0], pipefd[i][1]);
	}

	while ((pid=syscall(61, -1, NULL, 0, NULL)) > 0) {
		printf("Child %i terminated.\n", (int)pid);
	}
}
