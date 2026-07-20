#!/usr/bin/env bash
# Sync GitHub profile header (website + bio) to match kimkao.dev.
# Requires: gh auth with the `user` scope.
#
# One-time setup if PATCH /user returns 404:
#   gh auth refresh -h github.com -s user,read:user,repo,gist,read:org
#
set -euo pipefail

BLOG="${BLOG:-https://kimkao.dev}"
BIO="${BIO:-Continuous Architecture · DDD · Event Storming · SA Manager @ AWS}"
TWITTER="${TWITTER:-yikaikao}"

echo "Updating authenticated user profile..."
if ! gh api user -X PATCH \
  -f "blog=${BLOG}" \
  -f "bio=${BIO}" \
  -f "twitter_username=${TWITTER}" \
  --jq '{login,name,blog,bio,twitter_username,company,location}'; then
  echo ""
  echo "Failed. Your gh token likely lacks the 'user' scope."
  echo "Run this (browser will open), then re-run this script:"
  echo "  gh auth refresh -h github.com -s user,read:user,repo,gist,read:org"
  exit 1
fi

echo ""
echo "Done. Pinned repositories cannot be set via public API — pin in the UI:"
echo "  https://github.com/humank"
echo "Recommended pins (drag to order):"
echo "  1. humank/ddd-practitioners-ref"
echo "  2. humank/genai-demo"
echo "  3. aws-samples/designing-cloud-native-microservices-on-aws  (if offered)"
echo "  4. humank/fargate-java-sample"
echo "  5. humank/coffeeshop-ddd-quarkus"
echo "  6. humank/build-dr-with-managed-services"
echo "  (or keep aggregate-canvas if you prefer design tools over DR)"
