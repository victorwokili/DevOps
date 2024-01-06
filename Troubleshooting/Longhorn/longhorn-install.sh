#!/bin/bash
echo -e "\n
before installing, ensure nothing longhorn related is running, feel free to use the longhorn-install script\n"
echo -e "\n\nNow installing\n\n"
kubectl create namespace longhorn-system
helm install longhorn longhorn/longhorn --namespace longhorn-system
echo -e "\n\nInstallation Complete\n"
