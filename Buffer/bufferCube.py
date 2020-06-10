import random
import os
BUFFERSIZE = 10
moves = ['R', 'U', 'L', 'D', 'F', 'B']

def generateBuffer():
    buffer = ['blank']*BUFFERSIZE
    for i in range(BUFFERSIZE):
        buffer[i] = moves[random.randint(0,5)]
    return buffer

def incrementBuffer(buffer): 
    os.system('cls' if os.name == 'nt' else 'clear')
    for i in range(BUFFERSIZE - 1):
        buffer[i] = buffer[i+1]
    buffer[BUFFERSIZE - 1] = moves[random.randint(0,5)]

def main():
    done = False
    buffer = generateBuffer()
    while not done:
        print(buffer)
        x = input()
        if x == 'done' or x == "Done" or x == "DONE":
            done = True
        incrementBuffer(buffer)

if __name__ == "__main__":
    main()

