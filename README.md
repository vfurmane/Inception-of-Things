# Inception-of-Things

## Getting started

### Running the evaluation VM

The virtual machine files are stored in the *vm/* directory. Howevery, the *Vagrantfile* is in the root directory, which allows to simply run:

```sh
vagrant up
```

Wait a few minutes for the machine to be provisioned.

### Running each part

Each part contains a script to deploy (`./scripts/deploy-*.sh`) and clean (`./scripts/clean-*.sh`) the environment. For example, for the *p1*:

```sh
# Deploys the cluster
./scripts/deploy-cluster.sh

# Clean the deployed components
./scripts/clean-cluster.sh
```
