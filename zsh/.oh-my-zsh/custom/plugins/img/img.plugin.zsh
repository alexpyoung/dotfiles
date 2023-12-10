#!/usr/bin/env bash

set +euo pipefail

# authenticate
k8a() {
	AWS_PROFILE=ptc-gbl-identity aws sso login
	ENVS=("dev" "staging" "prod")
	case $(printf "%s\n" "${ENVS[@]}" | fzf) in
		dev)
			aws eks update-kubeconfig --region=us-east-1 --name=dev-0002 --profile ptc-gbl-ncsadev-admin
			;;
		staging)
			aws eks update-kubeconfig --region=us-east-1 --name=stg-0002 --profile ptc-gbl-ncsastaging-admin
			;;
		prod)
			aws eks update-kubeconfig --region=us-east-1 --name=prod-0002 --profile ptc-gbl-ncsaprod-admin
			;;
	esac
	which kubens || brew install kubectl
	kubens "team-athlete"
}

# choose a pod via fzf
k8p() {
	kubectl get pods | fzf --tac | awk '{print $1}'
}

# choose a container from a pod via fzf
k8c() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	kubectl get pod "$POD" -o jsonpath="{range .spec['containers','initContainers']}{[*].name}{\"\n\"}{end}" | fzf
}

k8d() {
	k8p | xargs -I _ kubectl describe pods/_
}

k8lf() {
	POD=$(k8p)
	CONTAINER=$(k8c "$POD")
	kubectl logs -f -c "$CONTAINER" "$POD"
}

k8lp() {
	POD=$(k8p)
	CONTAINER=$(k8c "$POD")
	kubectl logs -p -c "$CONTAINER" "$POD"
}
