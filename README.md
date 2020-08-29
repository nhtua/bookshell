# bookshell

My notebook for common shell commands. You can use these scripts as the learning instructions step-by-step or automating scripts to do some specific purposes.

## Structure
I put all same-purposed `.sh` files into a directory. Usually, a script are named by its behavior and its order to execute. 

For example:


    ├── cluster
        ├── 00.install-master-node.sh
        ├── 01.add-worker-node.sh
        └── install-components.sh

To build up a K8s cluster automatically, you should run `00.install-master-node.sh` first, then execute `01.add-worker-node.sh` respectively.

## Improvement

Almost of these scripts I hard-coded with my training environment on Google Cloud Platform.
It would be nice if you & me customize it to have the ability to run anywhere. All your contributions & comments are welcome.

Right now, you should use this repo for learning purpose only. Don't use it for production if you're not sure what you are doing in Kubernetes.

Thank you!
