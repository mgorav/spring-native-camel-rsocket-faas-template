# OpenFaas Template for Spring Boot

This is an OpenFaas template, which provides following environments:

- spring boot
- RSocket
- jdk 11
- apache camel
- apache kafka

Write your business loginc in function, i.e. just provide implementation of RequestHandler. By DI, the implementation
relayed to the function fromREST class.

Hence, just code, function - RequestHandler, DO NOT worry about the docker,k8s etc.



