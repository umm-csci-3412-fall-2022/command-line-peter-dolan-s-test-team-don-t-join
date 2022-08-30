#!/bin/bash
tempdir=$( mktemp -d )

tar zxf $1 -C $tempdir

function should_delete {
	grep "DELETE ME!" $1
}

keep_files=$( ls $tempdir | xargs -I{} sh -c test 0 -eq $())
echo $keep_files

for check_file in $( ls $tempdir/little_dir )
do
	grep "DELETE ME!" $tempdir/little_dir/$check_file > /dev/null 2> /dev/null
	return_value=$?
	
	if test $return_value -eq 0
 	then
		rm $tempdir/little_dir/$check_file
		continue
	fi
done

pushd $(pwd) > /dev/null
cd $tempdir
tar zcf cleaned_$1  little_dir
popd > /dev/null
cp $tempdir/cleaned_$1 cleaned_$1

rm -rf tempdir

