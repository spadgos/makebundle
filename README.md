## MakeBundle

A series of Makefile targets for installing different dependencies for Twelve Factor apps.

### Background

When you're building a 12 Factor app, [one of the requirements](http://12factor.net/dependencies) is that all dependencies must be explicitly declared. That is, you shouldn't assume that there's any external executables available. If your application needs nodejs to run or build, then you need to explicitly declare that and make sure it's there all by yourself.

In this repo, we do cheat a little and assume a 'basic' *nix environment with core shell tools available (eg: `curl`, `make`), but apart from that everything is installed as needed.

Writing the code to install third party executables is not too difficult, though it is a little convoluted and can lead to a lot of copy-pasta across multiple projects.

This is where MakeBundle comes in.

MakeBundle provides a `Makefile` which can be referenced in your own project's `Makefile`. MakeBundle has a series of plugins, meaning you can easily pick and choose which bundle you need installed.

### Example

Assuming you have MakeBundle included in your project as a git submodule at `vendor/makebundle`, this is how it could be called from the project's `Makefile`

```Makefile
node:
	@NODE_VER=0.11.13 DESTDIR=$(PWD)/system TMP=$(PWD)/.tmp $(MAKE) --no-print-directory -C ./vendor/makebundle node
```

After executing `make node` this will install node 0.11.13 into `$(PWD)/system/usr/bin/node`, and you can then use it for other make recipes by adding it to your PATH like so:

```Makefile
build: node
	PATH=$(PWD)/system/usr/bin:$(PATH) node my-build-script.js
```

## Development

### Plugins

New bundles can be added by adding a new file into the `plugins` directory. Each should be a makefile which defines at least two targets: `install` and `help`. `help` should echo out some usage information about the environment variables the plugin requires.
