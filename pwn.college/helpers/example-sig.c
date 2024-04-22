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
    int npfd, i, soutfd;
    FILE *outf;
    char *cmds[2][4] = {{"/challenge/embryoio_level138", NULL, NULL, NULL}, {"/usr/bin/python", "signalh.py", colors[1], NULL}};

    create_fifo("pipe1", colors[4]);

    pid = syscall(39);
    printf("%sParent %i.\n", colors[4], (int)pid);

    for (i=0; i<2; ++i) {
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
                npfd = syscall(2, "pipe1", 01, 0666);
                fprintf(outf, "%sDup pipe1 to stdin.\n", colors[i]);
                syscall(33, npfd, 1);
                fprintf(outf, "%sClose old pipe1.\n", colors[i]);
                syscall(3, npfd);
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

    while ((pid = syscall(61,  -1, NULL, 0, NULL)) > 0) {
        printf("%sChild %i terminated.\n", colors[4], (int)pid);
    }

    return 0;
}
