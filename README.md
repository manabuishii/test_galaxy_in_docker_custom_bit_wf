# test_galaxy_in_docker_custom_bit_wf

test Galaxy in docker custom bit workflow.

# How to run

## webdriver-ruby

* [hunk4ths/webdriver-ruby](https://github.com/hunk4ths/webdriver-ruby)
* [Docker Hub](https://hub.docker.com/r/ebeltran/webdriver-ruby/)

# command line

```
git clone https://github.com/manabuishii/test_galaxy_in_docker_custom_bit_wf.git
cd test_galaxy_in_docker_custom_bit_wf
docker run --net=host --rm -v $PWD:/work ebeltran/webdriver-ruby ruby /work/test_galaxy.rb YOURGALAXYHOST
```
# docker-machine

```
./run-container.sh YOURDOCKERMACHINE TESTSCRIPT YOURGALAXYHOST
```

# Script Debug information

When you delete histories from GUI and not switch to some existing history,
Galaxy create new history and test code create one more history.
So there is empty ***Unnamed history***.
