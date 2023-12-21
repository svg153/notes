
# SonarQube

## SonarQube Scanner CLI

```bash
SONAR_URL="https://sonar.int.org.io"
SONAR_TOKEN="squ_"
YOUR_REPO="$(pwd)"

docker run \
    --rm \
    -e SONAR_HOST_URL="${SONAR_URL}" \
    -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=prod-api -Dsonar.projectBaseDir=api" \
    -e SONAR_LOGIN="${SONAR_TOKEN}" \
    -v "${YOUR_REPO}:/usr/src" \
    sonarsource/sonar-scanner-cli
```
