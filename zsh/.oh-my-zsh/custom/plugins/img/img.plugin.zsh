#!/usr/bin/env bash

set +euo pipefail

# authenticate and choose environment
k8a() {
	export AWS_PAGER="" 
	export AWS_PROFILE=ptc-gbl-identity 
	aws sts get-caller-identity || aws sso login
	which kubectl || brew install kubectl
}

k8e() {
	k8a
	ENVS=("dev" "staging" "prod")
	case $(printf "%s\n" "${ENVS[@]}" | fzf --header="Select an environment") in
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
	kubens | fzf --header="Select a namespace" | xargs kubens
}

# choose a pod
k8p() {
	kubectl get pods | fzf --header-lines=1 -1 | awk '{print $1}'
}

# choose a container from a pod
k8c() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	kubectl get pod "$POD" -o jsonpath='{range .spec.initContainers[*]}{.name}{"\n"}{end}{range .spec.containers[*]}{.name}{"\n"}{end}' | fzf --header="Pick a container"
}

# choose an image from all containers
k8i() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	kubectl get pod "$POD" -o jsonpath='{range .spec.initContainers[*]}{.image}{"\n"}{end}{range .spec.containers[*]}{.image}{"\n"}{end}' | sort | uniq | fzf --header="Pick an image" -1
}

# spin up a shell in a new container
k8sh() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	local -r IMAGE=$(k8i "$POD")
	kubectl debug "$POD" -it --image="$IMAGE" -- sh
}

# delete a pod
k8delete() {
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	kubectl delete pod "$POD"
}


# start a shell in an existing container
k8exec() {
	k8e
	if [[ -z $1 ]]; then
		local -r POD=$(k8p)
	else
		local -r POD=$1
	fi
	local -r CONTAINER=$(k8c "$POD")
	kubectl exec "$POD" -it -c "$CONTAINER" -- sh
}

# plus-api REPL
k8repl() {
	k8e
	if [[ -z $1 ]]; then
		local -r POD=$(kubectl get pods | tail -n 1 | awk '{print $1}')
	else
		local -r POD=$1
	fi
	kubectl exec "$POD" -it -c worker -- sh -c 'npm run repl'
}

# describe
k8describe() {
	k8p | xargs -I _ kubectl describe pods/_
}

# follow logs
k8logs() {
	k8e
	local -r POD=$(k8p)
	local -r CONTAINER=$(k8c "$POD")
	kubectl logs -f -c "$CONTAINER" "$POD"
}

k8stern() {
	# k8e
	local -r POD=$(kubectl get pods | tail -n 1 | awk '{print $1}')
	local -r CONTAINER=$(k8c "$POD")
	stern . -c "$CONTAINER" -e "\/health" --template '{{color .PodColor .PodName}} {{color .ContainerColor .ContainerName}} {{with $m := .Message | tryParseJSON}} [{{$m.level}}] {{$m.timestamp}} {{"\n"}} {{"  "}} {{json $m | extjson}} {{else}} {{.Message}} {{end}}{{"\n"}}' #--tail 1
	# stern . -c "$CONTAINER" -o ppextjson	
}

