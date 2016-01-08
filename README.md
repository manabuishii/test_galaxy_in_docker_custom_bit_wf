# test_galaxy_in_docker_custom_bit_wf

test Galaxy in docker custom bit workflow.

# How to run

## webdriver-ruby

* [hunk4ths/webdriver-ruby](https://github.com/hunk4ths/webdriver-ruby)
* [Docker Hub](https://hub.docker.com/r/ebeltran/webdriver-ruby/)

# command line

```
git clone https://github.com/manabuishii/test_galaxy_in_docker_custom_bit_wf.git
docker run --net=host --rm -v $PWD:/work ebeltran/webdriver-ruby ruby /work/test_galaxy.rb http://localhost:10500
```
