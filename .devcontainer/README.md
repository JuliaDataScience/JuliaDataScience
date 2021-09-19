# .devcontainer

To build the JDS project with Docker (without VS Code), go to the root of the repository and run:

```
.devcontainer/build.sh
```

When the build is finished, run the project with:

```
.devcontainer/run.sh
```

And, if you want to use `serve`, use:

```
serve(; host="0.0.0.0")
```

to accept connections coming from outside of the container.
