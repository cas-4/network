# CAS4 network

<img src="https://avatars.githubusercontent.com/u/175958109?s=100&v=4" alt="Logo" align="right"/>

This repository refers to the network of the CAS-4 project of this organisation.
The following networking setup is a Kubernetes application which uses KubeEdge
to run some an application on simulated bare nodes.

This represents a orchestration of:

- [`cas-4/backend`](https://github.com/cas-4/backend)
- [`cas-4/frontend`](https://github.com/cas-4/frontend)

## Set up

You can run Kubernetes via Minikube or something else. For this project we
used KinD. If you install KinD do not forget to also install a Load Balancer for
Kubernetes: [Cloud Provider
KinD](https://kind.sigs.k8s.io/docs/user/loadbalancer/) is what we used.

Now, you can proceed to set up some environment variables:

- `JWT_SECRET`: the base64 version of the secret used for JWT tokens.
- `EXPO_ACCESS_TOKEN`: the base64 version of the [Expo](https://expo.dev) access token.
- `UNREALSPEECH_TOKEN`: the base64 version of the [Unrealspeech](https://unrealspeech.com/) access token.
- `RUST_LOG`: level of Rust logging.
- `VITE_API_URL`: url for the backend API.

Meanwhile the followings are setted up by default.

- `AUDIO_PATH`: "./assets"
- `ALLOWED_HOST`: "0.0.0.0:8000"

First of all you must create a new cluster for KinD. We need it for some worker
(let's say 4).

```
$ kind create cluster --config yaml/cluster/kind-cluster-config.yaml
```

After that just run the `run.sh` script.

```sh
$ ./run.sh apply
```

After that, you'll be able to see what the external IP for the load balancer is.

```
$ k get svc
NAME               TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
cas-service        LoadBalancer   10.96.25.163   172.18.0.3    80:30358/TCP   11m
```

For the IP above you can test if it works by a HTTP request.

```
$ curl -X POST http://172.18.0.3/graphql \
-H "Content-Type: application/json" \
-d '{
  "query": "mutation Login($input: LoginCredentials!) { login(input: $input) { accessToken tokenType userId } }",
  "variables": {
    "input": {
      "email": "info@cas-4.github",
      "password": "mysuperpassword"
    }
  }
}'
```

If you receive a network error you just need to wait until the
`cloud-provider-kind` works.
