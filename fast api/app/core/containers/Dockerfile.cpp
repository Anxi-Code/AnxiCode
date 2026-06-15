## C++ docker file 

#uses light compiler
FROM alpine:latest

#uses only g++
RUN apk add --no-cache g++

# working dir 
WORKDIR /sandbox

# compile and run
CMD ["sh", "-c", "g++ -o program main.cpp && ./program"]