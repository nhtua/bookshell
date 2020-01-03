# Kube-shell

My notebook for Kubernetes common commands set.

## Structure
I put all same-purposed `.sh` files into a directory. Usually, I name the script by its behavior and its order to execute. 

For example:


    ├── cluster
        ├── 00.install-master-node.sh
        ├── 01.add-worker-node.sh
        └── install-components.sh

To build up a K8s cluster, you should run `00.install-master-node.sh` first, then execute `01.add-worker-node.sh` respectively.

## Improvement

Almost of these scripts I hard-coded with my training environment on Google Cloud Platform.
It would be nice if you & me can customize it to have the ability to run anywhere. All your contribution & comments are welcome. 
I will spend time to improve it.

Right now, you should use this repo for learning purpose only. Don't use it for production if you're not sure what you are doing in Kubernetes.

Thank you!