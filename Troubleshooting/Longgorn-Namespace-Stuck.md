# Longhorn Namespace Stuck Terminating - Delete Longhorn from Kubernetes Cluster

## Official Documentation on how to delete Longhorn from Kubernetes Cluster. If I have read this before trying to delete longhorn, I would have two more hours of my life, so please do yourself a favor 😒.

So, I recently tried to delete Longhorn, a cloud native distributed block storage, from one of my Kubernetes clusters and did it wrong. My error was to delete the longhorn resources without deleting the PVCs first. And even after deleting the PVCs Custom resource definitions they were still there. Since this cost me some time to debug and longhorn is pretty popular, I thought it would be a good idea to write a few words about this.

1. List the error messages and check the `longhorn-system` namespace state `kubectl get namespace longhorn-system -o json`. I got an error message saying:

```"message": "Some resources are remaining: engineimages.longhorn.io has 1 resource instances, engines.longhorn.io has 2 resource instances, nodes.longhorn.io has 3 resource instances, replicas.longhorn.io has 6 resource instances, sharemanagers.longhorn.io has 2 resource instances, volumes.longhorn.io has 2 resource instances"``` ,

2. List the remaining resources. kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n longhorn-system This command does take a while to finish, but afterwards I saw the 16 resources which were not deleted. The problem here is a deadlock in the finalizers of these resources. The finalizers are used to control the deletion of the resources. In my case, the finalizers waited for a condition to be met, but because I deleted some resources which were necessary for longhorn to work, the condition failed, and the finalizers were stuck.

3. My solution was to patch all the CRDs and delete the finalizers. This can be done with this command: `for crd in $(kubectl get crd -o name | grep longhorn); do kubectl patch $crd -p '{"metadata":{"finalizers":[]}}' --type=merge; done;` After executing the command, I rechecked the state of the longhorn-system namespace, and it was deleted.

For desperate googlers I also leave the error which I got after trying to reinstall longhorn in a Cluster with the namespace longhorn-system stuck in “Terminating”.


[Reference](https://avasdream.engineer/kubernetes-longhorn-stuck-terminating)
