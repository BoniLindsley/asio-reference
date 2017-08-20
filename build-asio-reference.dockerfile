# Basic usage:
#
# ```sh
# # Turn a dockerfile into an image.
# docker build \
#   --file $dockerfile_path \
#   --tag $image_tag \
#   .    # Note that . at the end.
# # Start a container using the image.
# sudo docker run \
#   --interactive \
#   --rm
#   --tty \
#   $image_tag
# ```
#
# To see the output locally, use a persistent volume.
# This can be done by adding a `--mount` option to `docker run` above.
#
# ```sh
# --mount type=volume,src=asio-src,target=/src/asio
# ```
#
# Send SIGINT (`c-c`) when the script asks for an upload target.
# The output is already created at that point.
# Check where the volume is stored locally.
#
# ```sh
# sudo docker volume inspect asio-src
# ```
#
# The output should be stored inside `asio/src/doc/html`.

# ### Base image

# For a list of tags, see:
# https://github.com/docker-library/official-images/blob/master/library/debian
FROM debian:buster-slim

# ### Install dependencies.

# Make the package manager non-interactive.
ENV DEBIAN_FRONTEND=noninteractive
# Update the package list.
RUN apt-get update
# The actual installation. Package list:
#
#   * ca-certificates - for cloning Asio Git repository via https.
#   * doxygen - Documentation is built using Doxygen.
#   * git - For cloning the Asio Git repository when it is not detected.
#           And for uploading the output.
#
RUN apt-get install \
      --assume-yes \
      --no-install-recommends \
      ca-certificates \
      doxygen \
      git
# Clean up the cache from installations.
RUN apt-get autoremove \
      --assume-yes \
      --option APT::AutoRemove::SuggestsImportant=true \
      --purge
RUN apt-get clean

### Persistent storage

# Specify a volume to store the result.
VOLUME /src/asio
# The container will start in the (possibly to-be) Asio source directory.
WORKDIR /src/asio

### Custom set up for the build.

# Copy the build script into the container.
COPY ./bin/build-asio-reference /bin/build-asio-reference

CMD /bin/build-asio-reference
