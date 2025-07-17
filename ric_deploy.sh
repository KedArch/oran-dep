#!/usr/bin/env bash
export DIR=$(dirname $(realpath $0))
if [[ -z "$KUBECONFIG" ]]; then
export KUBECONFIG=$HOME/.kube/config
fi
cd $DIR
if [[ -z "$1" ]] || [[ "$1" == "-i" ]]; then
  ./smo-install/scripts/layer-0/0-setup-charts-museum.sh
  sudo KUBECONFIG=$KUBECONFIG bin/deploy-nonrtric -f nonrtric/RECIPE_EXAMPLE/example_recipe.yaml
elif [[ "$1" == "-u" ]]; then
  sudo KUBECONFIG=$KUBECONFIG bin/undeploy-nonrtric
  sudo pkill -f chartmuseum
  echo "May need to clean /tmp, and ~/.{config,cache,local/share}/helm"
else
  echo "Valid options for $(basename $0): '-i' or '-u'"
fi
