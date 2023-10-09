#!/usr/bin/env bash

PROJECTS=(libpng sqlite3 openssl)
#PROJECTS=(openssl)

prepare_project() {
    proj=$1

    proj_dir=`pwd`/targets/"$proj"

    export TARGET=$proj_dir
    export OUT=$TARGET/out
    export CC="gcc"
    export CXX="g++"

    mkdir -p $OUT

    # fetch
    pushd $proj_dir
    ./fetch.sh
    popd

    # patch - introduce the bugs
    ./magma/apply_patches.sh

    # build - sanity check
    pushd $proj_dir
    bear ./build.sh
    popd
}

for p in $PROJECTS ; do
    echo "Preparing project $p"
    prepare_project "$p"
done
