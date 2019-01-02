# /bin/bash
find ./public/raw -mindepth 2 -maxdepth 2 -type f -name '*.png' -name '*.jpg' -o -exec sh -c '
  rm -rf ./public/photos
  for f do
    source=$f
    output=`echo $source | sed "s/raw/photos/g"`
    base=`basename $output`
    dirname=`echo $output | sed "s/$base/''/g"`
    mkdir -p $dirname
    echo "add watermark: from $source to $output"
    convert -resize 2073600@ $source $output
    width=`identify -format %w $output`
    height=`identify -format %h $output`
    convert -strip -interlace Plane -quality 70% -background 'none'  -fill white -gravity center \
      -size $(expr ${width} / 10)x$(expr ${height} / 36) \
      caption:"@Joway" \
      "$output" +swap -gravity south -geometry +0+$(expr ${height} / 100) -composite "$output"
  done
' sh {} +
