// Usage:
// npx --loglevel=error jscodeshift src --ignore=node_modules \
// --transform ~/dotfiles/transform-remove-comments.js \
// --parser=tsx --extensions=tsx,ts,js
export default function transformer(file, api) {
  const jscodeshift = api.jscodeshift;

  const source = jscodeshift(file.source)
    .find(jscodeshift.TemplateElement)
    .forEach((path) => {
      // Remove comments in template literals
      for (const regex of [/(\/\/.*)/gi, /\/(\*.*\*)\//g]) {
        path.value.value.raw = path.value.value.raw.replaceAll(regex, "");
      }
      return path;
    })
    .toSource();

  return jscodeshift(source)
    .find(jscodeshift.Comment)
    .forEach((path) => path.prune())
    .toSource();
}
