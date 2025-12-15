# Production Container Builds with Actions

This repo contains example builds and actions for deliverying container images which address common production concerns.

It is intended to demonstrate how to:
 - do a multistage build with a distroless Chainguard images
 - push built images and artifacts to a registry
 - handle multi-arch builds
 - pin images and actions to digests
 - sign images with cosign
 - keep images and actions up-to-date via [renovate](https://github.com/renovatebot)

The repo contains the following:

 - A very simple Go application (nothing much to see here)
 - A [Dockerfile](./Dockerfile) for building the application
 - A [cross.Dockerfile](./cross.Dockerfile) showing how to cross compile
 - A [cross-xx.Dockerfile](./cross-xx.Dockerfile) showing how to leverage xx tools to help with cross compilation
 - A [versioned.Dockerfile](./versioned.Dockerfile) showing updating of an image with semver version
 - [GitHub Actions](./.github/workflows) for building, pushing and signing the image
   - variants for compiling multistage builds with [QEMU](./.github/workflows/build-and-push-qemu.yaml), [cross-compilation](./.github/workflows/build-and-push-cross.yaml) and [dedicated runners](./.github/workflows/build-and-push-runners.yaml)
 - [Renovate GitHub Action](./.github/workflows/renovate.yaml) which keeps the images and actions up-to-date and pinned with digests. The action uses [Octo STS](https://github.com/apps/octo-sts) to avoid the need for a PAT.

Both the Actions and Dockerfiles are intended to be a good starting point for creating your own.

This repo was originally created for the Cloud Native Rejekts talk [Images Bite Back](https://www.youtube.com/watch?v=9c6HYM7YAe8).
