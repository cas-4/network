# CAS4 network

<img src="https://avatars.githubusercontent.com/u/175958109?s=100&v=4" alt="Logo" align="right"/>

This repository refers to the network of the CAS-4 project of this organisation.

## Set up

You can run Kubernetes via Minikube or K3s. After the installation (we suggest
you Minikube in this case) you have to set up the environment:

- `JWT_SECRET`: the base64 version of the secret used for JWT tokens.
- `EXPO_ACCESS_TOKEN`: the base64 version of the [Expo](https://expo.dev) access token.
- `UNREALSPEECH_TOKEN`: the base64 version of the [Unrealspeech](https://unrealspeech.com/) access token.
- `RUST_LOG`: level of Rust logging

After that just run

```sh
./run.sh apply
```
