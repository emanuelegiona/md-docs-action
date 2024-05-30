# md-docs-action
GitHub Action for building Markdown documentation and publishing to GitHub Pages

## Rationale

In many software projects, maintaining documentation that is both well-written and easily accessible 
often proves to be a daunting task.

Luckily several automated tools come in aid during this important step, also with the help of source 
code comments formatted accordingly.
However, the generated documentation has an outdated look, more often than not, and sometimes depeer 
information from the build system is necessary.

This GitHub Action aims at supporting drafting code documentation that is both visual appealing and 
also applicable to user manuals written in Markdown.
Based on [md-manual-template][templ-repo] by LibreSolar, this action simply adapts the original Travis-CI 
workflow into a GitHub Action.

Documentation is built as static HTML and served through GitHub Pages from the `gh-pages` branch in the 
same repository this workflow is executed from.
A PDF output is also provided onto the same branch.

## Usage guidelines

**Repository requirements**

There are a few requirements for the successful execution of this workflow.

1. A directory storing named `manual` must be located in the repository root.

2. A directory named `images` must be located in the `manual` directory.

    If empty, this directory shall be preserved during `git clone` or similar operations; it is thus advised to place a `.gitkeep` file in it.

3. Documentation source files (in Markdown format, `.md`) must be stored in the `manual` directory.

    Files will be processed in alphabetical order.

4. A `metadata.yml` file must be located in the `manual` directory.

    See [`metadata.yml`][metadata-url] contents from the template for more details.

**Workflow definition and requirements**

This action may be invoked without additional parameters. 

See below for optional inputs or see [action.yml](./action.yml) for default values.

```yaml
- uses: emanuelegiona/md-docs-action@v1
```

**Inputs**

- `template-repo` (_Optional_)

    Documentation template to use, in the format _username/repositoryname_.

    See [actions/checkout][gha-checkout] (parameter `repository`) for more details.

- `template-ver` (_Optional_)

    Documentation template version, as a valid reference (branch, tag, or SHA) within the selected repository.

    See [actions/checkout][gha-checkout] (parameter `ref`) for more details.

- `token` (_Optional_)

    Personal access token (PAT) used to fetch the repository and publish to its gh-pages branch.

    By default, it uses `GITHUB_TOKEN` from the invoking workflow; any token passed as argument should have write permissions on the repository.

## Example

Create a file named `make-docs.yml` in your repository's `.github/workflows` directory:

```yaml
name: Publish docs to GitHub Pages

# Launch manually from the Actions tab (different triggers may be used too)
on:
  workflow_dispatch:

# Set permissions for GITHUB_TOKEN (default value in action; different tokens may be used too)
permissions:
  contents: write
  pages: write
  id-token: write

# Do not allow multiple concurrent runs, without canceling ongoing ones
concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  docs-to-gh-pages:
    runs-on: ubuntu-latest
    name: Documentation to GH Pages
    steps:
      - uses: emanuelegiona/md-docs-action@v1
```

## License

**Copyright (c) 2024 Emanuele Giona**

This repository, scripts and snippets themselves are distributed under [MIT license][license].

**Diclaimer: `md-manual-template` is developed by LibreSolar, thus its owner, and distributes it under the CC-BY-SA-4.0 license.**



[templ-repo]: https://github.com/LibreSolar/md-manual-template
[gha-checkout]: https://github.com/actions/checkout
[metadata-url]: https://github.com/emanuelegiona/md-manual-template/blob/master/manual/metadata.yml
[license]: ./LICENSE
