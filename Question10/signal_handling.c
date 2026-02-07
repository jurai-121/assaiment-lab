#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void handle_sigterm(int sig) {
    printf("\nParent received SIGTERM (%d). Cleaning up and exiting gracefully.\n", sig);
    exit(0);
}

void handle_sigint(int sig) {
    printf("\nParent received SIGINT (%d). Saving state and exiting gracefully.\n", sig);
    exit(0);
}

int main() {
    pid_t pid1, pid2;

    // Register signal handlers
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    printf("Parent process running with PID: %d\n", getpid());

    // First child sends SIGTERM after 5 seconds
    pid1 = fork();
    if (pid1 == 0) {
        sleep(5);
        kill(getppid(), SIGTERM);
        exit(0);
    }

    // Second child sends SIGINT after 10 seconds
    pid2 = fork();
    if (pid2 == 0) {
        sleep(10);
        kill(getppid(), SIGINT);
        exit(0);
    }

    // Parent runs indefinitely
    while (1) {
        pause();  // Wait for signals
    }

    return 0;
}

