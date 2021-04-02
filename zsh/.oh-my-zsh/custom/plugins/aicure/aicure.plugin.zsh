#!/usr/bin/env zsh

if [[ -e $HOME/Documents/fastlane_secrets ]]; then
	# shellcheck disable=SC1090
	source "$HOME"/Documents/fastlane_secrets
fi

function apk() {
	local -r TOKEN=$1
	local -r FLAVOR=$2 # dev|intg|qa
	local -r DIR=/tmp/apk
	local -r ZIP="$DIR.zip"
	local -r APK="$DIR/app-$FLAVOR-debug.apk"

	local -r URL=$(curl -s -H "Accept: application/vnd.github.v3+json" -H "Authorization: Bearer $TOKEN" https://api.github.com/repos/aicure/ima_android/actions/artifacts | jq -r --arg flavor "$FLAVOR" '.artifacts | map(select(.name|contains($flavor))) | sort_by(.updated_at) | reverse | .[0].archive_download_url')

	echo "Downloading APK from $URL"
	curl -s -L -H "Authorization: Bearer $TOKEN" "$URL" -o $ZIP
	unzip -o $ZIP -d $DIR

	local -r DEVICE_ID=$(adb devices -l | fzf | cut -d' ' -f1)
	adb -s "$DEVICE_ID" install -r "$APK"
	echo "Successfully installed $APK onto $DEVICE_ID"

	rm -rf $ZIP
	rm -rf /tmp/apk
}

# Expects awscli to be configured with env profiles
function mobilelogs() {
	local -r env=${1:-'prod'} # Default to prod env
	local -r bucket="s3://$env-cd-non-phi-patient-data.aicure.com"
	local -r base="$bucket/non_phi/v2logs/"
	local -r client=$(aws --profile "$env" s3 ls "$base" | cut -c 32- | fzf)
	local -r patient=$(aws --profile "$env" s3 ls "$base$client" | cut -c 32- | fzf)
	local -r destination="/tmp/$client$patient"
	mkdir -p "$destination"
	aws --profile "$env" s3 cp --recursive "$base$client$patient" "$destination"
	find "$destination" -name '*.zip' > tmp
	# https://github.com/koalaman/shellcheck/wiki/SC2044
	while IFS= read -r archive; do
		unzip "$archive" -d "$(dirname "$archive")"
	done < tmp
	rm tmp
	printf "\ngrep path:\n%s\n" "$destination"
}

