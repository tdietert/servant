FROM ubuntu:xenial

RUN apt-get update && apt-get install -y tree libgmp-dev make build-essential nodejs curl libtinfo-dev zlib1g-dev npm

# node in path
RUN mkdir -p ~/.local/bin
ENV PATH /root/.local/bin:$PATH
RUN ln -s $(which nodejs) /root/.local/bin/node

# stack
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C ~/.local/bin '*/stack'

# ghcjs
ADD servant-client/test/ghcjs/stack-only-ghcjs.yaml /root/stack.yaml
WORKDIR /root/
RUN stack setup ; true
RUN stack exec -- ghcjs --version
RUN rm stack.yaml

# making hsc2hs available for ghcjs
RUN (cd .local/bin ; ln -s ../../.stack/programs/x86_64-linux/ghc-7.10.2/bin/hsc2hs)

# install servant-client dependencies
ADD servant-client/stack-ghcjs.yaml /root/servant-client/stack.yaml
ADD servant-client/servant-client.cabal /root/servant-client/
ADD servant/servant.cabal /root/servant/
ADD servant-server/servant-server.cabal /root/servant-server/
WORKDIR /root/servant-client/
RUN stack build --test --only-dependencies servant


RUN tree
RUN bark

COPY . /root/servant/
WORKDIR /root/servant/




RUN bark

CMD /root/servant/servant-client/test/ghcjs/run-tests.sh
