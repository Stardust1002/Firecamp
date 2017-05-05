# Firecamp

Data Science &amp; Big Data project generator for Humans.

### Why use it

Because it is always painful to set up a cluster network, to keep track of your python libraries, to install them on all the Spark nodes, to link everything together (Jupyter, Spark, Cassandra..), to lose your work because of a bad manipulation, to feel uncomfortable working in an environment without any of your tools and where it is relatively hard to set or load something up, to feel frustrated when you think about redoing all of that EVERY TIME you edit a configuration file or add a dependency, whereas you just want to have fun and enjoy Data Science & Big Data technologies.

Powered by Docker and micro services, Firecamp sets up your dev environment and runs a big data cluster locally while taking care of all the plumbing.
It allows you to focus on what matters most: exploring data &amp; enjoying cutting edge technologies such as Spark and Cassandra.
Firecamp allows you to get any of your crazy ideas up and running in no time.

Right now, Firecamp is shipped with:
- a Spark (2.1.0) Cluster containing the Spark Master and 3 Spark Workers (with 2GB of memory each)
- a Cassandra (latest release) Cluster containing 2 Cassandra Seeds (with 1GB of memory each)
- a Data Science Jupyter notebook based on [pyspark-notebook](https://github.com/jupyter/docker-stacks/tree/master/pyspark-notebook) fueled with Python3, Scala (thanks to [Apache Toree](https://toree.apache.org), the NLTK, spacy & TreeTagger Python3 libraries for Natural Language Processing tasks. (with French & English models loaded)

Moreover, the requirements.txt and additional_setup.txt files allow you to keep track of your favorites libraries and to seamlessly install them on each Spark node + Jupyter.


### How to use it

#### First launch
Open a terminal and run the following to clone this repo and go into the Firecamp folder.
```bash
git clone https://github.com/Stardust1002/Firecamp.git && cd Firecamp
```
Then run
```bash
make
```

After a lot of gibberish, hit CTRL + SHIFT + F (on Unix) or CTRL +F (on OSX) to find this line:
 http://localhost:8888/?token= then open it with your web navigator.

What's next ? Nothing, you're all set to start working !

#### Further Launchs
Open a terminal and run the following to just run the alread built containers with the already prepared workspace.
```bash
make run
```

###### What if I run a simple "make" whereas I've already had some work done.. ?

You'll just rebuild your images (which is pretty fast if you didn't edit them) but ALL your workspace will stay INTACT without any modification.

#### Details

By default, the make command set your environment up, then build the images whose Dockerfiles are present in docker/Dockerfiles/ before running the different containers thanks to docker compose.
It is equivalent to this sequence of commands:
```bash
make setup # Set up the environment
make build # (re)build the different images
make run # Run the containers via the docker-compose.yml file
```

There is also a backup command to save the workspace into a "backups/{CURRENT_TIME}" directory at the project root.
```bash
make backup # Make a backup copy of the workspace in the ./backups/{CURRENT_TIME} directory"
```
By default, the "make run" command (hence "make") makes a backup copy of the workspace in the "backups/previous_run" directory, which is overwritten after each "make run".
#### Base Architecture

The project is shipped with only one directory (originally called "docker") and a Makefile at the project root.
```
├── Makefile
├── docker
│   ├── docker-compose.yml
│   ├── Dockerfiles
│   │   ├── additional_setup.txt        # Shell script to install specific libraries (e.g. NLTK, TreeTagger and Spacy models)
│   │   ├── requirements.txt            # Python Pip requirements file
│   │   ├── Makefile                    # Commands to (re)build the jupyter & spark images
│   │   ├── jupyter
│   │   │   └── Dockerfile              # Extension of the pyspark-notebook
│   │   └── spark
│   │       ├── Dockerfile              # Spark Dockerfile used to build specific spark nodes
│   │       └── spark-defaults.conf     # Spark Nodes configurations file
│   ├── Examples                        # Directory of example files copied to the work/ directory after running "make"
│   │   ├── python_example.ipynb        # Pyspark example file showing how to connect to the cassandra cluster
│   │   └── scala_example.ipynb         # Scala Spark example file showing how to connect to the cassandra cluster
│   └── Scripts                         # Shells cripts called by the root Makefile (hence the make command)
│       ├── run.sh                      # <=> make run
│       ├── save.sh                     # <=> make backup
│       └── setup.sh                    # <=> make setup
├── LICENSE
└── README.md

```
#### Workspace Architecture

The "make build" (hence "make") command sets up a workspace called "./work/" at the project root.

```
├── Makefile
├── docker
└── work
    ├── Examples                        # Directory of example files copied to the work/ directory after running "make"
    │   ├── python_example.ipynb
    │   └── scala_example.ipynb
    └── project-conf                        # Project configurations files (hard symbolic links)
        ├── python
        │   ├── additional_setup.txt
        │   └── requirements.txt
        └── spark
            └── spark-defaults.conf
```

By default, the entire work directory and subdirectories are shared with Jupyter and Spark Nodes. (see Docker shared volumes)
This allows the user to directly load data into Spark without having to upload and broadcast data all over the cluster.

Moreover, the user can access and edit every file from Jupyter, especially the project configurations files located in the "project-conf" directory. As a result, one can edit configurations files in a simple way.
Also, the configurations files are actually hard symbolic links, meaning that any edit done on these files are automatically done on the Base Architecture configurations files.

In a nutshell, all the hidden plumbing allows Data Scientists to edit base images, rebuild them, change configurations files, add containers etc. without NEVER losing any of their work and configurations. (+ the automatic backup copies)

### Further Improvements

* Write an exhaustive documentation and a FAQ section
* Add new Big Data stacks
* Create a Docker Compose file generator to choose a stack and the number of Spark/Cassandra/wtv nodes to run via a command line
* Add more code examples
* Improve the existing docker and docker-compose.yml files
* Think really hard about Kubernetes
