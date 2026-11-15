# behold-sandbox

A test repository for [behold](https://github.com/INTENTIUS/behold)'s pull request action and its GitHub Pages template. It holds a small Terraform example and the workflows that exercise those two. Nothing here is ever applied, and no provider credentials are needed.

## What is in it

- `core/` and `app/` are two Terraform roots made of `random`, `null` and `local` resources that refer to each other, so behold has edges to draw.
- `.github/workflows/behold.yml` runs [`INTENTIUS/behold-action`](https://github.com/INTENTIUS/behold-action) on each pull request.
- `.github/workflows/behold-pages.yml` is behold's Pages template. It publishes the graph of this repository to GitHub Pages on each push to `main`.
- `.github/workflows/limits.yml` and `scripts/gen-mermaid.mjs` measure what GitHub renders and accepts: Mermaid size in a comment and a job summary, the comment length limit, and image attachment with a workflow token.

Pull requests here change one or two resources on purpose. Their comments and runs are the evidence recorded on the behold issues that name this repository.

The pull request from branch `limits-scratch` only receives the test comments of the limits workflow.
