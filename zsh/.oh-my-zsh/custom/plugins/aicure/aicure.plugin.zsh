#!/usr/bin/env zsh

source $HOME/Documents/fastlane_secrets

function apk() {
	local -r TOKEN=$1
	local -r FLAVOR=$2
	local -r DIR=/tmp/apk
	local -r ZIP="$DIR.zip"
	local -r APK="$DIR/app-$FLAVOR-debug.apk"

	local -r URL=$(curl -s -H "Accept: application/vnd.github.v3+json" -H "Authorization: Bearer $TOKEN" https://api.github.com/repos/aicure/ima_android/actions/artifacts | jq -r --arg flavor "$FLAVOR" '.artifacts | map(select(.name|contains($flavor))) | sort_by(.updated_at) | reverse | .[0].archive_download_url')

	echo "Downloading APK from $URL"
	curl -s -L -H "Authorization: Bearer $TOKEN" $URL -o $ZIP
	unzip -o $ZIP -d $DIR

	local -r DEVICE_ID=$(adb devices -l | fzf | cut -d' ' -f1)
	adb -s $DEVICE_ID install -r $APK
	echo "Successfully installed $APK onto $DEVICE_ID"

	rm -rf $ZIP
	rm -rf /tmp/apk
}

