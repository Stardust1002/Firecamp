#!bin/bash
DIR=$PWD/work
if [ -d "$DIR" ]; then
  echo "Workspace already set up at: $DIR";
  exit;
else
  {
    echo "Setting up the workspace..";
    mkdir -p work/project-conf/spark/
    mkdir -p work/project-conf/python/
    chmod a+rw -R work/
    echo "The Workspace was successfully set up.";
  } || {
    echo "An error happened during the set up."
  }
fi
