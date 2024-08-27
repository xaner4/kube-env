# KubeEnv

Streamline your Kubernetes environment setup with ease.
KubeEnv automates the download and unpacking of all necessary binaries for operating a Kubernetes cluster.

## How to 

There is multple ways of using this kubernetes environment. 
You can use the script to download all the binary locally or you can use the container image to run it through podman
### Local download

1. Make scripts executable
```bash
$ chmod u+x kubeenv.sh
```

2. Download binaries
```bash
$ ./kubeenv.sh
```

3. Make binaries executebla
```bash
$ chmod -v +x ./bin/*
```

4. Move binaries from ./bin/ to PATH:
```bash
$ mv -v ./bin/* /usr/local/bin/
```

### Podman

#### Linux & Mac

1. Install Podman
    - https://podman.io/docs/installation
2. Add podman alias
```bash
$ alias p="podman run --privileged -it -v ~/.kube/:/root/.kube/ --rm --name kubepod ghrc.io/xaner4/kubepod:latest"
```
3. Run kubernetes commands from container
```bash
$ p kubectl version
```

or login to container to run directly from Ubuntu environment.
```bash
$ p bash
```
