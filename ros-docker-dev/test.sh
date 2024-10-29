GIT_LABEL="$(git branch --show-current | tr / -)"
if [[ -z "$GIT_LABEL" ]]; then
    echo "No branch found, using commit hash"
    GIT_LABEL="$(git rev-parse --short HEAD)"
fi

if [[ -z "$GIT_LABEL" ]]; then
    echo "No branch found, using commit hash"
    GIT_LABEL="latest"
fi