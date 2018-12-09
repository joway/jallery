# /bin/bash
find ./public/photos -mindepth 2 -maxdepth 2 -type f -name '*.png' -o -name '*.jpg' -exec sh -c '
  for f do
    echo "add watermark: $f"
    source=$f
    convert -resize 2073600@ $source $source
    width=`identify -format %w $source`
    height=`identify -format %h $source`
    convert -strip -interlace Plane -quality 70% -background 'none'  -fill white -gravity center \
      -size $(expr ${width} / 10)x$(expr ${height} / 36) \
      caption:"@Joway Wang" \
      $source +swap -gravity south -geometry +0+$(expr ${height} / 100) -composite $source
  done
' sh {} +
