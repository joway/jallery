# /bin/bash
# imagic -p 10 -q 70 -o ./public/photos  ./public/raw/**/*
rm -rf ./public/photos
find ./public/raw -mindepth 1 -maxdepth 1 -type d -exec sh -c '
  for f do
    source=$f
    output=`echo $source | sed "s/raw/photos/g"`
    imagic compress -p 10 -q 70 -o $output  $source/*
    imagic resize -w 2000 -p 10  $output/*
    imagic watermark -x -1100 -y -100 \
      -t ./public/texture.png \
      -p 10 $output/*
    imagic resize -w 480 -p 10 -s .thumbnail  $output/*
  done
' sh {} +
