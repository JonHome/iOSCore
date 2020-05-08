set -eo pipefail

echo 'git_tag='${git_tag}
echo 'podspec_version='${podspec_version}

export git_tag=$(git describe HEAD --abbrev=0 --tags)
export podspec_version=${git_tag:2}

pod lib lint --allow-warnings
pod trunk push --allow-warnings --verbose