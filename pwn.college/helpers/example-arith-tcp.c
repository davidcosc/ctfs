#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <netdb.h>
#include <sys/socket.h>

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
    //{"/challenge/embryoio_level142", NULL, NULL, NULL},
    char *cmds[3][4] = {{"/usr/bin/python", "arithmetich.py", colors[0], NULL}, {"", NULL}, {"", NULL}};
    int sockfd;
    int len = 1;
    struct sockaddr_in servaddr;
    char buf[1024];

    create_fifo("pipe1", colors[4]);
    create_fifo("pipe2", colors[4]);

    pid = syscall(39);
    printf("%sParent %i.\n", colors[4], (int)pid);

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("Open socket error. Exit child.");
        syscall(60, 1);
    }

    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    servaddr.sin_port = htons(1493);

    if (connect(sockfd, (struct sockaddr*)&servaddr, sizeof(servaddr)) != 0) {
        perror("Connect error. Exit child.");
        syscall(60, 1);
    }

    for (i=0; i<3; ++i) {
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

            if (*cmds[i][0] == '\0' && i == 1) {
                fprintf(outf, "%sOpen pipe2.\n", colors[i]);
                npfd = syscall(2, "pipe2", 01, 0666);

                while ((len=read(sockfd, buf, 1024)) > 0) {
                    write(npfd, buf, len);
                }

                fprintf(outf, "%sClose socket.\n", colors[i]);
                syscall(3, sockfd);
                fprintf(outf, "%sClose pipe2.\n", colors[i]);
                syscall(3, npfd);

                fprintf(outf, "%sExit child.\n", colors[i]);
                syscall(60, 1);
            }

            if (*cmds[i][0] == '\0' && i == 2) {
                fprintf(outf, "%sOpen pipe1.\n", colors[i]);
                npfd = syscall(2, "pipe1", 00, 0666);

                while ((len=read(npfd, buf, 1024)) > 0) {
                    write(sockfd, buf, len);
                }

                fprintf(outf, "%sClose socket.\n", colors[i]);
                syscall(3, sockfd);
                fprintf(outf, "%sClose pipe1.\n", colors[i]);
                syscall(3, npfd);

                fprintf(outf, "%sExit child.\n", colors[i]);
                syscall(60, 1);
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
