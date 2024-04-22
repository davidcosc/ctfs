#include <unistd.h>
#include <stdio.h>
#include <string.h>

int pwncollege() {
    return 0;
}

int create_fifo(char *pipe, char *color) {
    if (access(pipe, F_OK) == 0) {
        printf("%sNamed pipe %s already exists.\n", color, pipe);
    } else {
        printf("%sCreate named pipe %s using mknod.\n", color, pipe);
        syscall(133, pipe, 0010000 | 0644, 0);
    }
}

int main(int argc, char *argv[]) {
    char *colors[5] = {"\033[0;32m", "\033[0;33m", "\033[0;34m", "\033[0;35m", "\033[0;0m"};
    pid_t pid;
    int npfd, i, j, soutfd;
    FILE *outf;
    int pfd[2][2];
    char *cmds[4][4] = {{"/usr/bin/cat", NULL, NULL, NULL}, {"/challenge/embryoio_level139", NULL, NULL, NULL}, {"/usr/bin/cat", NULL, NULL, NULL}, {"/usr/bin/python", "arithmetich.py", colors[3], NULL}};

    create_fifo("pipe1", colors[4]);
    create_fifo("pipe2", colors[4]);

    pid = syscall(39);
    printf("%sParent %i.\n", colors[4], (int)pid);

    for (i=0; i<4; ++i) {
        if (i < 2) {
            printf("%sCreate pipe.\n", colors[4]);
            syscall(293, pfd[i], 0);
        }

        printf("%sFork.\n", colors[4]);
        pid = syscall(57);

        if (pid == -1) {
            perror("Fork failed. Exit child.");
            syscall(60, 1);
        }
        else if (pid == 0) {
            pid = syscall(39);
            printf("%sChild  %i %s.\n", colors[i], (int)pid, cmds[i][0]);

            // We do this to prevent any buffered output from messing with challenge stdin
            // after chaining childs stdins and outs.
            printf("%sDup stdout.\n", colors[i]);
            soutfd = syscall(32,1);
            outf = fdopen(soutfd, "w");

            if (i == 0) {
                fprintf(outf, "%sOpen pipe1.\n", colors[i]);
                npfd = syscall(2, "pipe1", 00, 0666);
                fprintf(outf, "%sDup pipe1 to stdin.\n", colors[i]);
                syscall(33, npfd, 0);
                fprintf(outf, "%sClose old pipe1.\n", colors[i]);
                syscall(3, npfd);
            }

            if (i == 2) {
                fprintf(outf, "%sOpen pipe2.\n", colors[i]);
                npfd = syscall(2, "pipe2", 01, 0666);
                fprintf(outf, "%sDup pipe2 to stdout.\n", colors[i]);
                syscall(33, npfd, 1);
                fprintf(outf, "%sClose old pipe2.\n", colors[i]);
                syscall(3, npfd);
            }

            if (i > 1) {
                for (j=0; j<i-1; ++j) {
                    fprintf(outf, "%sClose unused pipe[%i].\n", colors[i], j);
                    syscall(3, pfd[j][0]);
                    syscall(3, pfd[j][1]);
                }
            }

            if (i < 2) {
                fprintf(outf, "%sClose unused pipe[%i][0].\n", colors[i], i);
                syscall(3, pfd[i][0]);

                fprintf(outf, "%sDup pipe[%i][1] to stdout.\n", colors[i], i);
                syscall(33, pfd[i][1], 1);
                fprintf(outf, "%sClose old pipe[%i][1].\n", colors[i], i);
                syscall(3, pfd[i][1]);
            }

            if (i>0 && i<3) {
                fprintf(outf, "%sClose unused pipe[%i][1].\n", colors[i], i-1);
                syscall(3, pfd[i-1][1]);

                fprintf(outf, "%sDup pipe[%i][0] to stdin.\n", colors[i], i-1);
                syscall(33, pfd[i-1][0], 0);
                fprintf(outf, "%sClose old pipe[%i][0].\n", colors[i], i-1);
                syscall(3, pfd[i-1][0]);
            }

            //Execve args and env arrays must be NULL terminated
            fprintf(outf, "%sExec %s.\n", colors[i], cmds[i][0]);
            fprintf(outf, "%sClosing stdout file before exec.\n", colors[i]);
            syscall(3, soutfd);
            syscall(59, cmds[i][0], cmds[i], NULL);
            perror("Execve error. Exit child.");
            syscall(60, 1);
        }
    }

    for (i=0; i<2; ++i) {
        printf("%sClose unused pipe.\n", colors[4]);
        syscall(3, pfd[i][0]);
        syscall(3, pfd[i][1]);
    }

    while ((pid = syscall(61,  -1, NULL, 0, NULL)) > 0) {
        printf("%sChild %i terminated.\n", colors[4], (int)pid);
    }

    return 0;
}
