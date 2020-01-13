find . -type f ! -iname "rename.sh" | cut -c3- | while read FILE ; do
     echo ${FILE}
    newfile="$(echo ${FILE} |sed -e 's/.*/0.6_&/')" ;
    mv "${FILE}" "${newfile}" ;
done 
