# Screeps Egg for Pterodactyl

Wraps [screepers/screeps-launcher](https://github.com/screepers/screeps-launcher/tree/main) to create a Pterodactyl compatible Egg for Screeps.

## Limitations

- At the moment only the default game and cli ports are supported. I'm not sure how to change the game port with `screeps-launcher`.

## Pterodactyl Configuration

### Variables
- `STEAM_KEY`: **(Required)** variable must be set to your steam API key.
- `MODS_LIST` variable set to a comma separated list of mods to include in the server. These should be formatted like you would find on [screeps-launcher repo](https://github.com/screepers/screeps-launcher/tree/main). E.g. `screepsmod-auth,screepsmod-admin-utils,...`.
- `BOTS_LIST` variable set to a comma separate list of bots to include in the server. These also should be formatted like you would fine on [screeps-launcher repo](https://github.com/screepers/screeps-launcher/tree/main). E.g. `simplebot: screepsbot-zeswarm,...`.
- `WELCOME_TEXT` only required if using the `screepsmod-admin-utils` mod. Sets the servers welcome text. It should be `html` formatted. E.g. `<h1 style="text-align: center;">Screeps Server</h1>`.
- `TICK_RATE` only required if using the `screepsmod-admin-utils` mod. Sets the server tick rate in milliseconds.
- `MONGO_HOST`, `MONGO_PORT`, `REDIS_HOST`, `REDIS_PORT` only required if using the `screepsmod-mongo` mod. If so, make sure to check the below "Mod Notes" section.

### Mod Notes

#### screepsmod-mongo
If using `screepsmod-mongo`, then you must setup a `mongodb` and `redis` server. A docker compose configuration already exists for this in the `database` directory of the repo. Steps to run are:

1. Clone the repo. Move into the `database` directory.

2. Copy the `.env.example` file to `.env` and fill in/change any of the variables.

3. Run `sudo docker-compose up -d` or `docker compose up -d`, depending on your compose version, to launch the services.

4. Get the docker IP with `ip a show docker0`. In this example it is `172.17.0.1`.
```
6: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether ...
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 .../64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
```

5. Make sure to set the `screepsmod-mongo` related variables in Pterodactyl. For this example it would be:
- `MONGO_HOST`: `172.17.0.1`
- `MONGO_PORT`: `27017`
- `REDIS_HOST`: `172.17.0.1`
- `REDIS_PORT`: `6379`
