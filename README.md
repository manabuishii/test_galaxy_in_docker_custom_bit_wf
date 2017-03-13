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

# Data setup information

* transcriptome_ref_fasta -> fasta

* quartz_div100_rename -> fastqsanger

* adapter_primer -> fasta

# About workflow and memory settings

* sailfish 0.9 workflow maybe needs 8GB or higher (10GB is ok)
* hisat2 tophat2 requires 32GB or higher
