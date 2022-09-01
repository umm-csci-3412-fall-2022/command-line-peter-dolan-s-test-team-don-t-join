#!/bin/bash
tempdir=$( mktemp -d )

tar zxf $1 -C $tempdir

pushd $(pwd) > /dev/null
cd $tempdir
grep -rl "DELETE ME!" | xargs rm
tar zcf cleaned_$1 *
popd > /dev/null
cp $tempdir/cleaned_$1 cleaned_$1

rm -rf tempdir
tar -tf cleaned_$1
