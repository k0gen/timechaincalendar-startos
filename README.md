<p align="center">
  <img src="icon.png" alt="Project Logo" width="21%">
</p>

# Timechain Calendar for StartOS

[Timechain Calendar](https://timechaincalendar.com) streams live Bitcoin network data. You can rewind and search the blocks, traveling backward through Bitcoin's history, as well as estimate blocks in the future. Calendar features will alert you to days of historical significance as they occur. This repository creates the `s9pk` package that is installed to run `Timechain Calendar` on [StartOS](https://github.com/Start9Labs/start-os/).

## Dependencies

Prior to building the `timechaincalendar` package, it's essential to configure your build environment for StartOS services. You can find instructions on how to set up the appropriate build environment in the [Developer Docs](https://docs.start9.com/latest/developer-docs/packaging).

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [deno](https://deno.land/)
- [make](https://www.gnu.org/software/make/)
- [start-sdk](https://github.com/Start9Labs/start-os/tree/sdk/core)
- [yq](https://mikefarah.gitbook.io/yq)

## Cloning

Clone the Timechain Calendar package repository locally.

```
git clone https://github.com/k0gen/timechaincalendar-startos.git
cd timechaincalendar-startos
```

## Building

To build the **Timechain Calendar** service as a universal package, run the following command:

```
make
```

Alternatively the package can be built for individual architectures by specifying the architecture as follows:

```
# for amd64
make x86
```
or
```
# for arm64
make arm
```

## Installing (on StartOS)

Before installation, define `host: https://server-name.local` in your `~/.embassy/config.yaml` config file then run the following commands to determine successful install:

> :information_source: Change server-name.local to your Start9 server address

```
start-cli auth login
#Enter your StartOS password
make install
```

**Tip:** You can also install the `timechaincalendar.s9pk` by sideloading it under the **StartOS > System > Sideload a Service** section.

## Verify Install

Go to your StartOS Services page, select **Timechain Calendar** and start the service.

**Done!**