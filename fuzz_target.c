#include <unistd.h>
#include <string.h>
#include <stdio.h>

void check_condition1(char *buffer) {
    if (strncmp(buffer, "7/4", 3) == 0) {
        puts("Condition 1 met");
    }
}

void check_condition2(char *buffer) {
    if (strncmp(buffer + 3, "2a8", 3) == 0) {
        puts("Condition 2 met");
    }
}

void trigger_crash(char *buffer) {
    int *null = 0;
    if (strncmp(buffer, "7/42a8", 6) == 0) {
        int i = *null;  // This will cause a crash
    }
}

int main(int argc, char *argv[]) {
    char buffer[7] = {0};  // Increased size by 1 for null terminator

    fgets(buffer, sizeof(buffer), stdin);

    check_condition1(buffer);
    check_condition2(buffer);
    trigger_crash(buffer);

    puts("No problem");
    return 0;
}