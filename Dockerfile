FROM debian:buster AS toolchain

RUN apt-get update && apt-get install -y clang curl git
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH "$PATH:/root/.cargo/bin"

FROM toolchain as shadow-create

RUN cargo install --git https://github.com/metajack/cargo-create-deponly-shadow
WORKDIR /foo
COPY . /foo
RUN cargo create-deponly-shadow --output-dir /shadow

FROM toolchain as build

WORKDIR /foo
COPY --from=shadow-create /shadow /foo
RUN cargo build --target-dir=/target

WORKDIR /
RUN rm -rf /foo
WORKDIR /foo
COPY . /foo
RUN cargo build --target-dir=/target

