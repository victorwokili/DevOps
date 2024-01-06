#!/bin/bash

# Set the namespace where Longhorn is installed
LONGHORN_NAMESPACE="longhorn-system"
helm uninstall longhorn --namespace $LONGHORN_NAMESPACE --no-hooks --timeout 3m
kubectl -n $LONGHORN_NAMESPACE patch -p '{"value": "true"}' --type=merge lhs deleting-confirmation-flag

# Uninstall Longhorn using Helm
echo -e "\nUninstalling Longhorn...\n"

for crd in $(kubectl get crd -o name | grep longhorn); do kubectl patch $crd -p '{"metadata":{"finalizers":[]}}' --type=merge; done;
echo -e "\nDeleting remaining Longhorn resources...\n"
echo -e "\n \n Deleting all ..."
kubectl delete all --all --namespace=$LONGHORN_NAMESPACE
echo -e "\n \n Deleting pvc ..."
kubectl delete pvc --all --namespace=$LONGHORN_NAMESPACE

#Delete the Longhorn namespace
echo -e "Deleting the Longhorn namespace..."
kubectl delete namespace $LONGHORN_NAMESPACE

# Confirmation message
echo -e "\n\nLonghorn has been uninstalled and all associated resources have been deleted.\n\n"
