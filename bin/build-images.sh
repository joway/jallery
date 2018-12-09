# /bin/bash
find ./public/raw -mindepth 2 -maxdepth 2 -type f -name '*.png' -o -name '*.jpg' -exec sh -c '
  rm -rf ./public/photos
  for f do
    source=$f
    output=${source/raw/photos}
    base=`basename $output`
    dirname=${output/$base/''}
    mkdir -p $dirname
    echo "add watermark: from $source to $output"
    convert -resize 2073600@ $source $output
    width=`identify -format %w $output`
    height=`identify -format %h $output`
    convert -strip -interlace Plane -quality 70% -background 'none'  -fill white -gravity center \
      -size $(expr ${width} / 10)x$(expr ${height} / 36) \
      caption:"@Joway Wang" \
      "$output" +swap -gravity south -geometry +0+$(expr ${height} / 100) -composite "$output"
  done
' sh {} +
