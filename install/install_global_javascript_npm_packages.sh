# Make global packages install locally (without sudo)
function create_npm_global_packages_directory() {
	# TODO: This is incompatible with nvm but under nvm, we don't need it
	# source "$HOME"/dotfiles/paths
	# mkdir -p "$NPM_GLOBAL_PACKAGES_DIRECTORY"
	# npm config set prefix "$NPM_GLOBAL_PACKAGES_DIRECTORY"
	echo NOOP
}

function install_global_javascript_npm_packages() {
	create_npm_global_packages_directory

	npm install --no-fund --location=global eslint lodash jshint typescript ts-node prettier \
		http-server http-server-spa json-server depcheck npm-check-updates prettier sort-package-json \
		babel-cli pm2 firebase-tools deno \
		@aws-amplify/cli pa11y netlify-cli hygen react-native-cli serve \
		@zeplin/cli @zeplin/cli-connect-react-plugin @zeplin/cli-connect-swift-plugin \
		yo generator-office dts-gen yargs rollup  source-map-explorer \
		@angular/cli n json5 cordova gltf-pipeline depcheck @microsoft/rush wrangler \
		do-not-disturb-cli katex servor degit verdaccio tables gatsby-cli browser-sync \
		@apidevtools/swagger-cli kill-port-process ngrok @google/clasp js-beautify doctoc \
		ts_dependency_graph syncpack @openai/codex @anthropic-ai/claude-code @immich/cli

	# Disable 'npm fund' messages
	npm config set fund false
}
