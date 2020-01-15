---
title: Schema support in editor
hide_sidebar: true
permalink: editor.html
folder: common
---

For your convenience we recommend using editor with YAML validation against JSON schema; you can point your editor to `docs/schema.json`. We can recommend [Visual Studio Code](https://code.visualstudio.com/)
with [redhat.vscode-yaml](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) plugin.
You need to edit settings file to map benchmark configuration files (with `.hf.yaml` extension) to the schema, adding
```
"yaml.schemas" : {
    "file:///path/to/hyperfoil-distribution/docs/schema.json" : "/*.hf.yaml"
},
```