# Developer Log

## 2024-10-26

**Objective**: Create a simple Express JS app with fancy looking html file (SPA). If possible build it into a unikernel \
**Task**:

-   Do `npm init`
-   Do `npm install express`
-   Create `index.html`. add some cool design to it
-   Test the app see if it works to do `GET` in browser or even in Postman
-   (Optional) CRUD Capabilities

**Next Steps**: Implement Unikraft to exisiting app \
**Note**: - \

## 2024-10-29

**Objective**: Implement Unikraft to exisiting app, build into an unikernel \
**Task**:

-   Do `Kraftfile` and read docs
-   Do `Dockerfile` and read docs
-   Build the Unikernel
-   Fix the process if there's any problem

**Next Steps**: Add Notes and Comments for Readers | Find Benchmarking for Unikernel \
**Note**: There is a problem on downloading on `ca-certifactes` and `tzdata`, sometimes it work and don't. I add some retry 3 times to handle this issue. | Hope it ain't gonna take while :) to find the Benchmark

## 2024-12-2

**Objective**: Optimize Unikraft App

**Task**:

-   Find similiar node version as `eyeberg/node:20.5.0`
-   Optimized Kraftfile and Dockerfile configs

**Next Steps**:

**Note**: It turns out, I don't need to use `kraft build` to create a Unikraft Unikernel instead `kraft pkg` works too with minimal. But there something that I still don't understand. At the moment I'll be using my stable setup.
