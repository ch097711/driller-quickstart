# Driller Quickstart

This project provides a Docker environment to quickly test and get started with Driller.

## Getting Started

Follow these steps to set up and run the project:

1. Clone the repository and navigate to the project directory:
    ```sh
    git clone https://github.com/ch097711/driller-quickstart.git && cd ./driller-quickstart
    ```

2. Build the Docker image and run the container:
    ```sh
    docker build -t driller-quickstart . && docker run --name driller-quickstart -it --rm driller-quickstart
    ```
    This will start the fuzzing process. Let it run for a while.

3. Open another terminal and execute the following command to enter the container:
    ```sh
    docker exec -it driller-quickstart bash
    ```
    Once inside the container, run:
    ```sh
    python3 run_driller.py ./fuzz_target ./output/fuzzer-master/
    ```

After some time, AFL should discover crashes.