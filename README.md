# IUT Laravel
This repository is a starter giving you all tools you need to help you build your application with [Laravel](https://laravel.com) and PHP.

> Since this repository is for learning purpose, it is **not production ready**

## Requirements
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/download) with the [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) plugin
- Git

### Windows Requirements
- [WSL 2](https://learn.microsoft.com/fr-fr/windows/wsl/install)
- Ubuntu 24.04 installed from the [Microsoft Store](https://apps.microsoft.com/detail/9nz3klhxdjp5?hl=fr-fr&gl=FR)
- [Optional] [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701?hl=fr-FR&gl=FR)

> You can bypass the WSL 2 with Ubuntu but the app performance could be far lower than using Ubuntu

## Launch
### Reset the Git
Create a project named <TO_REPLACE> in your own GitHub then clone this one.

```shell
git clone dbroquin/iut-laravel
```

> If you are using Windows, make sure to clone this repository in a WSL2 Ubuntu 24.04 distro

Then, delete the `.git` directory at cloned repository root and follow the `or create a new repository on the command line` section showed by GitHub **excluding** the **first line**.

### Clean the project
Housekeeping time.

Delete the following files and directories
- .github
- dockerfile

### Start the environment
You can now start the environment using Docker Compose with the following command line from the project root

```shell
docker compose up -d
```

> This command line **MUST** be launched from your host using the Visual Studio Code **integrated terminal**

Once the command has been launched, you should see something similar in your terminal.

Also, a `laravel` directory should be present in the project tree now.

Finally, you can access the container terminal using the Visual Studio command palette and selecting

```shell
> Docker Containers: Attach Shell
iut-laravel
iut:latest
```

### Create the project root
Your Laravel app code **must** be present in the `laravel` directory. Use the following command lines to initiate it

```shell
cd laravel
composer create-project laravel/laravel .
```

This command will create all files and install dependencies using [Composer](https://getcomposer.org/doc/00-intro.md)

Once it’s done, the app should be available at [127.0.0.1](127.0.0.1:80)

Congratulations 🎉 You can now start build your app!

## Services
In Docker Desktop, you can see three containers in the iut-laravel stack.
- laravel: this is where you application live
- redis: will be used later, see it as a NoSQL database for caching
- mailpit: will be used later too for email development and can be seen at [127.0.0.1:8025](127.0.0.1:8025)