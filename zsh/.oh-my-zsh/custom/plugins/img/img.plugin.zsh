#!/usr/bin/env bash

set +euo pipefail

# authenticate and choose environment
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
	which kubens || brew install kubectx
	kubens "team-athlete"
	which kubectl || brew install kubectl
}

# choose a pod
k8p() {
	kubectl get pods | fzf --tac -1 | awk '{print $1}'
}

# choose a container from a pod
k8c() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	kubectl get pod "$POD" -o jsonpath="{range .spec['containers','initContainers']}{[*].name}{\"\n\"}{end}" | fzf -1
}

# choose an image from all containers
k8i() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	kubectl get pod "$POD" -o jsonpath="{range .spec['containers','initContainers']}{[*].image}{\"\n\"}{end}" | uniq | fzf -1
}

# create an interactive shell
k8sh() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	local -r IMAGE=$(k8i "$POD")
	kubectl debug "$POD" -it --image="$IMAGE" -- sh
}

# describe
k8d() {
	k8p | xargs -I _ kubectl describe pods/_
}

# follow logs
k8lf() {
	local -r POD=$(k8p)
	local -r CONTAINER=$(k8c "$POD")
	kubectl logs -f -c "$CONTAINER" "$POD"
}

# previous logs
k8lc() {
	local -r POD=$(k8p)
	local -r CONTAINER=$(k8c "$POD")
	kubectl logs "$POD" -c "$CONTAINER" -p
}
