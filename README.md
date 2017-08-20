Asio-reference
==============

While Asio is preparing for inclusion into the C++ standard,
  its official generated documentation,
  even for its latest development branch,
  lags behind the `master` branch of the [Asio GitHub repo][] by months.
The [project site][Asio-reference] for this repo
  contains a more up-to-date version of the documentation.

Note that the generated reference is the default output from Doxygen.
So the documentation layout vastly differs from that of Boost.
However, the content should be the same.

Note also that this only builds the reference.


### Usage

```sh
# Turn a dockerfile into an image.
docker build \
  --file $dockerfile_path \
  --tag $image_tag \
  .    # Note that . at the end.
# Start a container using the image.
sudo docker run \
  --interactive \
  --rm
  --tty \
  $image_tag
```

To see the output locally, use a persistent volume.
This can be done by adding a `--mount` option to `docker run` above.

```sh
--mount type=volume,src=asio-src,target=/src/asio
```

Send SIGINT (`c-c`) when the script asks for an upload target.
The output is already created at that point.
Check where the volume is stored locally.

```sh
sudo docker volume inspect asio-src
```

The output should be stored inside `asio/src/doc/html` in the volume.

[Asio GitHub repo]: https://github.com/chriskohlhoff/asio/
[Asio-reference]: https://BoniLindsley.github.io/asio-reference
