# docker-linphone
Linpphone Docker

Run [linphone](http://www.linphone.org/) in Docker.

enable docker service on boot
```
$ sudo systemctl enable docker
$ sudo systemctl start docker
```
## Examples

### Run interactively

```
$ sudo docker run -it --rm develpudu/linphone-docker
```

### Enable sound (ALSA)

Adapted from [here](https://stackoverflow.com/questions/28985714/run-apps-using-audio-in-a-docker-container)

```
$ sudo docker run -it --rm -v /dev/snd:/dev/snd --privileged develpudu/linphone-docker
```

### Auto Answer

Adapted from [here](https://stackoverflow.com/questions/28985714/run-apps-using-audio-in-a-docker-container)

```
$ sudo docker run -it --rm develpudu/linphone-docker /bin/bash -c 'linphonec -a'
```

### Run daemonized (with remote control)

```
$ sudo docker run --rm -d --name linphone develpudu/linphone-docker /bin/bash -c 'linphonecsh init && tail -f /dev/null'
```

### Remotely answer a call

```
$ sudo docker exec linphone /bin/bash -c 'linphonecsh generic answer'
```

### Remotely hangup a call

```
$ sudo docker exec linphone /bin/bash -c 'linphonecsh generic terminate'
```
### Info
Adapted from [here](https://github.com/szengerle/linphone-docker)
Adapted from [here](https://github.com/phillin77/docker-linphone)
Adapted from [here](https://github.com/dwilkie/linphone-docker)
Adapted from [here](https://github.com/rjohnsondev/linphone-docker)